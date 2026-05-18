<?php
Include_once("myParam.inc.php");
$conn = pg_connect('host='.HOST.' dbname=FOOT user='.USER.' password='.PASS);
if (!$conn) {
    die("Erreur de connexion : " . pg_last_error()); 
}

$sql = "SELECT * FROM LesRencontres" ;
$result = pg_query($conn, $sql);
if (!$result) {
    die("Erreur dans la requête SQL : " . pg_last_error());
}
$données = '';
while ($row = pg_fetch_row($result)) {
    $date = $row[0];
    $domicile = $row[1];
    $exterieur = $row[2];
    $stage = $row[3];
    $photo = $row[4]; 
    $données .= '
        <div class="match-row">
            <div class="match-date">' . $date . '</div>
            <div class="match-teams">
                <span class="team-home">' . $domicile . '</span>
                <span class="vs"> - </span>
                <span class="team-away">' . $exterieur . '</span>
            </div>
            <div class="match-location">Stage : ' . $stage . '</div>
        </div>';
}

pg_free_result($result);

pg_close($conn);
$texte ='<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<link rel="stylesheet" href="match.css" />
<title>LES MATCHS DU CHAMPIONNAT</title>
</head>
<body>
    <div class="container">
        <a href="accueil.php">
            <img src="img/logofff.png" alt="Logo FFF" id="fff">
        </a>
        <h1 id="bandeau">LES MATCHS DU CHAMPIONNAT</h1>
    </div>
    
    <div class="bouton">
        <a href="accueil.php"><button>ACCUEIL</button></a>
        <a href="equipe.php"><button>LES JOUEURS ET LES ÉQUIPES DU CHAMPIONNAT</button></a>
        <a href="derby.php"><button>LES DERBY</button></a>
    </div>  
    <div class="rencontres">
        <div class="match-list">' . $données . '</div>
    </div>
    
    <footer>
        <p>&copy; Copyright 2025 &middot;<a href="mentions.html">Mentions légales</a></p>    
    </footer>
</body>
</html>';

echo $texte;
?>
