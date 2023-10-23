

CREATE TABLE IF NOT EXISTS task
(
    id uuid primary key not null,
    name varchar(100) not null,
    quantity_of_vacancy int,
    email_contact varchar(100) not null,
    date_init date,
    date_final date,
    time_init time,
    time_final time,
    status varchar(100) not null,
    description varchar(100),
    social_action_id uuid not null,
    created_at timestamp not null,
    updated_at timestamp not null,
    foreign key(social_action_id) references social_action(id)
);