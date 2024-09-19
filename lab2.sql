create database lab2;

create table countries(
    country_id SERIAL PRIMARY KEY,
    country_name varchar(100),
    region_id int,
    population int
);

insert into countries(country_name, region_id, population)
values('Country A',1,500000)

INSERT INTO countries (country_id, country_name)
VALUES (2, 'Country B');

insert into countries(country_name, region_id, population)
values ('Country C',NULL,200000);

INSERT INTO countries (country_name, region_id, population)
VALUES
('Country D', 2, 300000),
('Country E', 3, 400000),
('Country F', 4, 100000);

alter table countries
alter column country_name set default 'Kazakhstan';

INSERT INTO countries (region_id, population)
VALUES (5, 600000);

INSERT INTO countries DEFAULT VALUES;

CREATE TABLE countries_new (LIKE countries INCLUDING ALL);

INSERT INTO countries_new
SELECT * FROM countries;

update countries
set region_id=1
where region_id IS NULL;

select country_name,
       population * 1.10 as "New population"
from countries;

delete from countries
where population < 100000;

DELETE FROM countries_new
WHERE country_id IN (SELECT country_id FROM countries)
RETURNING *;

DELETE FROM countries
RETURNING *;