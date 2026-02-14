CREATE OR REPLACE FUNCTION parse_yyyymmdd_safe(txt TEXT)
RETURNS DATE
LANGUAGE sql
IMMUTABLE
AS $$
  SELECT
    CASE
      WHEN txt IS NULL OR txt = ''
        THEN NULL
      WHEN txt !~ '^\d{8}$'
        THEN NULL
      WHEN txt < '19000101' OR txt > '29991231'
        THEN NULL
      ELSE
        make_date(
          substr(txt,1,4)::int,
          substr(txt,5,2)::int,
          substr(txt,7,2)::int
        )
    END
$$;