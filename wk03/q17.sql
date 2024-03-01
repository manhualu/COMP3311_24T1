create table Employee(
    ssn             integer, 
    birthdate       date, 
    name            varchar(30),
    worksFor        varchar(30),
    primary key     (ssn),
    -- foreign key (worksFor) references Department(name)
);

create table Department(
    name            varchar(30),
    phone           varchar(30),
    location        varchar(30),
    manager         integer not null,
    mdate           date, 
    primary key     (name),
    foreign key     (manager) references Employee(ssn)
);

-- This had to be added after Department was made because of 
-- the mutually dependent/recursive relationship between Employee and Department, where Employee had to be created before Department and Department had to be created before Employee
alter table Employee add 
    foreign key (worksFor) references Department(name); 

create table Project(
    pnum            integer, 
    title           varchar(30),
    primary key     (pnum)
);

create table Dependent( -- weak entity
    ssn             integer not null,
    name            varchar(30),
    birthdate       date, 
    relation        varchar(10) check (relation in ('spouse', 'child'))
    primary key     (ssn, name), -- remember primary key of a weak entity is it's strong entity's primary key (ssn) and it's own discriminator (name)
    foreign key     (ssn) references Employee(ssn)
);

create table Participation(
    employee        integer, 
    project         integer, 
    time            integer, 
    primary key     (employee, project)
    foreign key     (employee) references Employee(ssn),
    foreign key     (project) references Project(pnum),
);

