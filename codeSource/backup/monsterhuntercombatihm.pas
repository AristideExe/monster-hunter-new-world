unit monsterHunterCombatIHM;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface

uses
  Classes, SysUtils, GestionEcran, monsterHunterJoueur, monsterHunterMonstre, monsterHunterGestionCombatMonstre, monsterHunterGestionCombatJoueur;

//Choix de la difficulté de l'éxpédition
function menuChoixCombatIHM() : string;

//Interface de combat Difficulté 4
function Difficulte4IHM() : string;

//Interface de combat Difficulté 3
function Difficulte3IHM() : string;

//Interface de combat Difficulté 2
function Difficulte2IHM() : string;

//Interface de combat Difficulté 1
function Difficulte1IHM() : string;

// =========================================================================== IMPLEMENTATION ===================================================================================
implementation
uses monsterHunterCombat;

//Choix de la difficulté de l'éxpédition
function menuChoixCombatIHM() : string;
begin
     effacerEcran();
     deplacerCurseurXY(40,5);write ('Choisissez votre niveau de difficulté ! ');

     //Difficulté 1*
     deplacerCurseurXY(50,10);write ('1. Difficulté * ');

     //Difficulté 2*
     deplacerCurseurXY(50,12);write ('2. Difficulté * * ');

     //Difficulté 3*
     deplacerCurseurXY(50,14);write ('3. Difficulté * * * ');

     //Difficulté 4*
     deplacerCurseurXY(50,16);write ('4. Difficulté * * * * ');

     //Retour en ville
     deplacerCurseurXY(50,19);write ('0. Retour en ville');

     //Entrée du choix
     deplacerCurseurXY(39,24);write ('Votre choix : ');

     //Décoration dragonets du menu de choix
     couleurTexte(4);
     dessiner('dessins/dragonetGauche.txt',12,12); //Dragonet gauche

     dessiner('dessins/dragonetDroite.txt',84,12); //Dragonet droite
     couleurTexte(White);

     readln(menuChoixCombatIHM);
end;

//-------------------------------------------------Difficulté 4-------------------------------------------------

//Fond d'ambiance Volcanique
procedure VolcaniqueIHM();
begin
     effacerEcran();
     changerTailleConsole(140,35);


     couleurTexte(7);//Gris clair
     dessiner('dessins/Difficulte4/fumee.txt',3,0);  //Fumee du volcan

     couleurTexte(4);//Rouge
     dessiner('dessins/Difficulte4/meteorite2.txt',103,0);  //Flammes rouges de la météorite
     dessiner('dessins/Difficulte4/lave.txt',3,5);  //Lave du volcan


     couleurTexte(14);//Jaune
     dessinerSansEspace('dessins/Difficulte4/meteorite3.txt',103,0);  //Flammes jaunes

     couleurTexte(6);//Marron
     dessiner('dessins/Difficulte4/meteorite1.txt',103,0);  //Météorite
     dessinerSansEspace('dessins/Difficulte4/montagne.txt',3,5);     //Montagne

     couleurTexte(15);
end;

//Interface de combat Difficulté 4
function Difficulte4IHM() : string;
begin
     VolcaniqueIHM();                 //Apelle la procédure d'ambiance volcanique
     readln;
     readln(Difficulte4IHM);

end;


//-------------------------------------------------Difficulté 3-------------------------------------------------
//Interface de combat Difficulté 3
function Difficulte3IHM() : string;
begin

end;

//-------------------------------------------------Difficulté 2-------------------------------------------------
//Interface de combat Difficulté 2
function Difficulte2IHM() : string;
begin

end;

//-------------------------------------------------Difficulté 1-------------------------------------------------
//Interface de combat Difficulté 1
function Difficulte1IHM() : string;
begin

end;

end.

