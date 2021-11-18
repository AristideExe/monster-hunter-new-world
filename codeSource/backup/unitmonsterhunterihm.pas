unit unitMonsterHunterIHM;

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
procedure demanderSexeIHM (var sexe : string);

//Affichage du personnage
procedure afficherPersonnageIHM(sexe : string);

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
     dessinerCadreXY(10,1,110,28,simple,White,Black);
     dessinerCadreXY(35,8,85,6,double,White,Black);
     deplacerCurseurXY(40,7);write ('Bienvenue sur Monster Hunter : New World');
     deplacerCurseurXY(50,12);write ('1) Nouvelle partie');
     deplacerCurseurXY(50,14);write ('2) Charger une partie');
     deplacerCurseurXY(50,16);write ('3) Afficher les credits');
     deplacerCurseurXY(50,18);write ('4) Quitter');

     //épée gauche
     deplacerCurseurXY(22,12);write ('.');
     deplacerCurseurXY(21,13);write ('/ \');
     deplacerCurseurXY(21,14);write ('| |');
     deplacerCurseurXY(21,15);write ('| |');
     deplacerCurseurXY(21,16);write ('|.|');
     deplacerCurseurXY(21,17);write ('|.|');
     deplacerCurseurXY(21,18);write ('|:|');
     deplacerCurseurXY(21,19);write ('|:|');
     deplacerCurseurXY(19,20);write ('`--8--'' ');
     deplacerCurseurXY(22,21);write ('8');
     deplacerCurseurXY(22,22);write ('0');

      //épée droite
     deplacerCurseurXY(98,12);write ('.');
     deplacerCurseurXY(97,13);write ('/ \');
     deplacerCurseurXY(97,14);write ('| |');
     deplacerCurseurXY(97,15);write ('| |');
     deplacerCurseurXY(97,16);write ('|.|');
     deplacerCurseurXY(97,17);write ('|.|');
     deplacerCurseurXY(97,18);write ('|:|');
     deplacerCurseurXY(97,19);write ('|:|');
     deplacerCurseurXY(95,20);write ('`--8--'' ');
     deplacerCurseurXY(98,21);write ('8');
     deplacerCurseurXY(98,22);write ('0');

     deplacerCurseurXY(50,20);write ('Votre choix : ');
     readln(menuIHM);
end;

// Affiche un message lorsque l'on quitte
procedure quitterIHM();
begin
     effacerEcran();
     dessinerCadreXY(44,14,69,16,double,White,Black);
     deplacerCurseurXY(47,15);write('A une prochaine fois');
     readln();
end;

// Affiche les crédits du jeu
procedure creditsIHM();
var i, n: integer;

begin
     effacerEcran();
     //---------TITRE--------------------------
     deplacerCurseurXY(1,1);write('Credits :');

     //--------AFFICHAGE MISE EN PAGE----------
     deplacerCurseurXY(0,2); write('________________________________________________________________________________________________________________________');
     n:=0;
     for i:= 0 to 29 DO

         begin
              deplacerCurseurXY(10,n+i);
              write('|');
         end;

     //------------------Remerciement----------------------
     dessinerCadreXY(38,6,89,8,double,White,Black);
     deplacerCurseurXY(40,7);write ('On remercie nos developpeurs pour leur travail :');

     //----------Placements des developpeurs-------------
     //----------------- QUENTIN ------------------------
     deplacerCurseurXY(25,11);write ('=} BOUCHOT Quentin : ');


     //------------------ HUGO --------------------------
     deplacerCurseurXY(25,16);write ('=} RODRIGUES Hugo : ');


     //----------------- ARISTIDE -----------------------
     deplacerCurseurXY(25,21);write ('=} PRORIOL Aristide : ');


     //----------------- LEANDRE ------------------------
     deplacerCurseurXY(25,26);write ('=} MOREAU Leandre : ');


     write('Credits : ............');
     deplacerCurseurXY(43,1);write ('Appuyez sur entre pour revenir au menu');
     readln();
end;

procedure afficherPersonnageIHM(sexe : string);
//---------Création affichage du personnage Homme ou Femme------
begin
     if sexe ='F' then
     //Visage Homme
     deplacerCurseurXY(70,5);write ('//||||\\');
     deplacerCurseurXY(71,6);write ('| o o|');
     deplacerCurseurXY(71,7);write ('|  > |');
     deplacerCurseurXY(72,8);write ('\__/');

          deplacerCurseurXY(69,9);write ('___/  \___');
          deplacerCurseurXY(68,10);write ('/          \');
          deplacerCurseurXY(67,11);write ('/ |        | \');
          deplacerCurseurXY(66,12);write ('/ /|        |\ \');
          deplacerCurseurXY(65,13);write ('/ /  \ ____ /  \ \');
          deplacerCurseurXY(64,14);write ('/ /    |____|    \ \');
          deplacerCurseurXY(63,15);write ('/_/    /      \    \_\');
          deplacerCurseurXY(63,16);write ('\_/   /        \   \_/');
          deplacerCurseurXY(68,17);write ('/__________\');
          deplacerCurseurXY(67,18);write ('/------------\');
          deplacerCurseurXY(71,19);write ('| | | |');
          deplacerCurseurXY(71,20);write ('| | | |');
          deplacerCurseurXY(71,21);write ('|_| |_|');
          deplacerCurseurXY(70,22);write ('/__| |__\');
     end
     else
     begin
          //Visage Homme
     deplacerCurseurXY(71,5);write ('//||||\\');
     deplacerCurseurXY(72,6);write ('| o o|');
     deplacerCurseurXY(72,7);write ('|  > |');
     deplacerCurseurXY(73,8);write ('\__/');
     deplacerCurseurXY(67,9);write ('______/  \______');
     deplacerCurseurXY(66,10);write ('/                \');
     deplacerCurseurXY(65,11);write ('/  /            \  \');
     deplacerCurseurXY(64,12);write ('/  /|            |\  \');
     deplacerCurseurXY(63,13);write ('/  / |            | \  \');
     deplacerCurseurXY(63,14);write ('|  |  \          /  |  |');
     deplacerCurseurXY(63,15);write ('|__|   |________|   |__|');
     deplacerCurseurXY(63,16);write ('\__/   |________|   \__/');
     deplacerCurseurXY(70,17);write ('/   __   \');
     deplacerCurseurXY(70,18);write ('|  |  |  |');
     deplacerCurseurXY(70,19);write ('|  |  |  |');
     deplacerCurseurXY(70,20);write ('|  |  |  |');
     deplacerCurseurXY(70,21);write ('|  |  |  |');
     deplacerCurseurXY(70,22);write ('|__|  |__|');
     deplacerCurseurXY(69,23);write ('/___|  |___\');

     end;

     readln;  //Laisse afficher les visages a l'écran
end;

//Demande le sexe en fonction de la réponse précédente
procedure demanderSexeIHM (var sexe : string);
begin

     //Efface l'écran et réaffiche nom et taille mais redemande le sexe
     effacerEcran();
     dessinerCadreXY(14,10,37,16,simple,White,Black);
     deplacerCurseurXY(15,11);write('nom : ',getJoueur().nom);
     deplacerCurseurXY(15,13);write('taille : ',getJoueur().taille);
     deplacerCurseurXY(15,15);write('sexe (''M'' ou ''F'') : ');readln(sexe);
end;

// Affiche le menu de création de personnage
procedure creationPersonnageIHM(var nom, taille, sexe : string);
begin
     effacerEcran();

     //Information personnage (nom taille et sexe)
     dessinerCadreXY(14,10,37,16,simple,White,Black);
     deplacerCurseurXY(15,11);write('nom : ');readln(nom);
     deplacerCurseurXY(15,13);write('taille : ');readln(taille);
     deplacerCurseurXY(15,15);write('sexe (''M'' ou ''F'') : ');readln(sexe);

end;





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
     for i:=0 to 4 do
     begin
          // Titre du menu
          deplacerCurseurXY(5,1);write('Chambre');


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
     deplacerCurseurXY(10,27); write('1/ Retourner a la ville,    2/ Ouvrir l''armoire a armures,    3/ Ouvrir la malle a armes');
     deplacerCurseurXY(10,28); write('Votre choix : ');
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





// Afficher une seule armure
procedure afficherArmureIHM(numeroArmure : integer; armure : typeArmure);
begin
     write(numeroArmure + 1, ' : ' ,armure.nom);
     // Si la défense de l'armure est supérieur à celle que l'on possède alors on affiche un plus en vert
     if (armure.valeurDefense >= getArmureJoueur(armure.pieceArmure).valeurDefense) then
     begin
          couleurTexte(Green);
          write(' D+',(getArmureJoueur(armure.pieceArmure).valeurDefense - armure.valeurDefense):6:2);
          couleurTexte(White);
     end
     else
     begin
          couleurTexte(Red);
          write(' D-',(armure.valeurDefense - getArmureJoueur(armure.pieceArmure).valeurDefense):6:2);
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




     deplacerCurseurXY(5,25); write('0/ Retourner a la chambre');
     deplacerCurseurXY(4,26); write('-1/ Afficher les casques     -2/ Afficher les plastrons       -3/ Afficher les jambieres');
     deplacerCurseurXY(4,27); write('-4/ Afficher les bottes      -5/ Afficher les gants');
     deplacerCurseurXY(5,28); write('Votre choix : ');


     readln(armoireIHM);
end;

// Malle à armes
function malleIHM() : string;
begin
     effacerEcran();
     write('Malle');
     readln(malleIHM);
end;

end.
