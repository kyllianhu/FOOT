DROP TABLE IF EXISTS team CASCADE;
DROP TABLE IF EXISTS player CASCADE;
DROP TABLE IF EXISTS typ_event CASCADE;
DROP TABLE IF EXISTS match_day CASCADE;
DROP TABLE IF EXISTS event_match CASCADE;

CREATE TABLE team(
   id_team INT,
   name_team VARCHAR(50),
   surname VARCHAR(50),
   short VARCHAR(10),
   birthday VARCHAR(4),
   city VARCHAR(50),
   photo VARCHAR(300),
   PRIMARY KEY(id_team)
);

CREATE TABLE player(
   id_player INT,
   name_player VARCHAR(50),
   birthday DATE,
   photo VARCHAR(300),
   PRIMARY KEY(id_player)
);

CREATE TABLE typ_event(
   id_typ VARCHAR(50),
   lib VARCHAR(50),
   PRIMARY KEY(id_typ)
);

CREATE TABLE match_day(
   id_match INT,
   date_match DATE,
   home INT,
   away INT,
   stage INT,
   id_team INT NOT NULL,
   id_team_1 INT NOT NULL,
   PRIMARY KEY(id_match),
   FOREIGN KEY(id_team) REFERENCES Team(id_team),
   FOREIGN KEY(id_team_1) REFERENCES Team(id_team)
);

CREATE TABLE event_match(
   id_event INT,
   match_event INT,
   time INT,
   player INT,
   team INT,
   type_e VARCHAR(50),
   photo VARCHAR(300),
   video VARCHAR(300),
   id_team INT NOT NULL,
   id_typ VARCHAR(50) NOT NULL,
   id_player INT NOT NULL,
   id_match INT NOT NULL,
   PRIMARY KEY(id_event),
   FOREIGN KEY(id_team) REFERENCES team(id_team),
   FOREIGN KEY(id_typ) REFERENCES typ_event(id_typ),
   FOREIGN KEY(id_player) REFERENCES player(id_player),
   FOREIGN KEY(id_match) REFERENCES match_day(id_match)
);

insert into typ_event (id_typ, lib) 
values ('goal', 'but'),
       ('penalty', 'but sur penalty'),
       ('own', 'but contre son camp'),
       ('miss', 'penalty raté'),
       ('yellow', 'carton jaune'),
       ('yellow2', 'deuxième carton jaune'),
       ('red', 'carton rouge');