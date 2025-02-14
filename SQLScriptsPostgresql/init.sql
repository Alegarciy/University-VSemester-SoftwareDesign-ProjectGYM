-- Note: Database creation is handled by POSTGRES_DB environment variable
-- so we don't need CREATE DATABASE statement

-- Set search path to our database
SET search_path TO public;

-- Execute our scripts in order
-- Create custom types if needed (we'll need to convert SQL Server specific types)
DO $$ 
BEGIN
    -- Create ENUM types here if needed
    -- Example:
    -- IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'status_enum') THEN
    --     CREATE TYPE status_enum AS ENUM ('active', 'inactive');
    -- END IF;
END $$;

-- Then load db setup 
\i /docker-entrypoint-initdb.d/Setup/01_tables.sql
\i /docker-entrypoint-initdb.d/Setup/02_errors.sql
\i /docker-entrypoint-initdb.d/Setup/03_mockdata.sql

-- Then load views
\i /docker-entrypoint-initdb.d/Views/VW_CompleteUsers.sql

-- Then load functions
\i /docker-entrypoint-initdb.d/Functions/FN_GetUserByUsername.sql
\i /docker-entrypoint-initdb.d/Functions/FN_AddServiceToInstructor.sql
