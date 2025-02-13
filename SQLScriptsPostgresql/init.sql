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
\i /docker-entrypoint-initdb.d/Views/VW_CompleteInstructors.sql
\i /docker-entrypoint-initdb.d/Views/VW_CompleteSessions.sql
\i /docker-entrypoint-initdb.d/Views/VW_CompleteUsers.sql
\i /docker-entrypoint-initdb.d/Views/VW_SessionAttendances.sql

-- Then load functions
\i /docker-entrypoint-initdb.d/Functions/FN_GetUserByUsername.sql
\i /docker-entrypoint-initdb.d/Functions/FN_AddServiceToInstructor.sql

-- Error handling tables will be created here (converted from ErrorsDrop&Create.sql)

-- Data insertion will happen here (converted from DataInsertion.sql)

-- Note: All statements should end with semicolons in PostgreSQL

-- By default, PostgreSQL will execute scripts in alphabetical order from /docker-entrypoint-initdb.d
-- We can ensure order by prefixing files with numbers:
-- 01_tables.sql
-- 02_functions.sql
-- 03_data.sql

-- Then load db setup 
\i /docker-entrypoint-initdb.d/Setup/01_tables.sql

-- Then load functions
\i /docker-entrypoint-initdb.d/Functions/FN_GetUserByUsername.sql
\i /docker-entrypoint-initdb.d/Functions/FN_AddServiceToInstructor.sql

