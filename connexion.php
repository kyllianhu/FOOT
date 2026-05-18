<?php 

include_once("formulaire_connexion.php");

$texte = '<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<link rel="stylesheet" href="accueil.css" />
<title>CONNEXION</title>
</head>
<body>
	<div class="container">
		<img src="https://web-statics.fff.fr/img/logo.png" alt="Logo FFF" id="fff">
		<h1 id="bandeau">CONNEXION</h1>
		<div class="bouton">
		</div>
	</div>
	<img src="https://fff.twic.pics/https://media.fff.fr/uploads/images/2831801bb576ce1082b23a91c2457453.jpeg?twic=v1/focus=2696x920/resize=1600" alt="Fond de page" id="fond">
	
 ';
 $texte = formulaire_connexion();

$texte = $texte. '	<div class="bouton">
		<a href="match.php"><button>LES MATCHS DU CHAMPIONNAT</button></a>
		<a href="equipe.php"><button>LES JOUEURS ET ÉQUIPES</button></a>
	</div>
	
	<footer>
		<p>&copy; Copyright 2025 &middot;<a href="mentions.html">Mentions légales</a></p>	
	</footer>
</body>
</html>';

echo $texte;
?>