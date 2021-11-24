unit monsterHunterCombatIHM;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface

uses
  Classes, SysUtils, GestionEcran, monsterHunterJoueur;

//Choix de la difficulté de l'éxpédition
function menuChoixCombatIHM() : string;

//Interface de combat Difficulté 5
function Difficulte5IHM() : string;

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
     deplacerCurseurXY(51,10);write ('1. Difficulté * ');

     //Difficulté 2*
     deplacerCurseurXY(51,12);write ('2. Difficulté * * ');

     //Difficulté 3*
     deplacerCurseurXY(51,14);write ('3. Difficulté * * * ');

     //Difficulté 4*
     deplacerCurseurXY(51,16);write ('4. Difficulté * * * * ');

     //Difficulté 5*
     deplacerCurseurXY(51,18);write ('5. Difficulté * * * * * ');

     //Entrée du choix
     deplacerCurseurXY(39,24);write ('Votre choix : ');
     readln(menuChoixCombatIHM);
end;

//-------------------------------------------------Difficulté 5-------------------------------------------------

//Fond d'ambiance Volcanique
procedure VolcaniqueIHM();
begin
     effacerEcran();


     couleurTexte(7);//Gris clair
     dessiner('dessins/Difficulte5/fumee.txt',3,0);  //Fumee du volcan

     couleurTexte(4);//Rouge
     dessiner('dessins/Difficulte5/meteorite2.txt',83,0);  //Flammes rouges de la météorite
     dessiner('dessins/Difficulte5/lave.txt',3,5);  //Lave du volcan


     couleurTexte(14);//Jaune
     dessinerSansEspace('dessins/Difficulte5/meteorite3.txt',83,0);  //Flammes jaunes

     couleurTexte(6);//Marron
     dessiner('dessins/Difficulte5/meteorite1.txt',83,0);  //Météorite
     //dessinerSansEspace('dessins/Difficulte5/montagne.txt',3,5);     //Montagne

     couleurTexte(15);
end;

//Interface de combat Difficulté 5
function Difficulte5IHM() : string;
begin
     VolcaniqueIHM();                 //Apelle la procédure d'ambiance volcanique
     readln;
     readln(Difficulte5IHM);
end;

//-------------------------------------------------Difficulté 4-------------------------------------------------
//Interface de combat Difficulté 4
function Difficulte4IHM() : string;
begin

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

