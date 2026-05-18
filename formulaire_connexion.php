<?php

function formulaire_connexion(){
    $texte = "
        <form action='Accueil.php' method='post'>
            <label for='nom'>Votre nom :</label>
            <input type='text' id='nom' name='nom'> 
            <label for='mdp'>Votre mot de passe :</label>
            <input type='text' id='mdp' name='mdp'>
            <br/><br/> 
            <button type='submit'>Envoyer</button>
        </form>";
    
    return $texte;
}
?>