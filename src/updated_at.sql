 CREATE OR REPLACE FUNCTION updated_at()
 RETURNS TRIGGER
 LANGUAGE plpgsql
 AS $$
 BEGIN
   NEW.updated_at = now();
   RETURN NEW;
 END;
 $$;
 
 CREATE TRIGGER updated_at_now BEFORE UPDATE
 ON keyvalue FOR EACH ROW EXECUTE PROCEDURE
	updated_at();

