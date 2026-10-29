-- =====================================================================
-- SQL Faker :: field generators and the public API
--
-- Each generator takes the record key (see fk_record_key) and appends its
-- own field suffix (':name', ':addr', ...). Fields therefore never share
-- random streams, and changing one generator never changes another field.
-- =====================================================================

-- ------------------------------------------------------------ gender
CREATE OR REPLACE FUNCTION fk_gender(p_key text)
RETURNS char(1) LANGUAGE sql IMMUTABLE STRICT PARALLEL SAFE AS $$
    SELECT CASE WHEN fk_random_bool(p_key || ':gender', 0, 0.5) THEN 'M' ELSE 'F' END
$$;

-- ------------------------------------------------------------- name
-- 1. pick a layout from fmt_name (weighted, e.g. '{title} {first} {mi}. {last}')
-- 2. pick first / last name for the gender
-- 3. pick only the optional parts the layout really uses
--    (middle name != first name, second surname, title, academic degree, suffix)
CREATE OR REPLACE FUNCTION fk_full_name(p_locale text, p_key text, p_gender char(1),
        OUT full_name text, OUT first_name text, OUT last_name text)
LANGUAGE plpgsql STABLE STRICT PARALLEL SAFE AS $$
DECLARE
    k        text := p_key || ':name';
    tpl      text;
    v_middle text;
    v_last2  text;
    v_title  text;
    v_acad   text;
    v_suffix text;
BEGIN
    tpl        := fk_pick(p_locale, 'fmt_name', k, 0);
    first_name := fk_pick(p_locale, 'first_name_' || p_gender, k, 1);
    last_name  := fk_pick(p_locale, 'last_name', k, 2);

    IF strpos(tpl, '{middle}') > 0 OR strpos(tpl, '{mi}') > 0 THEN
        v_middle := fk_pick(p_locale, 'first_name_' || p_gender, k, 3);
        IF v_middle = first_name THEN
            v_middle := fk_pick(p_locale, 'first_name_' || p_gender, k, 4);
        END IF;
    END IF;
    IF strpos(tpl, '{last2}') > 0 THEN
        v_last2 := fk_pick(p_locale, 'last_name', k, 5);
        IF v_last2 = last_name THEN
            v_last2 := fk_pick(p_locale, 'last_name', k, 6);
        END IF;
    END IF;
    IF strpos(tpl, '{title}')  > 0 THEN v_title  := fk_pick(p_locale, 'title_' || p_gender, k, 7);  END IF;
    IF strpos(tpl, '{acad}')   > 0 THEN v_acad   := fk_pick(p_locale, 'academic', k, 8);            END IF;
    IF strpos(tpl, '{suffix}') > 0 THEN v_suffix := fk_pick(p_locale, 'suffix_' || p_gender, k, 9); END IF;

    full_name := fk_render(tpl,
        ARRAY['first', 'middle', 'mi', 'last', 'last2', 'title', 'acad', 'suffix'],
        ARRAY[first_name, v_middle, left(v_middle, 1), last_name, v_last2, v_title, v_acad, v_suffix]);

    IF v_last2 IS NOT NULL THEN
        last_name := last_name || '-' || v_last2;
    END IF;
END $$;

-- ----------------------------------------------------------- address
-- City (with region and postal pattern) is picked from `cities`, the
-- layout from fmt_address; the parts referenced by the layout are picked
-- from the locale's street vocabulary and digit patterns are filled.
CREATE OR REPLACE FUNCTION fk_address(p_locale text, p_key text,
        OUT address text, OUT city text, OUT region text, OUT postal_code text)
LANGUAGE plpgsql STABLE STRICT PARALLEL SAFE AS $$
DECLARE
    k   text := p_key || ':addr';
    c   cities;
    tpl text;
    v_number text; v_street text; v_suffix text; v_dir text; v_unit text;
    v_adj text; v_type text; v_full text; v_letter text;
BEGIN
    c           := fk_pick_city(p_locale, k, 0);
    tpl         := fk_pick(p_locale, 'fmt_address', k, 1);
    city        := c.city;
    region      := c.region;
    postal_code := fk_random_digits(c.postal, k, 100);
    v_number    := fk_random_digits(fk_pick(p_locale, 'house_number', k, 2), k, 200);

    IF strpos(tpl, '{street}') > 0 THEN v_street := fk_pick(p_locale, 'street_name',   k, 3); END IF;
    IF strpos(tpl, '{suffix}') > 0 THEN v_suffix := fk_pick(p_locale, 'street_suffix', k, 4); END IF;
    IF strpos(tpl, '{dir}')    > 0 THEN v_dir    := fk_pick(p_locale, 'street_dir',    k, 5); END IF;
    IF strpos(tpl, '{unit}')   > 0 THEN
        v_unit := fk_random_digits(fk_pick(p_locale, 'unit', k, 6), k, 300);
    END IF;
    IF strpos(tpl, '{adj}')    > 0 THEN v_adj    := fk_pick(p_locale, 'street_adj',    k, 7); END IF;
    IF strpos(tpl, '{type}')   > 0 THEN v_type   := fk_pick(p_locale, 'street_type',   k, 8); END IF;
    IF strpos(tpl, '{full}')   > 0 THEN v_full   := fk_pick(p_locale, 'street_full',   k, 9); END IF;
    IF strpos(tpl, '{letter}') > 0 THEN v_letter := fk_pick(p_locale, 'house_letter',  k, 10); END IF;

    address := fk_render(tpl,
        ARRAY['number', 'street', 'suffix', 'dir', 'unit', 'adj', 'type', 'full', 'letter',
              'city', 'state', 'state_code', 'zip'],
        ARRAY[v_number, v_street, v_suffix, v_dir, v_unit, v_adj, v_type, v_full, v_letter,
              c.city, c.region, c.region_code, postal_code]);
END $$;

-- -------------------------------------------------------- geolocation
-- Uniform on the sphere, rounded to 6 decimals (~0.1 m).
CREATE OR REPLACE FUNCTION fk_geolocation(p_key text,
        OUT latitude numeric, OUT longitude numeric)
LANGUAGE plpgsql IMMUTABLE STRICT PARALLEL SAFE AS $$
DECLARE
    s record := fk_random_sphere(p_key || ':geo', 0);
BEGIN
    latitude  := round(s.latitude::numeric, 6);
    longitude := round(s.longitude::numeric, 6);
END $$;

-- -------------------------------------------------------------- phone
CREATE OR REPLACE FUNCTION fk_phone(p_locale text, p_key text)
RETURNS text LANGUAGE sql STABLE STRICT PARALLEL SAFE AS $$
    SELECT fk_random_digits(fk_pick(p_locale, 'fmt_phone', p_key || ':phone', 0),
                            p_key || ':phone', 1)
$$;

-- ------------------------------------------------------------- e-mail
-- Local part from an fmt_email layout using the person's (transliterated)
-- names, optional digits / birth-year-like suffix; then a weighted domain.
CREATE OR REPLACE FUNCTION fk_email(p_locale text, p_key text, p_first text, p_last text)
RETURNS text LANGUAGE plpgsql STABLE STRICT PARALLEL SAFE AS $$
DECLARE
    k     text := p_key || ':mail';
    first text := fk_transliterate(p_first);
    last  text := fk_transliterate(p_last);
BEGIN
    RETURN fk_render(fk_pick(p_locale, 'fmt_email', k, 0),
               ARRAY['first', 'last', 'f', 'l', 'nn', 'nnn', 'yy'],
               ARRAY[first, last, left(first, 1), left(last, 1),
                     fk_random_digits('##', k, 10),
                     fk_random_digits('@##', k, 20),
                     lpad((fk_random_int(k, 3, 50, 109) % 100)::text, 2, '0')])
           || '@' || fk_pick(p_locale, 'email_domain', k, 4);
END $$;

-- ------------------------------------------------ physical attributes
-- age, height (cm) and BMI are normal (Box-Muller) with locale/gender
-- specific parameters from `distributions`, clamped to a sane range;
-- weight = BMI * height(m)^2, so it is correlated with height.
-- eye / hair colour and blood type are weighted discrete picks.
CREATE OR REPLACE FUNCTION fk_physical(p_locale text, p_key text, p_gender char(1),
        OUT age int, OUT height_cm numeric, OUT weight_kg numeric,
        OUT eye_color text, OUT hair_color text, OUT blood_type text, OUT summary text)
LANGUAGE plpgsql STABLE STRICT PARALLEL SAFE AS $$
DECLARE
    k        text := p_key || ':body';
    v_bmi    float8;
    v_units  text;
    inches   int;
BEGIN
    SELECT round(max(fk_random_normal_clamped(k, 0, d.mean, d.sd, d.min_value, d.max_value))
                     FILTER (WHERE d.attribute = 'age')),
           round(max(fk_random_normal_clamped(k, 1, d.mean, d.sd, d.min_value, d.max_value))
                     FILTER (WHERE d.attribute = 'height_cm')::numeric, 1),
           max(fk_random_normal_clamped(k, 2, d.mean, d.sd, d.min_value, d.max_value))
                     FILTER (WHERE d.attribute = 'bmi'),
           max(l.units)
      INTO age, height_cm, v_bmi, v_units
      FROM distributions d JOIN locales l ON l.code = d.locale
     WHERE d.locale = p_locale AND d.gender = p_gender;

    weight_kg  := round((v_bmi * (height_cm / 100.0) ^ 2)::numeric, 1);
    eye_color  := fk_pick(p_locale, 'eye_color',  k, 3);
    hair_color := fk_pick(p_locale, 'hair_color', k, 4);
    blood_type := fk_pick(p_locale, 'blood_type', k, 5);

    IF v_units = 'imperial' THEN
        inches  := round(height_cm / 2.54);
        summary := format('%s′%s″, %s lb', inches / 12, inches % 12, round(weight_kg * 2.20462));
    ELSE
        summary := format('%s cm, %s kg', round(height_cm), round(weight_kg));
    END IF;
END $$;

-- -------------------------------------------------- Markov chain text
-- Random walk over markov_chain:
--   * start from '' (sentence start),
--   * next word = successors[1 + floor(U * n)]  (uniform over the array =
--     proportional to bigram frequency in the corpus),
--   * a word ending in . ! ? closes the sentence and the walk restarts
--     from ''; a sentence reaching p_max_words words is closed with '.',
--   * stop after p_sentences sentences.
-- One primary-key lookup per generated word.
CREATE OR REPLACE FUNCTION fk_markov_text(p_locale text, p_key text,
        p_sentences int DEFAULT 2, p_max_words int DEFAULT 25)
RETURNS text LANGUAGE plpgsql STABLE STRICT PARALLEL SAFE AS $$
DECLARE
    k         text := p_key || ':text';
    cur       text := '';
    nxt       text;
    succ      text[];
    words     text[] := '{}';
    sentences int := 0;
    in_sent   int := 0;
    step      int := 0;
BEGIN
    WHILE sentences < p_sentences LOOP
        SELECT successors INTO succ FROM markov_chain WHERE locale = p_locale AND word = cur;
        IF succ IS NULL THEN                    -- dead end or no corpus for locale
            EXIT WHEN cur = '';
            nxt := cur;                         -- close the current sentence
            words[cardinality(words)] := rtrim(nxt, ',;:') || '.';
            sentences := sentences + 1; in_sent := 0; cur := '';
            CONTINUE;
        END IF;

        nxt  := succ[1 + floor(fk_random(k, step) * cardinality(succ))::int];
        step := step + 1;
        in_sent := in_sent + 1;

        IF nxt ~ '[.!?]$' THEN
            sentences := sentences + 1; in_sent := 0; cur := '';
        ELSIF in_sent >= p_max_words THEN
            nxt := rtrim(nxt, ',;:') || '.';
            sentences := sentences + 1; in_sent := 0; cur := '';
        ELSE
            cur := nxt;
        END IF;
        words := words || nxt;
    END LOOP;
    RETURN array_to_string(words, ' ');
END $$;

-- ============================================================ public API

-- One fake user at an absolute position of the (locale, seed) sequence.
CREATE OR REPLACE FUNCTION fk_user(p_locale text, p_seed bigint, p_position bigint,
        OUT "position" bigint, OUT gender char(1),
        OUT full_name text, OUT first_name text, OUT last_name text,
        OUT address text, OUT city text, OUT region text, OUT postal_code text,
        OUT latitude numeric, OUT longitude numeric,
        OUT phone text, OUT email text,
        OUT age int, OUT height_cm numeric, OUT weight_kg numeric,
        OUT eye_color text, OUT hair_color text, OUT blood_type text, OUT physical text,
        OUT bio text)
LANGUAGE plpgsql STABLE STRICT PARALLEL SAFE AS $$
DECLARE
    k text := fk_record_key(p_locale, p_seed, p_position);
BEGIN
    "position" := p_position;
    gender     := fk_gender(k);
    SELECT n.full_name, n.first_name, n.last_name INTO full_name, first_name, last_name
        FROM fk_full_name(p_locale, k, gender) n;
    SELECT a.address, a.city, a.region, a.postal_code INTO address, city, region, postal_code
        FROM fk_address(p_locale, k) a;
    SELECT g.latitude, g.longitude INTO latitude, longitude FROM fk_geolocation(k) g;
    phone := fk_phone(p_locale, k);
    email := fk_email(p_locale, k, first_name, last_name);
    SELECT b.age, b.height_cm, b.weight_kg, b.eye_color, b.hair_color, b.blood_type, b.summary
        INTO age, height_cm, weight_kg, eye_color, hair_color, blood_type, physical
        FROM fk_physical(p_locale, k, gender) b;
    bio := fk_markov_text(p_locale, k, fk_random_int(k || ':bio', 0, 1, 2), 20);
END $$;

-- A batch of fake users: positions batch*size .. batch*size + size - 1.
-- This is what the web application calls.
CREATE OR REPLACE FUNCTION fk_users(p_locale text, p_seed bigint, p_batch int,
        p_batch_size int DEFAULT 10)
RETURNS TABLE (batch_index int, index_in_batch int, "position" bigint, gender char(1),
        full_name text, first_name text, last_name text,
        address text, city text, region text, postal_code text,
        latitude numeric, longitude numeric, phone text, email text,
        age int, height_cm numeric, weight_kg numeric,
        eye_color text, hair_color text, blood_type text, physical text, bio text)
LANGUAGE plpgsql STABLE STRICT PARALLEL SAFE AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM locales WHERE code = p_locale) THEN
        RAISE EXCEPTION 'Unknown locale "%"', p_locale USING ERRCODE = 'invalid_parameter_value';
    END IF;
    IF p_batch < 0 OR p_batch_size < 1 OR p_batch_size > 10000 THEN
        RAISE EXCEPTION 'batch must be >= 0 and batch size in 1..10000'
            USING ERRCODE = 'invalid_parameter_value';
    END IF;

    RETURN QUERY
    SELECT p_batch, i, u.*
    FROM generate_series(0, p_batch_size - 1) AS i
    CROSS JOIN LATERAL fk_user(p_locale, p_seed, p_batch::bigint * p_batch_size + i) AS u
    ORDER BY i;
END $$;

-- Generation speed in users / second (whole records, all fields).
CREATE OR REPLACE FUNCTION fk_benchmark(p_locale text, p_count int DEFAULT 10000,
        p_seed bigint DEFAULT 1)
RETURNS TABLE (locale text, users int, seconds numeric, users_per_second numeric)
LANGUAGE plpgsql VOLATILE AS $$
DECLARE
    t0 timestamptz := clock_timestamp();
    n  int;
BEGIN
    SELECT count(*) INTO n
    FROM generate_series(0, p_count - 1) AS i
    CROSS JOIN LATERAL fk_user(p_locale, p_seed, i) AS u
    WHERE u.bio IS NOT NULL;            -- force every column to be computed

    seconds          := round(extract(epoch FROM clock_timestamp() - t0)::numeric, 3);
    locale           := p_locale;
    users            := n;
    users_per_second := round(n / greatest(seconds, 0.001));
    RETURN NEXT;
END $$;
