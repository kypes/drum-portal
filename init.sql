-- Create test database if it doesn't exist
CREATE DATABASE drum_portal_test;

-- Switch to development database and create extensions
\connect drum_portal_development;
CREATE EXTENSION IF NOT EXISTS plpgsql;

-- Switch to test database and create extensions
\connect drum_portal_test;
CREATE EXTENSION IF NOT EXISTS plpgsql; 