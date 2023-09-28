CREATE TABLE ong
(
    id uuid primary key not null,
    name varchar(100) not null,
    created_at timestamp not null,
    updated_at timestamp not null
);