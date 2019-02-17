-- register workers in new db
SELECT * from master_add_node('posgresql_sharded_worker_1', 5432);

CREATE DATABASE seniordb;
CREATE SCHEMA IF NOT EXISTS sigma;

SELECT run_command_on_workers('CREATE DATABASE seniordb;');
SELECT run_command_on_workers('CREATE SCHEMA IF NOT EXISTS sigma;');

-- review the worker nodes registered in current db
SELECT * FROM master_get_active_worker_nodes();

-- switch to new db on coordinator
\c seniordb

-- create citus extension in new db
CREATE EXTENSION citus;

CREATE TABLE sigma.user(
  id serial primary key,
  firstname varchar(50) not null,
  lastname varchar(50) not null,
  email text not null,
  password varchar(100) not null
);

SELECT create_distributed_table('sigma.user','id');

--List tables within schema
\dt sigma.*


