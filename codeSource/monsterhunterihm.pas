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
function chambreIHM() : string;
// Armoire à armures
function armoireIHM(NumeroArmureAAfficher : integer;titre : string) : string;
// Malle à armes
function malleIHM() : string;

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
var
  y,i : integer;
begin
     effacerEcran();
     // Chambre du personage
     dessinerCadreXY(10,16,29,22,simple,White,Black);
     deplacerCurseurXY(15,19);write('1/Chambre');

     // Cantine du village
     dessinerCadreXY(90,7,109,13,simple,White,Black);
     deplacerCurseurXY(95,10);write('4/Cantine');

     // Marchand du village
     dessinerCadreXY(85,16,105,22,simple,White,Black);
     deplacerCurseurXY(90,19);write('3/Marchand');

     // Forge du village
     dessinerCadreXY(20,7,40,13,simple,White,Black);
     deplacerCurseurXY(26,10);write('2/Forge');

     //Bateau d'exploration
     deplacerCurseurXY(61,1);write(')');
     deplacerCurseurXY(60,1);write('|');
     deplacerCurseurXY(57,2);write('______');
     deplacerCurseurXY(60,2);write('|');
     couleurTexte(Blue);
     deplacerCurseurXY(35,3);write('~~~~~~~~~~~~~~~~~~~~~~~~');
     couleurTexte(White);
     deplacerCurseurXY(57,3);write('\____/');
     couleurTexte(Blue);
     deplacerCurseurXY(63,3);write('~~~~~~~~~~~~~~~~~~~~~~~~');
     deplacerCurseurXY(32,4);write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
     couleurTexte(White);
     deplacerCurseurXY(57,5);write('5/Expedition');


     // Insertion d'une proposition
     dessinerCadreXY(50,25,70,27,simple,White,Black);

     //route Nord

     //route centrale

     ColorierZone(Green,Cyan, 41,89,10);
     //Route Sud
     ColorierZone(Green,Cyan, 30,84,20);
     //Route Ouest
      y:=11;
      for i:=1 to 9 do
      begin;
            ColorierZone(Green,Cyan, 46,47,y);
            y:=y+1
      end;
     //Route Est
     y:=11;
     for i:=1 to 9 do
     begin;
           ColorierZone(Green,Cyan, 75,76,y);
           y:=y+1
     end;

     //arbre
     deplacerCurseurXY(61,11);write ('/\');
     deplacerCurseurXY(60,12);write ('/__\');
     deplacerCurseurXY(59,13);write ('/ __ \');
     deplacerCurseurXY(58,14);write ('/__--__\');
     deplacerCurseurXY(61,15);write ('||');
     deplacerCurseurXY(61,16);write ('||');



     // Insertion d'une proposition
     dessinerCadreXY(50,25,70,27,simple,White,Black);

     deplacerCurseurXY(53,26);write ('Votre choix : ');

     readln(villeIHM);
end;







{Chambre : 3 choix :
- 1 : retourner à la ville
- 2 : ouvrir l'armoire des armures
- 3 : ouvrir le coffre des armes}
function chambreIHM() : string;
var
  i : integer;
begin
     effacerEcran();
     // Titre du menu
     deplacerCurseurXY(5,1);write('Chambre');
     // Affichage des armures
     for i:=0 to 4 do
     begin
          deplacerCurseurXY(10,i*5+3);
          // Si le joueur porte une pièce d'armure
          if (getJoueur.armurePortee[i].nom <> 'NULL') then
          begin
               write(typePieceArmure(i),' : ',getJoueur.armurePortee[i].nom);
               deplacerCurseurXY(10,i*5+4);
               write('Valeur de defense :',getJoueur.armurePortee[i].valeurDefense:6:2, ' , Taux d''esquive :', getJoueur.armurePortee[i].tauxEsquive:6:2);
          end
          // Si le joueur ne porte pas de piece d'armure
          else
          begin
               write('Pas de ', typePieceArmure(i) , ' equipe(es).');
          end;
     end;

     // Affichage des stats de l'arme
     deplacerCurseurXY(70,14); write(getJoueur.armePortee.arme,' : ',getJoueur.armePortee.nom);
     deplacerCurseurXY(70,15); write('Valeur d''attaque : ', getJoueur.armePortee.valeurAttaque:6:2);

     // Affichage des choix
     deplacerCurseurXY(5,27); write('1/ Retourner a la ville,    2/ Ouvrir l''armoire a armures,    3/ Ouvrir la malle a armes');
     deplacerCurseurXY(5,28); write('Votre choix : ');
     readln(chambreIHM);
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


procedure afficherArmeIHM(numeroArme : integer; arme : typeArme);
begin
     write(numeroArme + 1, ' : ', arme.nom);
end;

// Afficher une seule armure
procedure afficherArmureIHM(numeroArmure : integer; armure : typeArmure);
begin
     write(numeroArmure + 1, ' : ' ,armure.nom);
     // Si la défense de l'armure est supérieur à celle que l'on possède alors on affiche un plus en vert
     if (armure.valeurDefense >= getArmureJoueur(armure.pieceArmure).valeurDefense) then
     begin
          couleurTexte(Green);
          write(' D+',(armure.valeurDefense - getArmureJoueur(armure.pieceArmure).valeurDefense):6:2);
          couleurTexte(White);
     end
     else
     begin
          couleurTexte(Red);
          write(' D-',(getArmureJoueur(armure.pieceArmure).valeurDefense - armure.valeurDefense):6:2);
          couleurTexte(White);
     end;

end;

// Armoire à armures
function armoireIHM(NumeroArmureAAfficher : integer;titre : string) : string;
var
  pieceArmure : typePieceArmure;
  pieceArmureInventaire : arrayPieceArmure;
  i : integer;
  nombreArmures : integer;
const
  NB_COLONNES = 2 ;
begin
     effacerEcran();
     // Ecriture du titre
     deplacerCurseurXY(5,1); write('Armoire - Selectionnez un numero pour choisir l''armure');
     // Nombre à côté de chaque armure que l'on va afficher et que l'utilisateur va choisir
     nombreArmures := 0;

     // La pièce de l'armure que l'on veut afficher
     pieceArmure := typePieceArmure(NumeroarmureAAfficher);
     // L'array qui contient les pièces que l'on veut
     pieceArmureInventaire := getPiecesPossedees(pieceArmure);


     deplacerCurseurXY(10,4);write(titre, ' : ');
     for i:=0 to length(pieceArmureInventaire)-1 do
     begin
          if (pieceArmureInventaire[i].nom <> 'NULL') then
          begin
            deplacerCurseurXY((nombreArmures mod NB_COLONNES) * 50 +5, (nombreArmures div NB_COLONNES)+6);
            afficherArmureIHM(nombreArmures,pieceArmureInventaire[i]);
            nombreArmures := nombreArmures + 1;
          end;
     end;
     // Si le joueur ne possède aucune armure de ce type
     if nombreArmures = 0 then
     begin
       deplacerCurseurXY(10,5);write('Aucune armure de cette sorte');
     end;



     // Affichage des choix
     deplacerCurseurXY(5,25); write('0/ Retourner a la chambre');
     deplacerCurseurXY(4,26); write('-1/ Afficher les casques     -2/ Afficher les plastrons       -3/ Afficher les jambieres');
     deplacerCurseurXY(4,27); write('-4/ Afficher les bottes      -5/ Afficher les gants');
     deplacerCurseurXY(5,28); write('Votre choix : ');


     readln(armoireIHM);
end;



// Malle à armes
function malleIHM() : string;
var
  i,nombreArmes : integer;
const
  NB_COLONNES = 2;
begin
     effacerEcran();
     // Ecriture du titre
     deplacerCurseurXY(5,1); write('Malle - Selectionnez un numero pour choisir une arme');

     // Affichage de toutes les armes
     nombreArmes := 0;
     for i:=0 to length(getJoueur.armesPossedees)-1 do
     begin
          if (joueur.armesPossedees[i].nom <> 'NULL') then
          begin
            deplacerCurseurXY((nombreArmes mod NB_COLONNES) * 50 +5, (nombreArmes div NB_COLONNES)+6);
            afficherArmeIHM(nombreArmes,joueur.armesPossedees[i]);
            nombreArmes := nombreArmes + 1;
          end;
     end;


     // Affichage des choix
     deplacerCurseurXY(5,27); write('0/ Retourner a la chambre');
     deplacerCurseurXY(5,28); write('Votre choix : ');

     readln(malleIHM);
end;

end.
