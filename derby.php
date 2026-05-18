<?php
Include_once("myParam.inc.php");
$conn = pg_connect('host='.HOST.' dbname=FOOT user='.USER.' password='.PASS);
if (!$conn) {
    die("Erreur de connexion : " . pg_last_error());
}

$sql = "
SELECT
    m.date_match,
    home_team.name_team AS domicile,
    away_team.name_team AS exterieur,
    m.stage,
    CASE
        WHEN m.home IN (0, 17) AND m.away IN (0, 17) THEN 'Derby corse'
        WHEN m.home IN (3, 14) AND m.away IN (3, 14) THEN 'Derby Rhone-Alpes'
        WHEN m.home IN (7, 11) AND m.away IN (7, 11) THEN 'Derby de la Cote d''Azur'
        WHEN m.home IN (6, 13) AND m.away IN (6, 13) THEN 'Derby de l''Ouest'
        WHEN m.home IN (13, 18) AND m.away IN (13, 18) THEN 'Derby breton'
        WHEN m.home IN (1, 8) AND m.away IN (1, 8) THEN 'Derby de la Garonne'
    END AS nom_derby
FROM match_day m
JOIN team home_team ON m.home = home_team.id_team
JOIN team away_team ON m.away = away_team.id_team
WHERE
    (m.home IN (0, 17) AND m.away IN (0, 17))
    OR (m.home IN (3, 14) AND m.away IN (3, 14))
    OR (m.home IN (7, 11) AND m.away IN (7, 11))
    OR (m.home IN (6, 13) AND m.away IN (6, 13))
    OR (m.home IN (13, 18) AND m.away IN (13, 18))
    OR (m.home IN (1, 8) AND m.away IN (1, 8))
ORDER BY m.date_match, nom_derby";

$result = pg_query($conn, $sql);
if (!$result) {
    die("Erreur dans la requête SQL : " . pg_last_error());
}

$donnees = '';
while ($row = pg_fetch_row($result)) {
    $date = $row[0];
    $domicile = $row[1];
    $exterieur = $row[2];
    $stage = $row[3];
    $nomderby = $row[4];
    $donnees .= '
        <div class="match-row">
            <div class="match-date">' . $date . '</div>
            <div class="match-teams">
                <span class="team-home">' . $domicile . '</span>
                <span class="vs"> - </span>
                <span class="team-away">' . $exterieur . '</span>
            </div>
            <div class="match-location">' . $nomderby . ' - Stage : ' . $stage . '</div>
        </div>';
}

if ($donnees == '') {
    $donnees = '<div class="match-row"><div class="match-date">Aucun derby</div><div class="match-teams">Aucun match trouve</div><div class="match-location"></div></div>';
}

pg_free_result($result);
pg_close($conn);

$texte ='<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<link rel="stylesheet" href="match.css" />
<title>LES DERBY</title>
</head>
<body>
    <div class="container">
        <a href="accueil.php">
            <img src="img/logofff.png" alt="Logo FFF" id="fff">
        </a>
        <h1 id="bandeau">LES DERBY</h1>
    </div>

    <div class="bouton">
        <a href="match.php"><button>LES MATCHS DU CHAMPIONNAT</button></a>
    </div>

    <div class="rencontres">
        <div class="match-list">' . $donnees . '</div>
    </div>

    <footer>
        <p>&copy; Copyright 2025 &middot;<a href="mentions.html">Mentions légales</a></p>
    </footer>
</body>
</html>';

echo $texte;
?>
