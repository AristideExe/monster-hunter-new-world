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
// Affiche un message quand on charge la sauvegarde
procedure sauvegardeIHM();
// Affiche les crédits du jeu
procedure creditsIHM();
// Affiche le menu de création de personnage
procedure creationPersonnageIHM(var nom, taille, sexe : string);
procedure afficherPersonnageIHM(sexe : string);

procedure affichageLogo();


// =========================================================================== IMPLEMENTATION ===================================================================================
implementation

procedure affichageLogo();
var
  i : integer;
  titre : string;
begin
     changerTailleConsole(120,30);

     // Affichage du logo
     for i:=1 to 13 do
     begin
       dessiner('dessins/logo/'+intToStr(i)+'.txt',40,9);
       attendre(150);
     end;

     // Affichage du sous-titre
     titre := 'New world';
     for i:=0 to length(titre) do
     begin
       deplacerCurseurXY(i+56,17); write(titre[i]);
       attendre(100);
     end;
     attendre(600);
end;

{Affiche le menu de lancement de jeu et renvoie le choix de l'utilisateur
Choix numéro 1 : nouvelle partie
Choix numéro 2 : charger une partie
Choix numéro 3 : Afficher les crédits
Choix numéro 4 : Quitter}
function menuIHM() : string;
begin
     effacerEcran();
     dessinerCadreXY(10,1,110,28,simple,White,Black);
     //dessinerCadreXY(35,8,85,6,double,White,Black);
     //deplacerCurseurXY(40,7);write ('Bienvenue sur Monster Hunter : New World');
     dessiner('dessins/logo/logo.txt',40,3);
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

// Affiche un message quand on charge la sauvegarde
procedure sauvegardeIHM();
begin
     dessinerCadreXY(30,12,90,18,double,White,Black);
     deplacerCurseurXY(43,14);write('Disponible dans une prochaine MAJ');
     deplacerCurseurXY(42,16);write('Appuyez sur entrée pour continuer ');
     readln;
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
procedure decorationPersoIHM();
begin

     //---------Affichage cadre création du personnage---------
      CadrePrincipal('Création de personnage');

         //---Affichage décorations pour les questions-----
     //-----Affichage cadre pour le Nom-----
     deplacerCurseurXY(15,6);write('____________________________________________________');
     deplacerCurseurXY(14,7);write('/                                                    \');
     deplacerCurseurXY(13,8);write('{');
     deplacerCurseurXY(68,8);write('}');
     deplacerCurseurXY(14,9);write('\____________________________________________________/');

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

procedure tailleNomInvalideIHM();
begin
     dessinerCadreXY(30,12,90,18,double,White,Black);
     deplacerCurseurXY(42,14);write('La taille de votre nom est invalide');
     deplacerCurseurXY(43,16);write('Appuyez sur entrée pour continuer ');
     readln;
end;

// Affiche le menu de création de personnage
procedure creationPersonnageIHM(var nom, taille, sexe : string);
begin
     effacerEcran();
     decorationPersoIHM();

     //Information personnage (nom taille et sexe)

     deplacerCurseurXY(15,8);write('Nom (entre 1 et 15 caractères) :');

     deplacerCurseurXY(15,16);write('Taille :');


     deplacerCurseurXY(15,24);write('Sexe (''M'' ou ''F'') : ');

          //-------Réponses aux questions-------
     deplacerCurseurXY(48,8); readln(nom);
     // Tant que la taille du nom ne convient pas
     while (length(nom) < 1) or (length(nom) > 15) do
     begin
       tailleNomInvalideIHM();
       effacerEcran();
       decorationPersoIHM();
       deplacerCurseurXY(15,8);write('Nom (entre 1 et 15 caractères) :');
       deplacerCurseurXY(15,16);write('Taille :', taille);

       deplacerCurseurXY(15,24);write('Sexe (''M'' ou ''F''): ');
       deplacerCurseurXY(48,8);
       readln(nom);
     end;

     deplacerCurseurXY(23,16);write(' '); readln(taille);



     deplacerCurseurXY(33,24);write(' '); readln(sexe);
     // Tant que sexe est différent de M ou F
     while (sexe <> 'M') and (sexe <> 'F') do
     begin
       effacerEcran();
       decorationPersoIHM();
       deplacerCurseurXY(15,8);write('Nom (entre 1 et 15 caractères) :', nom);
       deplacerCurseurXY(15,16);write('Taille :', taille);

       deplacerCurseurXY(15,24);write('Sexe (''M'' ou ''F''): ');
       deplacerCurseurXY(33,24);
       readln(sexe);
     end;

end;

end.

