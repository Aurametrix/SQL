 create table unitType (
    id bigint not null auto_increment,
    buildingId bigint not null,
  
    info json,
    name varchar(255) as (info->>'$.name') not null,
  
    primary key(id),
    foreign key (buildingId) references building(id) on delete cascade,
    unique key(buildingId, name)
  );
