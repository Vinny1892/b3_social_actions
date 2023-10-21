

CREATE TABLE IF NOT EXISTS social_action
(
    id uuid primary key not null,
    name varchar(100) not null,
    level_id uuid,
    type_id uuid,
    ong_id uuid,
    status varchar(50),
    email_contact varchar(100) not null,
    payment_link varchar(100),
    description varchar(100),
    date_init date,
    time_init time,
    date_final date,
    time_final time,
    created_at timestamp not null,
    updated_at timestamp not null
);