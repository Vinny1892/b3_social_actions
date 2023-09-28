

CREATE TABLE social_action
(
    id uuid primary key not null,
    name varchar(100) not null,
    level_id uuid,
    type_id uuid,
    ong_id uuid,
    payment_link varchar(100),
    created_at timestamp not null,
    updated_at timestamp not null
);