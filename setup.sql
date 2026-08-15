-- Catalog setup
create catalog if not exists marathos;

-- Schema setup
create schema if not exists marathos.bronze;
create schema if not exists marathos.default;
create schema if not exists marathos.raw;
create schema if not exists marathos.gold;
create schema if not exists marathos.information_schema;
create schema if not exists marathos.silver;