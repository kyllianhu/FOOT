<?php 
$texte = '<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<link rel="stylesheet" href="accueil.css" />
<title>CHAMPIONNAT DE LIGUE 1 2015/2016</title>
</head>
<body>
	<div class="container">
		<img src="img/logofff.png" alt="Logo FFF" id="fff">
		<h1 id="bandeau">CHAMPIONNAT DE LIGUE 1 2015/2016</h1>	
	<div class="bouton">	
		<a href="connexion.php"><button>CONNEXION</button></a>
	</div>
	</div>
	<img src="img/fond.jpeg" alt="Fond de page" id="fond">
	
	<div class="bouton">
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