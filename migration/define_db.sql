drop table if exists user_account;
create table if not exists user_account (
    id uuid not null default gen_random_uuid(),
    name text not null,
    email text not null,
    password varchar(100) not null,
    birthday date,
    weight int,
    height int,
    primary key (id)
);

drop table if exists project;
create table if not exists project(
    id uuid not null unique default gen_random_uuid(),
    user_account_id uuid not null,
    name text not null,
    primary key (id, user_account_id),
    constraint user_account_id
        foreign key (user_account_id)
        references user_account (id)
);

drop table if exists workout_session;
create table if not exists workout_session(
    id uuid not null unique default gen_random_uuid(),
    user_account_id uuid not null,
    project_id uuid not null,
    name text not null,
    done_count int default 0,
    project_order int default 1,
    done bool default false,
    primary key (id, user_account_id, project_id),
    constraint user_account_id
        foreign key (user_account_id)
        references user_account(id),
    constraint project_id
        foreign key (project_id)
        references project(id)
);

drop table if exists exercise;
create table if not exists exercise(
    id uuid not null default gen_random_uuid(),
    name text not null,
    primary key (id)
);

drop table if exists workout_session_exercise;
create table if not exists workout_session_exercise(
    id uuid not null default gen_random_uuid(),
    exercise_id uuid not null,
    workout_session_id uuid not null,
    primary key(id, exercise_id, workout_session_id),
    constraint exercise_id
        foreign key (exercise_id)
        references exercise (id),
    constraint workout_session_id
        foreign key (workout_session_id)
        references workout_session (id)
);

