CREATE OR REPLACE FUNCTION parse_yyyymmdd_safe(txt TEXT)
RETURNS DATE
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
    trimmed_date TEXT := TRIM(txt);
BEGIN
  RETURN
    CASE
      WHEN trimmed_date IS NULL OR trimmed_date = ''
        THEN NULL
      WHEN trimmed_date !~ '^\d{8}$'
        THEN NULL
      WHEN trimmed_date < '18500101' OR trimmed_date > '29991231'
        THEN NULL
      ELSE
        make_date(
          substr(trimmed_date,1,4)::int,
          substr(trimmed_date,5,2)::int,
          substr(trimmed_date,7,2)::int
        )
    END;
END;
$$;