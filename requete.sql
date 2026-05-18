/* REQUETE N°1 : Listez les matchs de la premiere journee de championnat */
SELECT
    date_match AS "Date du Match",
    home AS "Equipe qui recoit",
    away AS "Equipe qui se deplace",
    stage AS "Journee"
FROM match_day
WHERE stage = 1;

/* REQUETE N°2 : Listez les equipes */
SELECT *
FROM team;

/* REQUETE N°3 : Listez les matchs de la premiere journee de championnat avec le nom de l'equipe qui recoit */
SELECT
    m.date_match AS "date",
    t.name_team AS "Nom de l'equipe qui recoit"
FROM match_day m
JOIN team t ON m.home = t.id_team
WHERE m.stage = 1;

/* REQUETE N°4 : Listez les matchs de la premiere journee avec le nom des deux equipes */
SELECT
    m.date_match AS "date",
    home_team.name_team AS "equipe qui recoit",
    away_team.name_team AS "equipe qui se deplace"
FROM match_day m
JOIN team home_team ON m.home = home_team.id_team
JOIN team away_team ON m.away = away_team.id_team
WHERE m.stage = 1;

/* REQUETE N°5 : Creez la vue LesRencontres de la requete 4 pour tous les stages */
CREATE OR REPLACE VIEW LesRencontres AS
SELECT
    m.date_match AS "date",
    home_team.name_team AS "equipe qui recoit",
    away_team.name_team AS "equipe qui se deplace",
    m.stage AS "journee",
    home_team.photo AS "photo"
FROM match_day m
JOIN team home_team ON m.home = home_team.id_team
JOIN team away_team ON m.away = away_team.id_team;

SELECT *
FROM LesRencontres;

/* REQUETE N°6 : Listez les types d'evenements pouvant se produire lors d'un match */
SELECT
    id_typ AS "id",
    lib AS "libelle"
FROM typ_event;

/* REQUETE N°7 : Determinez le nom du ou des equipes creees en 1881 */
SELECT name_team
FROM team
WHERE birthday = '1881';

/* REQUETE N°8 : Affichez les equipes dans l'ordre de leur creation */
SELECT
    name_team AS "name",
    birthday
FROM team
ORDER BY birthday::integer, name_team;

/* REQUETE N°9 : Determinez le nom de l'equipe du joueur Zlatan */
SELECT DISTINCT
    p.name_player AS "Joueur",
    t.name_team AS "Equipe"
FROM player p
JOIN event_match e ON p.id_player = e.id_player
JOIN team t ON e.id_team = t.id_team
WHERE p.name_player = 'Zlatan Ibrahimovic';

/* REQUETE N°10 : Verifiez qu'il y avait 20 equipes a participer au championnat */
SELECT COUNT(*) AS "nombre_equipes"
FROM team;

/* REQUETE N°11 : Verifiez qu'il y a bien eu 380 matchs disputes */
SELECT COUNT(*) AS "nombre_matchs"
FROM match_day;

/* REQUETE N°12 : Verifiez qu'il y a bien eu 66 buts sur penalty avec jointure uniquement */
SELECT COUNT(*) AS "buts_sur_penalty"
FROM event_match e
JOIN typ_event te ON e.id_typ = te.id_typ
WHERE te.id_typ = 'penalty';

/* REQUETE N°13 : Verifiez qu'il y a bien eu 78 cartons rouges avec sous-requete uniquement */
SELECT COUNT(*) AS "cartons_rouges"
FROM event_match
WHERE id_typ IN (
    SELECT id_typ
    FROM typ_event
    WHERE id_typ = 'red'
);

/* REQUETE N°14 : Verifiez qu'il y a bien eu 93 penaltys sifflés */
SELECT COUNT(*) AS "penaltys_siffles_jointure"
FROM event_match e
JOIN typ_event te ON e.id_typ = te.id_typ
WHERE te.id_typ IN ('penalty', 'miss');

SELECT COUNT(*) AS "penaltys_siffles_sous_requete"
FROM event_match
WHERE id_typ IN (
    SELECT id_typ
    FROM typ_event
    WHERE id_typ IN ('penalty', 'miss')
);

/* REQUETE N°15 : Verifiez qu'il y a bien eu 960 buts */
SELECT COUNT(*) AS "nombre_buts"
FROM event_match
WHERE id_typ IN ('goal', 'penalty', 'own');

/* REQUETE N°16 : Listez le nombre de buts par equipe */
SELECT
    id_team AS "team",
    COUNT(*) AS "count"
FROM event_match
WHERE id_typ IN ('goal', 'penalty', 'own')
GROUP BY id_team
ORDER BY id_team;

CREATE OR REPLACE VIEW nombreDeButParEquipe AS
SELECT
    id_team AS team,
    COUNT(*) AS count
FROM event_match
WHERE id_typ IN ('goal', 'penalty', 'own')
GROUP BY id_team;

SELECT *
FROM nombreDeButParEquipe
ORDER BY team;

/* REQUETE N°17 : Affichez les 10 cartons rouges obtenus le plus rapidement */
SELECT
    id_event AS "id",
    match_event AS "match",
    time,
    player,
    team,
    type_e AS "type"
FROM event_match
WHERE id_typ = 'red'
ORDER BY time
LIMIT 10;

/* REQUETE N°18 : Determinez la date de creation la plus ancienne */
SELECT MIN(birthday) AS "date_creation_plus_ancienne"
FROM team;

/* REQUETE N°19 : Affichez uniquement l'equipe la plus ancienne */
SELECT *
FROM team
WHERE birthday = (
    SELECT MIN(birthday)
    FROM team
);

/* REQUETE N°20 : Cle primaire de l'equipe de Lorient */
SELECT id_team
FROM team
WHERE name_team = 'Football Club de Lorient Bretagne Sud';

/* REQUETE N°21 : Montrez que Lorient a marque 47 buts avec la vue nombreDeButParEquipe */
SELECT *
FROM nombreDeButParEquipe
WHERE team = (
    SELECT id_team
    FROM team
    WHERE name_team = 'Football Club de Lorient Bretagne Sud'
);

/* REQUETE N°22 : Montrez que Lorient a marque 21 buts a l'exterieur */
SELECT COUNT(*) AS "buts_exterieur_lorient"
FROM event_match e
JOIN match_day m ON e.id_match = m.id_match
WHERE e.id_team = (
    SELECT id_team
    FROM team
    WHERE name_team = 'Football Club de Lorient Bretagne Sud'
)
AND m.away = e.id_team
AND e.id_typ IN ('goal', 'penalty', 'own');

/* REQUETE N°23 : Montrez que Lorient a encaisse 58 buts */
SELECT COUNT(*) AS "buts_encaisses_lorient"
FROM event_match e
JOIN match_day m ON e.id_match = m.id_match
WHERE (
    m.home = (
        SELECT id_team
        FROM team
        WHERE name_team = 'Football Club de Lorient Bretagne Sud'
    )
    OR m.away = (
        SELECT id_team
        FROM team
        WHERE name_team = 'Football Club de Lorient Bretagne Sud'
    )
)
AND e.id_team <> (
    SELECT id_team
    FROM team
    WHERE name_team = 'Football Club de Lorient Bretagne Sud'
)
AND e.id_typ IN ('goal', 'penalty', 'own');

/* REQUETE N°24 : Montrez que Lorient a encaisse 21 buts a domicile */
SELECT COUNT(*) AS "buts_encaisses_domicile_lorient"
FROM event_match e
JOIN match_day m ON e.id_match = m.id_match
WHERE m.home = (
    SELECT id_team
    FROM team
    WHERE name_team = 'Football Club de Lorient Bretagne Sud'
)
AND e.id_team <> (
    SELECT id_team
    FROM team
    WHERE name_team = 'Football Club de Lorient Bretagne Sud'
)
AND e.id_typ IN ('goal', 'penalty', 'own');

/* REQUETE N°25 : Montrez que Lorient a marque 26 fois pendant la premiere moitie de saison */
SELECT COUNT(*) AS "buts_lorient_premiere_moitie"
FROM event_match e
JOIN match_day m ON e.id_match = m.id_match
WHERE e.id_team = (
    SELECT id_team
    FROM team
    WHERE name_team = 'Football Club de Lorient Bretagne Sud'
)
AND m.stage <= 19
AND e.id_typ IN ('goal', 'penalty', 'own');

/* REQUETE N°26 : Montrez que le but le plus rapide de la saison a ete realise a la troisieme minute */
SELECT MIN(time) AS "minute_but_plus_rapide"
FROM event_match
WHERE id_typ IN ('goal', 'penalty', 'own');

/* REQUETE N°27 : Affichez le ou les buts marques a la troisieme minute avec le nom du joueur */
SELECT
    e.id_event,
    e.match_event,
    e.time,
    p.name_player AS "joueur"
FROM event_match e
JOIN player p ON e.id_player = p.id_player
WHERE e.id_typ IN ('goal', 'penalty', 'own')
AND e.time = (
    SELECT MIN(time)
    FROM event_match
    WHERE id_typ IN ('goal', 'penalty', 'own')
);

/* REQUETE N°28 : Ajoutez la date du match */
SELECT
    e.id_event,
    m.date_match,
    e.match_event,
    e.time,
    p.name_player AS "joueur"
FROM event_match e
JOIN player p ON e.id_player = p.id_player
JOIN match_day m ON e.id_match = m.id_match
WHERE e.id_typ IN ('goal', 'penalty', 'own')
AND e.time = (
    SELECT MIN(time)
    FROM event_match
    WHERE id_typ IN ('goal', 'penalty', 'own')
);

/* REQUETE N°29 : Ajoutez le nom des equipes impliquees */
SELECT
    e.id_event,
    m.date_match,
    home_team.name_team AS "equipe qui recoit",
    away_team.name_team AS "equipe qui se deplace",
    e.time,
    p.name_player AS "joueur"
FROM event_match e
JOIN player p ON e.id_player = p.id_player
JOIN match_day m ON e.id_match = m.id_match
JOIN team home_team ON m.home = home_team.id_team
JOIN team away_team ON m.away = away_team.id_team
WHERE e.id_typ IN ('goal', 'penalty', 'own')
AND e.time = (
    SELECT MIN(time)
    FROM event_match
    WHERE id_typ IN ('goal', 'penalty', 'own')
);

/* REQUETE N°30 : Limitez l'affichage a la date, les equipes, le joueur et la minute du but */
SELECT
    m.date_match AS "date du match",
    home_team.name_team AS "equipe qui recoit",
    away_team.name_team AS "equipe qui se deplace",
    p.name_player AS "joueur",
    e.time AS "minute du but"
FROM event_match e
JOIN player p ON e.id_player = p.id_player
JOIN match_day m ON e.id_match = m.id_match
JOIN team home_team ON m.home = home_team.id_team
JOIN team away_team ON m.away = away_team.id_team
WHERE e.id_typ IN ('goal', 'penalty', 'own')
AND e.time = (
    SELECT MIN(time)
    FROM event_match
    WHERE id_typ IN ('goal', 'penalty', 'own')
);

/* VUE UTILISEE PAR equipe.php : liste des joueurs avec leur equipe */
CREATE OR REPLACE VIEW LesJoueurs AS
SELECT DISTINCT ON (p.id_player)
    p.name_player AS joueur,
    p.birthday AS anniv,
    p.photo AS photo,
    t.name_team AS nomequipe,
    t.surname AS surnomequipe,
    t.short AS shortequipe,
    t.birthday AS annivequipe,
    t.city AS villeequipe,
    t.photo AS photoequipe
FROM player p
JOIN event_match e ON p.id_player = e.id_player
JOIN team t ON e.id_team = t.id_team
ORDER BY p.id_player, t.id_team;
