<?php
Include_once("myParam.inc.php");
$conn = pg_connect('host='.HOST.' dbname=FOOT user='.USER.' password='.PASS);
if (!$conn) {
    die("Erreur de connexion : " . pg_last_error()); 
}

$sql = "SELECT * FROM LesJoueurs" ;
$result = pg_query($conn, $sql);
if (!$result) {
    die("Erreur dans la requête SQL : " . pg_last_error());
}
$données = '';
while ($row = pg_fetch_row($result)) {
    $joueur = $row[0];
    $anniv = $row[1];
    $photo = $row[2];
    $nomequipe = $row[3];
    $surnomequipe = $row[4];
    $shortequipe = $row[5];
    $annivequipe = $row[6];
    $villeequipe = $row[7];
    $photoequipe = $row[8];
    $données .= '
        <div class="joueur">
            <img src="' . $photo . '" alt="Photo de ' . $joueur . '" class="photo-joueur">
            <div class="info-joueur">
                <p><strong>Joueur :</strong> ' . $joueur . '</p>
                <p><strong>Anniversaire :</strong> ' . $anniv . '</p>
                <p><strong>Équipe :</strong> ' . $nomequipe . ' (' . $surnomequipe . ' - ' . $shortequipe . ')</p>
                <p><strong>Ville :</strong> ' . $villeequipe . '</p>
            </div>
            <img src="' . $photoequipe . '" alt="Photo de l\'équipe ' . $nomequipe . '" class="photo-equipe">
        </div>';
}

pg_free_result($result);

pg_close($conn);
$texte ='<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<link rel="stylesheet" href="joueur.css" />
<title>LES JOUEURS ET LES ÉQUIPES</title>
</head>
<body>
    <div class="container">
        <a href="accueil.php">
            <img src="img/logofff.png" alt="Logo FFF" id="fff">
        </a>
        <h1 id="bandeau">LES JOUEURS ET LES ÉQUIPES DU CHAMPIONNAT</h1>
    </div>
    
    <div class="bouton">
        <a href="accueil.php"><button>ACCUEIL</button></a>
        <a href="match.php"><button>LES MATCHS DU CHAMPIONNAT</button></a>
    </div>  
    <div class="joueurs-container">
        ' . $données . '
    </div>
    
    <footer>
        <p>&copy; Copyright 2025 &middot;<a href="mentions.html">Mentions légales</a></p>    
    </footer>
</body>
</html>';

echo $texte;
?>
