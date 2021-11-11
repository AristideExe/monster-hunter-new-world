unit unitMonsterHunterHIM;

{$mode objfpc}{$H+}

interface

{Affiche le menu de lancement de jeu et renvoie le choix de l'utilisateur
Choix numéro 1 : nouvelle partie
Choix numéro 2 : charger une partie
Choix numéro 3 : Afficher les crédits
Choix numéro 4 : Quitter}
function menuIHM() : string;
// Affiche un message lorsque l'on quitte
procedure quitterIHM();
// Affiche les crédits du jeu
procedure creditsIHM();
// Affiche le menu de création de personnage
procedure creationPersonnageIHM(var nom, taille, sexe : string);

{Affiche la ville et renvoie le choix de l'utilisateur
Choix numéro 1 : aller à la chambre
Choix numéro 2 : aller à la forge
Choix numéro 3 : voir le marchand
Choix numéro 4 : manger à la cantine
Choix numéro 5 : choisir un combat
}
function villeIHM() : string;





implementation
uses
  Classes, SysUtils, unitMonsterHunterLogic,GestionEcran;



{Affiche le menu de lancement de jeu et renvoie le choix de l'utilisateur
Choix numéro 1 : nouvelle partie
Choix numéro 2 : charger une partie
Choix numéro 3 : Afficher les crédits
Choix numéro 4 : Quitter}
function menuIHM() : string;
begin
     effacerEcran();
     dessinerCadreXY(10,1,110,25,simple,White,Black);
     dessinerCadreXY(35,8,85,6,double,White,Black);
     deplacerCurseurXY(40,7);write ('Bienvenue sur Monster Hunter : New World');
     deplacerCurseurXY(50,12);write ('1) Nouvelle partie');
     deplacerCurseurXY(50,14);write ('2) Charger une partie');
     deplacerCurseurXY(50,16);write ('3) Afficher les credits');
     deplacerCurseurXY(50,18);write ('4) Quitter');
     deplacerCurseurXY(50,20);write ('Votre choix : ');
     readln(menuIHM);
end;

// Affiche un message lorsque l'on quitte
procedure quitterIHM();
begin
end;

// Affiche les crédits du jeu
procedure creditsIHM();
begin
     effacerEcran();
     write('Credits : ............');
     deplacerCurseurXY(50,18);write ('Appuyez sur entre pour revenir au menu');
     readln();
end;

// Affiche le menu de création de personnage
procedure creationPersonnageIHM(var nom, taille, sexe : string);
begin
     effacerEcran();
     write('nom : ');readln(nom);
     write('taille : ');readln(taille);
     write('sexe : ');readln(sexe);
end;






{Affiche la ville et renvoie le choix de l'utilisateur
Choix numéro 1 : aller à la chambre
Choix numéro 2 : aller à la forge
Choix numéro 3 : voir le marchand
Choix numéro 4 : manger à la cantine
Choix numéro 5 : choisir un combat
}
function villeIHM() : string;
begin
     effacerEcran();
     // Chambre du personage
     dessinerCadreXY(10,16,30,22,simple,White,Black);
     deplacerCurseurXY(17,19);write('1/Chambre');

     // Cantine du village
     dessinerCadreXY(90,7,110,13,simple,White,Black);
     deplacerCurseurXY(97,10);write('4/Cantine');

     // Marchand du village
     dessinerCadreXY(85,16,105,22,simple,White,Black);
     deplacerCurseurXY(92,19);write('3/Marchand');

     // Forge du village
     dessinerCadreXY(20,7,40,13,simple,White,Black);
     deplacerCurseurXY(27,10);write('2/Forge');

     //Bateau d'attaque
     deplacerCurseurXY(61,1);write(')');
     deplacerCurseurXY(60,1);write('|');
     deplacerCurseurXY(57,2);write('______');
     deplacerCurseurXY(60,2);write('|');
     deplacerCurseurXY(33,3);write('~~~~~~~~~~~~~~~~~~~~~~~~\____/~~~~~~~~~~~~~~~~~~~~~~~~');
     deplacerCurseurXY(32,4);write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
     deplacerCurseurXY(57,5);write('5/Combats');

     // Proposition Chambre
     //dessinerCadreXY(19,25,29,27,simple,White,Black);
     //deplacerCurseurXY(20,26);write('1/Chambre');

     // Proposition Forge
     //dessinerCadreXY(30,25,38,27,simple,White,Black);
     //deplacerCurseurXY(31,26);write('2/Forge');

     // Proposition Marchand
     //dessinerCadreXY(39,25,50,27,simple,White,Black);
     //deplacerCurseurXY(40,26);write('3/Marchand');

     // Proposition Cantine
     //dessinerCadreXY(51,25,61,27,simple,White,Black);
     //deplacerCurseurXY(52,26);write('4/Cantine');

     // Proposition Demarrer un combat
     //dessinerCadreXY(62,25,83,27,simple,White,Black);
     //deplacerCurseurXY(63,26);write('5/Demarrer un combat');

     // Insertion d'une proposition
     dessinerCadreXY(50,25,70,27,simple,White,Black);
     deplacerCurseurXY(53,26);write ('Votre choix : ');

     //route centrale
     //dessinerCadreXY(70,5,70,15,simple,White,Black);

     readln(villeIHM);
end;


end.

