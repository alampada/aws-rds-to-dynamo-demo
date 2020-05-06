create database demo;

\connect demo;

create table department (id bigint not null, name varchar(30) not null, primary key (id));

create table employee (id bigint not null, name varchar(30) not null, department_id bigint not null, primary key(id), foreign key(department_id) references department(id));

insert into department values (1,'DPT1'),(2,'DPT2');

insert into employee values (1, 'AL', 1), (2, 'XX', 1), (3, 'YY', 2);
