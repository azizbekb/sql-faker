-- =====================================================================
-- SQL Faker :: schema
-- All lookup data lives in a few generic tables keyed by `locale`.
-- Adding a new locale = inserting rows; no new tables, no code changes.
-- =====================================================================

DROP TABLE IF EXISTS markov_chain, markov_sizes, markov_edges, text_corpus, category_sizes,
                     distributions, cities, words, locales CASCADE;

CREATE TABLE locales (
    code        text PRIMARY KEY,               -- e.g. 'en_US', 'de_DE'
    name        text NOT NULL,                  -- human readable name
    units       text NOT NULL DEFAULT 'metric'  -- how physical attributes are printed
                CHECK (units IN ('metric', 'imperial'))
);

-- Generic weighted vocabulary / template table.
-- `category` examples: first_name_M, first_name_F, last_name, title_M,
-- street_name, street_suffix, email_domain, eye_color, fmt_name, fmt_address,
-- fmt_phone, fmt_email ... (see docs for full list).
-- `ord` and `cum_hi` are maintained by CALL fk_reindex().
CREATE TABLE words (
    id          serial PRIMARY KEY,
    locale      text NOT NULL REFERENCES locales(code) ON DELETE CASCADE,
    category    text NOT NULL,
    value       text NOT NULL,
    weight      float8 NOT NULL DEFAULT 1 CHECK (weight > 0),
    ord         int,                            -- 1..n inside (locale, category)
    cum_hi      float8,                         -- running sum of weight inside (locale, category)
    UNIQUE (locale, category, value)
);
CREATE INDEX words_pick_idx ON words (locale, category, cum_hi) INCLUDE (value);

-- Cities with region and a postal-code pattern ('#' = random digit).
CREATE TABLE cities (
    id          serial PRIMARY KEY,
    locale      text NOT NULL REFERENCES locales(code) ON DELETE CASCADE,
    city        text NOT NULL,
    region      text NOT NULL,                  -- state / Bundesland (full name)
    region_code text NOT NULL,                  -- 'NY', 'BY', ...
    postal      text NOT NULL,                  -- pattern, e.g. '100##' or '80###'
    weight      float8 NOT NULL DEFAULT 1 CHECK (weight > 0),
    cum_hi      float8,
    UNIQUE (locale, city, region_code)
);
CREATE INDEX cities_pick_idx ON cities (locale, cum_hi);

-- Parameters of normal distributions per locale / attribute / gender.
CREATE TABLE distributions (
    locale      text NOT NULL REFERENCES locales(code) ON DELETE CASCADE,
    attribute   text NOT NULL,                  -- 'height_cm', 'bmi', 'age'
    gender      char(1) NOT NULL CHECK (gender IN ('M', 'F')),
    mean        float8 NOT NULL,
    sd          float8 NOT NULL CHECK (sd >= 0),
    min_value   float8 NOT NULL,
    max_value   float8 NOT NULL,
    PRIMARY KEY (locale, attribute, gender)
);

-- Size / total weight of every (locale, category); filled by fk_reindex().
-- Cities are stored under the pseudo category '@cities'.
CREATE TABLE category_sizes (
    locale       text NOT NULL,
    category     text NOT NULL,
    n            int NOT NULL,
    total_weight float8 NOT NULL,
    PRIMARY KEY (locale, category)
);

-- Source texts for the Markov chain text generator.
CREATE TABLE text_corpus (
    id      serial PRIMARY KEY,
    locale  text NOT NULL REFERENCES locales(code) ON DELETE CASCADE,
    body    text NOT NULL
);

-- First-order word Markov chain. For every word, `successors` lists every
-- word that followed it in the corpus, with repetitions, so a uniform pick
-- from the array is a pick proportional to bigram frequency.
-- word = '' means "start of sentence".
CREATE TABLE markov_chain (
    locale      text NOT NULL,
    word        text NOT NULL,
    successors  text[] NOT NULL,
    PRIMARY KEY (locale, word)
);
