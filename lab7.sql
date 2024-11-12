CREATE INDEX idx_countries_name ON countries(name);

CREATE INDEX idx_employees_name_surname ON employees(name, surname);

CREATE UNIQUE INDEX idx_employees_salary_range ON employees(salary);

CREATE INDEX idx_employees_name_prefix ON employees (name text_pattern_ops);

CREATE INDEX idx_departments_budget ON departments(budget);
CREATE INDEX idx_employees_salary ON employees(salary);
