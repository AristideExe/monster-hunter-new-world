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
     //---------Titre--------------------------
     deplacerCurseurXY(1,1);write('Credits :');

              //--------Affichage mise en page----------
     //---Affichage ligne horizontale---
     n:=0;
     for i:= 0 to 119 DO

         begin
             deplacerCurseurXY(n+i,2);
             write('_');
         end;

     //---Affichage ligne verticale---
     n:=0;
     for i:= 0 to 29 DO

         begin
              deplacerCurseurXY(10,n+i);
              write('|');
         end;

     //-----------Affichage du texte pour revenir sur le menu--------------
     deplacerCurseurXY(43,1);write ('Appuyez sur entre pour revenir au menu');

     //----------Placements des developpeurs-------------
     //----------------- QUENTIN ------------------------
     deplacerCurseurXY(25,11);write ('=} BOUCHOT Quentin : ');


     //------------------ HUGO --------------------------
     deplacerCurseurXY(25,16);write ('=} RODRIGUES Hugo : ');


     //----------------- ARISTIDE -----------------------
     deplacerCurseurXY(25,21);write ('=} PRORIOL Aristide : ');


     //----------------- LEANDRE ------------------------
     deplacerCurseurXY(25,26);write ('=} MOREAU Leandre : ');

              //------------------Remerciement----------------------
     dessinerCadreXY(38,6,89,8,double,White,Black);
     deplacerCurseurXY(40,7);write ('On remercie nos developpeurs pour leur travail :');
     readln();
end;


procedure afficherPersonnageIHM(sexe : string);
//---------Création affichage du personnage Homme ou Femme------
begin
     if sexe ='F' then
     begin
          //Visage Femme
          deplacerCurseurXY(80,7);write ('//||||\\');
          deplacerCurseurXY(79,8);write ('//| o o|\\');
          deplacerCurseurXY(79,9);write ('|||  > |||');
          deplacerCurseurXY(79,10);write ('|| \__/ ||');
          deplacerCurseurXY(79,11);write ('___/  \___');
          deplacerCurseurXY(78,12);write ('/          \');
          deplacerCurseurXY(77,13);write ('/ |        | \');
          deplacerCurseurXY(76,14);write ('/ /|        |\ \');
          deplacerCurseurXY(75,15);write ('/ /  \ ____ /  \ \');
          deplacerCurseurXY(74,16);write ('/ /    |____|    \ \');
          deplacerCurseurXY(73,17);write ('/_/    /      \    \_\');
          deplacerCurseurXY(73,18);write ('\_/   /        \   \_/');
          deplacerCurseurXY(78,19);write ('/__________\');
          deplacerCurseurXY(77,20);write ('/------------\');
          deplacerCurseurXY(81,21);write ('| | | |');
          deplacerCurseurXY(81,22);write ('| | | |');
          deplacerCurseurXY(81,23);write ('|_| |_|');
          deplacerCurseurXY(80,24);write ('/__| |__\');
     end
     else
     begin
          //Visage Homme
     deplacerCurseurXY(80,7);write ('//||||\\');
     deplacerCurseurXY(81,8);write ('| o o|');
     deplacerCurseurXY(81,9);write ('|  > |');
     deplacerCurseurXY(82,10);write ('\__/');
     deplacerCurseurXY(76,11);write ('______/  \______');
     deplacerCurseurXY(75,12);write ('/                \');
     deplacerCurseurXY(74,13);write ('/  /            \  \');
     deplacerCurseurXY(73,14);write ('/  /|            |\  \');
     deplacerCurseurXY(72,15);write ('/  / |            | \  \');
     deplacerCurseurXY(72,16);write ('|  |  \          /  |  |');
     deplacerCurseurXY(72,17);write ('|__|   |________|   |__|');
     deplacerCurseurXY(72,18);write ('\__/   |________|   \__/');
     deplacerCurseurXY(79,19);write ('/   __   \');
     deplacerCurseurXY(79,20);write ('|  |  |  |');
     deplacerCurseurXY(79,21);write ('|  |  |  |');
     deplacerCurseurXY(79,22);write ('|  |  |  |');
     deplacerCurseurXY(79,23);write ('|  |  |  |');
     deplacerCurseurXY(79,24);write ('|__|  |__|');
     deplacerCurseurXY(78,25);write ('/___|  |___\');
     end;

     readln;  //Laisse afficher les visages a l'écran
end;

//Décoration de la page de création de personnage
procedure decorationPersoIHM(titre : string);
begin

     //---------Affichage cadre création du personnage---------
     dessinerCadreXY(4,2,116,28,double,White,Black);
     deplacerCurseurXY(40,0);write('______________________');
     deplacerCurseurXY(39,1);write('/                      \');
     deplacerCurseurXY(38,2);write('{ ',titre,' }');
     deplacerCurseurXY(39,3);write('\______________________/');

         //---Affichage décorations pour les questions-----
     //-----Affichage cadre pour le Nom-----
     deplacerCurseurXY(15,6);write('______________________');
     deplacerCurseurXY(14,7);write('/                      \');
     deplacerCurseurXY(13,8);write('{');
     deplacerCurseurXY(38,8);write('}');
     deplacerCurseurXY(14,9);write('\______________________/');

     //-----Affichage cadre pour la Taille-----
     deplacerCurseurXY(15,14);write('______________________');
     deplacerCurseurXY(14,15);write('/                      \');
     deplacerCurseurXY(13,16);write('{');
     deplacerCurseurXY(38,16);write('}');
     deplacerCurseurXY(14,17);write('\______________________/');



     //-----Affichage cadre pour le Sexe-----
     deplacerCurseurXY(15,22);write('______________________');
     deplacerCurseurXY(14,23);write('/                      \');
     deplacerCurseurXY(13,24);write('{');
     deplacerCurseurXY(38,24);write('}');
     deplacerCurseurXY(14,25);write('\______________________/');

end;

//Demande le sexe en fonction de la réponse précédente
procedure demanderSexeIHM (var sexe : string);
begin

     //Efface l'écran et réaffiche nom et taille et la décoration mais redemande le sexe
     effacerEcran();

     decorationPersoIHM('Creation de personnage');

     deplacerCurseurXY(15,8);write('Nom :',getJoueur().nom);


     deplacerCurseurXY(15,16);write('Taille :',getJoueur().taille);


     deplacerCurseurXY(15,24);write('Sexe (''M'' ou ''F''):');

     //-------Réponses aux questions-------
     deplacerCurseurXY(33,24);write(' '); readln(sexe);

end;

// Affiche le menu de création de personnage
procedure creationPersonnageIHM(var nom, taille, sexe : string);
begin
     effacerEcran();
     decorationPersoIHM('Creation de personnage');

     //Information personnage (nom taille et sexe)

     deplacerCurseurXY(15,8);write('Nom :');

     deplacerCurseurXY(15,16);write('Taille :');


     deplacerCurseurXY(15,24);write('Sexe (''M'' ou ''F''):');

          //-------Réponses aux questions-------
     deplacerCurseurXY(20,8);write(' '); readln(taille);
     deplacerCurseurXY(23,16);write(' '); readln(nom);
     deplacerCurseurXY(33,24);write(' '); readln(sexe);

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
          deplacerCurseurXY(10,i*5+1);
          // Si le joueur ne porte pas de piece d'armure
          if (getJoueur.armurePortee[i].nom <> 'NULL') then
          begin
               write(typePieceArmure(i),' : ',getJoueur.armurePortee[i].nom);
               deplacerCurseurXY(10,i*5+2);
               write('Durabilite : ', getJoueur.armurePortee[i].durabilite, ' , Valeur de defense :',getJoueur.armurePortee[i].valeurDefense:6:2, ' , Taux d''esquive :', getJoueur.armurePortee[i].tauxEsquive:6:2);
          end
          // Si le joueur porte une pièce d'armure
          else
          begin
               write('Pas de ', typePieceArmure(i) , ' equipe(es).');
          end;
     end;
     deplacerCurseurXY(10,27); write('1/ Retourner a la ville,    2/ Ouvrir l''armoire a armures,    3/ Ouvrir la malle a armes');
     deplacerCurseurXY(10,28); write('Votre choix : ');
     readln(chambreIHM);
end;

end.

