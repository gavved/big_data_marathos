show catalogs;

create catalog if not exists marathos;

use catalog marathos;



create schema if not exists bronze;
create schema if not exists silver;
create schema if not exists gold;

create volume if not exists raw;


