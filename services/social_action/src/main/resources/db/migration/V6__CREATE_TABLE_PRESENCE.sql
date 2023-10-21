CREATE TABLE IF NOT EXISTS presence
(
    id uuid primary key not null,
    task_id uuid not null,
    subscription_id uuid not null,
    user_id uuid not null,
    created_at timestamp not null,
    updated_at timestamp not null,
    foreign key(task_id) references task(id),
    foreign key(subscription_id) references subscription(id)
);