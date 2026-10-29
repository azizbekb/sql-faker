-- =====================================================================
-- SQL Faker :: deterministic random primitives
--
-- There is no hidden RNG state. Every random value is a pure function of
--   (key, stream)
-- where `key` identifies "whose" value it is (locale + seed + position +
-- field name) and `stream` numbers the individual draws inside a field.
-- This is a counter-based RNG: same inputs -> same output, on any server,
-- in any order, in parallel, without generating previous rows first.
-- =====================================================================

-- Uniform float in [0, 1).
-- hashtextextended() is PostgreSQL's 64-bit Jenkins hash (the one used for
-- hash partitioning, so it is stable across versions/platforms). The second
-- argument is a hash seed, which we use as the stream number. The top 53
-- bits of the hash become the mantissa of a double.
CREATE OR REPLACE FUNCTION fk_random(p_key text, p_stream int)
RETURNS float8 LANGUAGE sql IMMUTABLE STRICT PARALLEL SAFE AS $$
    SELECT ((hashtextextended(p_key, p_stream) >> 11) & 9007199254740991)::float8
           / 9007199254740992.0
$$;

-- Uniform integer in [p_lo, p_hi] (both inclusive).
CREATE OR REPLACE FUNCTION fk_random_int(p_key text, p_stream int, p_lo int, p_hi int)
RETURNS int LANGUAGE sql IMMUTABLE STRICT PARALLEL SAFE AS $$
    SELECT p_lo + floor(fk_random(p_key, p_stream) * (p_hi - p_lo + 1))::int
$$;

-- Bernoulli trial: true with probability p_prob.
CREATE OR REPLACE FUNCTION fk_random_bool(p_key text, p_stream int, p_prob float8)
RETURNS boolean LANGUAGE sql IMMUTABLE STRICT PARALLEL SAFE AS $$
    SELECT fk_random(p_key, p_stream) < p_prob
$$;

-- Normally distributed value N(mean, sd) using the Box-Muller transform:
--   z = sqrt(-2 ln U1) * cos(2 pi U2),  U1 in (0,1], U2 in [0,1)
-- The two uniforms come from the same stream with different keys.
CREATE OR REPLACE FUNCTION fk_random_normal(p_key text, p_stream int, p_mean float8, p_sd float8)
RETURNS float8 LANGUAGE sql IMMUTABLE STRICT PARALLEL SAFE AS $$
    SELECT p_mean + p_sd
         * sqrt(-2.0 * ln(1.0 - fk_random(p_key, p_stream)))
         * cos(2.0 * pi() * fk_random(p_key || '~bm', p_stream))
$$;

-- Normal value clamped into [p_min, p_max] (keeps the bell shape, removes
-- physically impossible tails such as negative heights).
-- (Deliberately not STRICT: least/greatest are not strict, and a STRICT
-- SQL function with a non-strict body cannot be inlined by the planner.)
CREATE OR REPLACE FUNCTION fk_random_normal_clamped(p_key text, p_stream int,
        p_mean float8, p_sd float8, p_min float8, p_max float8)
RETURNS float8 LANGUAGE sql IMMUTABLE PARALLEL SAFE AS $$
    SELECT least(p_max, greatest(p_min, fk_random_normal(p_key, p_stream, p_mean, p_sd)))
$$;

-- Point uniformly distributed on the surface of a sphere.
-- Longitude is uniform in [-180, 180). Latitude is NOT uniform: the area of
-- a latitude band is proportional to cos(lat), so we sample z = sin(lat)
-- uniformly in [-1, 1] (Archimedes' hat-box theorem) and take asin(z).
-- The resulting PDF over the sphere's surface is constant.
CREATE OR REPLACE FUNCTION fk_random_sphere(p_key text, p_stream int,
        OUT latitude float8, OUT longitude float8)
LANGUAGE plpgsql IMMUTABLE STRICT PARALLEL SAFE AS $$
BEGIN
    latitude  := degrees(asin(2.0 * fk_random(p_key, p_stream) - 1.0));
    longitude := 360.0 * fk_random(p_key, p_stream + 1) - 180.0;
END $$;

-- Fill a digit pattern:  '#' -> 0-9,  '@' -> 1-9,  '%' -> 2-9.
-- Every other character is copied as is.  Example: '(%##) %##-####'.
CREATE OR REPLACE FUNCTION fk_random_digits(p_pattern text, p_key text, p_stream int)
RETURNS text LANGUAGE plpgsql IMMUTABLE STRICT PARALLEL SAFE AS $$
DECLARE
    result text := '';
    ch     text;
    i      int;
BEGIN
    FOR i IN 1 .. length(p_pattern) LOOP
        ch := substr(p_pattern, i, 1);
        result := result || CASE ch
            WHEN '#' THEN fk_random_int(p_key, p_stream + i, 0, 9)::text
            WHEN '@' THEN fk_random_int(p_key, p_stream + i, 1, 9)::text
            WHEN '%' THEN fk_random_int(p_key, p_stream + i, 2, 9)::text
            ELSE ch
        END;
    END LOOP;
    RETURN result;
END $$;

-- Builds the key of one fake record. Everything random about the user at
-- this position is derived from this string (plus a field suffix).
CREATE OR REPLACE FUNCTION fk_record_key(p_locale text, p_seed bigint, p_position bigint)
RETURNS text LANGUAGE sql IMMUTABLE STRICT PARALLEL SAFE AS $$
    SELECT p_locale || ':' || p_seed || ':' || p_position
$$;
