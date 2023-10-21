CREATE TABLE IF NOT EXISTS subscription
(
    id uuid primary key not null,
    task_id uuid not null,
    user_id uuid not null,
    created_at timestamp not null,
    updated_at timestamp not null,
    foreign key(task_id) references task(id)
);