

CREATE TABLE task
(
    id uuid primary key not null,
    name varchar(100) not null,
    quantity_of_vacancy int,
    social_action_id uuid not null,
    created_at timestamp not null,
    updated_at timestamp not null,
    foreign key(social_action_id) references social_action(id)
);