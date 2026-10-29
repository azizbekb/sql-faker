-- =====================================================================
-- SQL Faker :: data maintenance, lookup and formatting helpers
-- =====================================================================

-- Bulk-insert vocabulary. p_list is '|' separated; an item may carry a
-- weight after '^', e.g. 'Brown^45|Blue^27|Green^9'. Duplicates are ignored.
CREATE OR REPLACE PROCEDURE fk_add_words(p_locale text, p_category text, p_list text)
LANGUAGE sql AS $$
    INSERT INTO words (locale, category, value, weight)
    SELECT p_locale, p_category,
           btrim(split_part(item, '^', 1), E' \t\r\n'),
           coalesce(nullif(btrim(split_part(item, '^', 2), E' \t\r\n'), '')::float8, 1)
    FROM unnest(string_to_array(p_list, '|')) AS item
    WHERE btrim(split_part(item, '^', 1), E' \t\r\n') <> ''
    ON CONFLICT (locale, category, value) DO NOTHING
$$;

-- Bulk-insert cities. p_list is ';' separated rows of
-- 'City|Region|REGION_CODE|postal pattern[|weight]'.
CREATE OR REPLACE PROCEDURE fk_add_cities(p_locale text, p_list text)
LANGUAGE sql AS $$
    INSERT INTO cities (locale, city, region, region_code, postal, weight)
    SELECT p_locale,
           btrim(split_part(r, '|', 1), E' \t\r\n'), btrim(split_part(r, '|', 2), E' \t\r\n'),
           btrim(split_part(r, '|', 3), E' \t\r\n'), btrim(split_part(r, '|', 4), E' \t\r\n'),
           coalesce(nullif(btrim(split_part(r, '|', 5), E' \t\r\n'), '')::float8, 1)
    FROM unnest(string_to_array(p_list, ';')) AS r
    WHERE btrim(r, E' \t\r\n') <> ''
    ON CONFLICT (locale, city, region_code) DO NOTHING
$$;

-- Recomputes ord / cumulative weights and category sizes.
-- Must be called after any change to `words` or `cities`.
CREATE OR REPLACE PROCEDURE fk_reindex()
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE words w SET ord = x.ord, cum_hi = x.cum_hi
    FROM (SELECT id,
                 row_number() OVER win AS ord,
                 sum(weight)  OVER win AS cum_hi
          FROM words
          WINDOW win AS (PARTITION BY locale, category ORDER BY id)) x
    WHERE w.id = x.id;

    UPDATE cities c SET cum_hi = x.cum_hi
    FROM (SELECT id, sum(weight) OVER (PARTITION BY locale ORDER BY id) AS cum_hi
          FROM cities) x
    WHERE c.id = x.id;

    DELETE FROM category_sizes;
    INSERT INTO category_sizes (locale, category, n, total_weight)
    SELECT locale, category, count(*), sum(weight) FROM words GROUP BY locale, category
    UNION ALL
    SELECT locale, '@cities', count(*), sum(weight) FROM cities GROUP BY locale;

    ANALYZE words; ANALYZE cities; ANALYZE category_sizes;
END $$;

-- Weighted random pick from words(locale, category).
-- Draws r = U * total_weight and returns the first row whose running
-- weight sum exceeds r (inverse-CDF sampling over a discrete distribution,
-- one index range scan on (locale, category, cum_hi)).
-- Returns NULL when the category does not exist for the locale.
CREATE OR REPLACE FUNCTION fk_pick(p_locale text, p_category text, p_key text, p_stream int)
RETURNS text LANGUAGE sql STABLE STRICT PARALLEL SAFE AS $$
    SELECT w.value
    FROM category_sizes s
    CROSS JOIN LATERAL (
        SELECT value FROM words w
        WHERE w.locale = s.locale AND w.category = s.category
          AND w.cum_hi > fk_random(p_key, p_stream) * s.total_weight
        ORDER BY w.cum_hi
        LIMIT 1) w
    WHERE s.locale = p_locale AND s.category = p_category
$$;

-- Weighted random city (same algorithm as fk_pick).
CREATE OR REPLACE FUNCTION fk_pick_city(p_locale text, p_key text, p_stream int)
RETURNS cities LANGUAGE sql STABLE STRICT PARALLEL SAFE AS $$
    SELECT c.*
    FROM category_sizes s
    CROSS JOIN LATERAL (
        SELECT * FROM cities c
        WHERE c.locale = s.locale
          AND c.cum_hi > fk_random(p_key, p_stream) * s.total_weight
        ORDER BY c.cum_hi
        LIMIT 1) c
    WHERE s.locale = p_locale AND s.category = '@cities'
$$;

-- Replaces {name} placeholders in a template.
--   fk_render('{first} {last}', ARRAY['first','last'], ARRAY['Ann','Lee'])
-- NULL values become ''. Repeated / leading / trailing spaces are squeezed.
CREATE OR REPLACE FUNCTION fk_render(p_template text, p_names text[], p_values text[])
RETURNS text LANGUAGE plpgsql IMMUTABLE PARALLEL SAFE AS $$
DECLARE
    result text := p_template;
    i      int;
BEGIN
    FOR i IN 1 .. coalesce(array_length(p_names, 1), 0) LOOP
        result := replace(result, '{' || p_names[i] || '}', coalesce(p_values[i], ''));
    END LOOP;
    RETURN trim(regexp_replace(result, '\s{2,}', ' ', 'g'));
END $$;

-- Makes a string usable in an e-mail local part: lower case, German
-- umlauts expanded (ä -> ae, ß -> ss), other diacritics stripped, and
-- anything outside [a-z0-9] removed.
CREATE OR REPLACE FUNCTION fk_transliterate(p_text text)
RETURNS text LANGUAGE sql IMMUTABLE STRICT PARALLEL SAFE AS $$
    SELECT regexp_replace(
             translate(
               replace(replace(replace(replace(lower(p_text),
                 'ä', 'ae'), 'ö', 'oe'), 'ü', 'ue'), 'ß', 'ss'),
               'áàâãåéèêëíìîïóòôõøúùûýÿçñ',
               'aaaaaeeeeiiiiooooouuuyycn'),
             '[^a-z0-9]', '', 'g')
$$;

-- Rebuilds the first-order Markov chain of a locale from text_corpus.
-- Tokens are whitespace separated words (punctuation stays attached), so
-- a token ending in . ! or ? terminates a sentence and the next token is
-- recorded as a successor of '' (sentence start).
CREATE OR REPLACE PROCEDURE fk_build_markov(p_locale text)
LANGUAGE sql AS $$
    DELETE FROM markov_chain WHERE locale = p_locale;

    INSERT INTO markov_chain (locale, word, successors)
    WITH tokens AS (
        SELECT c.id, t.n, t.tok
        FROM text_corpus c,
             regexp_split_to_table(trim(c.body), '\s+') WITH ORDINALITY AS t(tok, n)
        WHERE c.locale = p_locale AND t.tok <> ''
    ), pairs AS (
        SELECT id, n, tok,
               CASE WHEN prev IS NULL OR prev ~ '[.!?]$' THEN '' ELSE prev END AS word
        FROM (SELECT id, n, tok, lag(tok) OVER (PARTITION BY id ORDER BY n) AS prev
              FROM tokens) x
    )
    SELECT p_locale, word, array_agg(tok ORDER BY id, n)
    FROM pairs
    GROUP BY word;
$$;
