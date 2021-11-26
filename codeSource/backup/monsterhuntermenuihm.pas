unit monsterHunterMenuIHM;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils,monsterHunterJoueur, GestionEcran;


// ------------------------------------------------- PROCEDURES ET FONCTIONS ---------------------------------------------
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
procedure afficherPersonnageIHM(sexe : string);
procedure demanderSexeIHM (var sexe : string);


// =========================================================================== IMPLEMENTATION ===================================================================================
implementation

{Affiche le menu de lancement de jeu et renvoie le choix de l'utilisateur
Choix numéro 1 : nouvelle partie
Choix numéro 2 : charger une partie
Choix numéro 3 : Afficher les crédits
Choix numéro 4 : Quitter}
function menuIHM() : string;                                                                                                                                                                                                                                                                                                                                                                                                                          .
begin
     effacerEcran();
     dessinerCadreXY(10,1,110,28,simple,White,Black);
     //dessinerCadreXY(35,8,85,6,double,White,Black);
     //deplacerCurseurXY(40,7);write ('Bienvenue sur Monster Hunter : New World');
     dessiner('dessins/logo.txt',40,3);
     deplacerCurseurXY(50,14);write ('1) Nouvelle partie');
     deplacerCurseurXY(50,16);write ('2) Charger une partie');
     deplacerCurseurXY(50,18);write ('3) Afficher les crédits');
     deplacerCurseurXY(50,20);write ('4) Quitter');

     // Épée gauche
     dessiner('dessins/epeeMenu.txt',19,12);
     // Épée droite
     dessiner('dessins/epeeMenu.txt',95,12);

     deplacerCurseurXY(50,22);write ('Votre choix : ');
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
end;



procedure afficherPersonnageIHM(sexe : string);
//---------Création affichage du personnage Homme ou Femme------
begin
     // Affichage de la femme et son nom
     if sexe ='F' then
     begin
       dessiner('dessins/femme.txt',73,10);
       deplacerCurseurXY(80-(length(getJoueur.nom) div 2),19);write(getJoueur.nom);
     end

     // Affichage de l'homme
     else
     begin
       dessiner('dessins/homme.txt',73,10);
       deplacerCurseurXY(79-(length(getJoueur.nom) div 2),19);write(getJoueur.nom);
     end;

     //Indique a l'utilisateur d'appuyer sur entrer pour continuer
     deplacerCurseurXY(63,24);write('Appuyez sur Entrée pour continuer ');
     readln;  //Laisse afficher les visages et le nom a l'écran
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

     deplacerCurseurXY(15,8);write('Nom :',getJoueur.nom);


     deplacerCurseurXY(15,16);write('Taille :',getJoueur.taille);


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
     deplacerCurseurXY(20,8);write(' '); readln(nom);
     deplacerCurseurXY(23,16);write(' '); readln(taille);
     deplacerCurseurXY(33,24);write(' '); readln(sexe);

end;
end.

