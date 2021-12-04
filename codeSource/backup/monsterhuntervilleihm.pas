unit MonsterHunterIHM;

{$mode objfpc}{$H+}
{$codepage utf8}

interface
uses
  Classes, SysUtils, GestionEcran;



{Affiche la ville et renvoie le choix de l'utilisateur
Choix numéro 1 : aller à la chambre
Choix numéro 2 : aller à la forge
Choix numéro 3 : voir le marchand
Choix numéro 4 : manger à la cantine
Choix numéro 5 : choisir un combat
}
function villeIHM() : string;
// Chambre
//function chambreIHM() : string;
// Armoire à armures


//Bateau exploration
procedure explorationIHM();

//Cantine
procedure cantineIHM();



implementation
uses monsterHunterJoueur,monsterHunterArmesEtArmures;





{Affiche la ville et renvoie le choix de l'utilisateur
Choix numéro 1 : aller à la chambre
Choix numéro 2 : aller à la forge
Choix numéro 3 : voir le marchand
Choix numéro 4 : manger à la cantine
Choix numéro 5 : choisir un combat
}
function villeIHM() : string;
begin
     changerTailleConsole(120,30);
     effacerEcran();
     // Chambre du personage
     //dessinerCadreXY(10,16,29,22,simple,White,Black);
     //deplacerCurseurXY(10,19);write('1/Chambre');
     dessiner('dessins/maisonChambre.txt',3,18);
     deplacerCurseurXY(10,27);write('1/ Chambre');


     // Cantine du village

     //dessinerCadreXY(90,7,109,13,simple,White,Black);
     //deplacerCurseurXY(95,10);write('4/Cantine');

     // Forge du village
     //dessinerCadreXY(20,7,40,13,simple,White,Black);
     //deplacerCurseurXY(26,10);write('2/Forge');
     dessiner('dessins/maisonForge.txt',8,1);
     deplacerCurseurXY(17,16);write('2/ Forge');


     // Marchand du village
     //dessinerCadreXY(90,7,109,13,simple,White,Black);
     //deplacerCurseurXY(95,10);write('3/Marchand');
     dessiner('dessins/maisonMarchand.txt',94,5);
     deplacerCurseurXY(100,14);write('3/ Marchand');

     // Cantine du village
     //dessinerCadreXY(85,16,105,22,simple,White,Black);
     //deplacerCurseurXY(90,19);write('3/Cantine');
     dessiner('dessins/maisonCantine.txt',88,18);
     deplacerCurseurXY(95,27);write('4/ Cantine');

     //Bateau d'exploration
     dessinCouleurSansEspaces('dessins/bateau.txt',34,0);
     deplacerCurseurXY(55,5);write('5/ Expedition');


     //Arbre d village
     dessinCouleurSansEspaces('dessins/Arbre.txt',47,9);

     deplacerCurseurXY(51,24);write ('6/ Revenir au menu');

     // Insertion d'une proposition
     dessinerCadreXY(50,25,70,27,simple,White,Black);

     deplacerCurseurXY(53,26);write ('Votre choix : ');

     readln(villeIHM);
end;


//Bateau exploration
procedure explorationIHM();
begin
     effacerEcran();
     dessinerCadreXY(45,4,74,6,simple,White,Black);
     deplacerCurseurXY(47,5);write ('Vous partez en exploration');
     deplacerCurseurXY(47,12);write ('Choix de la difficulte :');
     deplacerCurseurXY(74,12);write ('1 : *');
     deplacerCurseurXY(74,13);write ('2 : **');
     deplacerCurseurXY(74,14);write ('3 : ***');
     deplacerCurseurXY(74,15);write ('4 : ****');
     deplacerCurseurXY(74,16);write ('5 : *****');
     deplacerCurseurXY(47,14);write ('Votre choix :');
     deplacerCurseurXY(47,25);write ('Retour : 0');
     deplacerCurseurXY(61,14);
     readln;
end;

procedure cantineIHM();
begin
     effacerEcran();
     deplacerCurseurXY(57,5);write ('Cuisine');
     deplacerCurseurXY(50,8);write ('Choisir les ingredients :');
     deplacerCurseurXY(20,25);write ('Faire cuire : 1');
     deplacerCurseurXY(90,25);write ('Retour : 0');
     readln;
end;




end.
