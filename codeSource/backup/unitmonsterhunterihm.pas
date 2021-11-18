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
procedure chambreIHM();

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

     //----------Placements des devellopeurs-------------
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
begin
     if sexe ='F' then
     begin
          //Visage Femme
          deplacerCurseurXY(70,5);write ('//||||\\');
          deplacerCurseurXY(69,6);write ('//| o o|\\');
          deplacerCurseurXY(69,7);write ('|||  > |||');
          deplacerCurseurXY(69,8);write ('|| \__/ ||');
     end
     else
     begin
     //Visage Homme
     deplacerCurseurXY(70,5);write ('//||||\\');
     deplacerCurseurXY(71,6);write ('| o o|');
     deplacerCurseurXY(71,7);write ('|  > |');
     deplacerCurseurXY(72,8);write ('\__/');
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

     deplacerCurseurXY(53,26);write ('Votre choix : ');

     readln(villeIHM);
end;







// Chambre
procedure chambreIHM();
var
  i : integer;
begin
     effacerEcran();
     for i:=0 to 4 do
     begin
          deplacerCurseurXY(10,i*5+1);
          if (getJoueur.armurePortee[i].nom <> 'NULL') then
          begin
               write(typePieceArmure(i),' : ',getJoueur.armurePortee[i].nom);
               deplacerCurseurXY(10,i*5+2);
               write('Durabilite : ', getJoueur.armurePortee[i].durabilite, ' , Valeur de defense :',getJoueur.armurePortee[i].valeurDefense:6:2, ' , Taux d''esquive :', getJoueur.armurePortee[i].tauxEsquive:6:2);
          end
          else
          begin
               write('Pas de ', typePieceArmure(i) , ' equipe(es).');
          end;
     end;
     readln();
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
     deplacerCurseurXY(50,5);write ('Choisir les ingredients :');
     readln;
end;

end.

