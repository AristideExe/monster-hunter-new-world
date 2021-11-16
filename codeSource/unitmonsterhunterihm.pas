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
          deplacerCurseurXY(50,12);write ('//||||\\');
          deplacerCurseurXY(49,13);write ('//| o o|\\');
          deplacerCurseurXY(51,14);write ('|  > |');
          deplacerCurseurXY(52,15);write ('\__/');
     end
     else
     begin
     //Visage Homme
     deplacerCurseurXY(50,12);write ('//||||\\');
     deplacerCurseurXY(51,13);write ('| o o|');
     deplacerCurseurXY(51,14);write ('|  > |');
     deplacerCurseurXY(52,15);write ('\__/');
     end;

     readln;  //Laisse afficher les visages a l'écran
end;

//Demande le sexe en fonction de la réponse précédente
procedure demanderSexeIHM (var sexe : string);
begin

     //Efface l'écran et réaffiche nom et taille mais redemande le sexe
     effacerEcran();
     dessinerCadreXY(14,10,37,16,simple,White,Black);
     deplacerCurseurXY(15,12);write('nom : ',getJoueur().nom);
     deplacerCurseurXY(15,13);write('taille : ',getJoueur().taille);
     deplacerCurseurXY(15,14);write('sexe (''M'' ou ''F'') : ');readln(sexe);
end;

// Affiche le menu de création de personnage
procedure creationPersonnageIHM(var nom, taille, sexe : string);
begin
     effacerEcran();

     //Information personnage (nom taille et sexe)
     dessinerCadreXY(14,10,37,16,simple,White,Black);
     deplacerCurseurXY(15,12);write('nom : ');readln(nom);
     deplacerCurseurXY(15,13);write('taille : ');readln(taille);
     deplacerCurseurXY(15,14);write('sexe (''M'' ou ''F'') : ');readln(sexe);

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

     //Bateau d'attaque
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
     deplacerCurseurXY(53,26);write ('Votre choix : ');

     //route centrale
     ColorierZone(Green,Cyan, 41,89,10);
     ColorierZone(Green,Cyan, 30,84,20);
     ColorierZone(Green,Cyan, 46,47,11);
     ColorierZone(Green,Cyan, 46,47,12);
     ColorierZone(Green,Cyan, 46,47,13);
     ColorierZone(Green,Cyan, 46,47,14);
     ColorierZone(Green,Cyan, 46,47,15);
     ColorierZone(Green,Cyan, 46,47,16);
     ColorierZone(Green,Cyan, 46,47,17);
     ColorierZone(Green,Cyan, 46,47,18);
     ColorierZone(Green,Cyan, 46,47,19);
     ColorierZone(Green,Cyan, 75,76,11);
     ColorierZone(Green,Cyan, 75,76,12);
     ColorierZone(Green,Cyan, 75,76,13);
     ColorierZone(Green,Cyan, 75,76,14);
     ColorierZone(Green,Cyan, 75,76,15);
     ColorierZone(Green,Cyan, 75,76,16);
     ColorierZone(Green,Cyan, 75,76,17);
     ColorierZone(Green,Cyan, 75,76,18);
     ColorierZone(Green,Cyan, 75,76,19);

     //arbre
     deplacerCurseurXY(61,11);write ('/\');
     deplacerCurseurXY(60,12);write ('/__\');
     deplacerCurseurXY(59,13);write ('/ __ \');
     deplacerCurseurXY(58,14);write ('/__--__\');
     deplacerCurseurXY(61,15);write ('||');
     deplacerCurseurXY(61,16);write ('||');

     readln(villeIHM);
end;







// Chambre
procedure chambreIHM();
begin
     effacerEcran();
     write('Chambre');
     readln();
end;

end.

