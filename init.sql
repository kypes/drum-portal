-- Create database user if it doesn't exist
DO
$do$
BEGIN
   IF NOT EXISTS (
      SELECT FROM pg_catalog.pg_roles
      WHERE  rolname = 'drum_portal') THEN
      CREATE USER drum_portal WITH PASSWORD 'password' CREATEDB;
   END IF;
END
$do$;

-- Create databases
CREATE DATABASE drum_portal_development;
CREATE DATABASE drum_portal_test;

-- Switch to development database and create extensions
\connect drum_portal_development;
CREATE EXTENSION IF NOT EXISTS plpgsql;
ALTER DATABASE drum_portal_development OWNER TO drum_portal;
GRANT ALL PRIVILEGES ON DATABASE drum_portal_development TO drum_portal;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO drum_portal;
ALTER SCHEMA public OWNER TO drum_portal;

-- Switch to test database and create extensions
\connect drum_portal_test;
CREATE EXTENSION IF NOT EXISTS plpgsql;
ALTER DATABASE drum_portal_test OWNER TO drum_portal;
GRANT ALL PRIVILEGES ON DATABASE drum_portal_test TO drum_portal;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO drum_portal;
ALTER SCHEMA public OWNER TO drum_portal; 