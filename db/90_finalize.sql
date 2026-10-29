-- =====================================================================
-- SQL Faker :: build derived data (run after loading / changing data)
-- =====================================================================
CALL fk_reindex();

DO $$
DECLARE l text;
BEGIN
    FOR l IN SELECT DISTINCT locale FROM text_corpus LOOP
        CALL fk_build_markov(l);
    END LOOP;
END $$;
ANALYZE markov_chain;
