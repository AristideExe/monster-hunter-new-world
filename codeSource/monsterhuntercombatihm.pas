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

     //Décoration dragonets du menu de choix
     couleurTexte(Red);
     dessiner('dessins/dragonetGauche.txt',12,12); //Dragonet gauche

     dessiner('dessins/dragonetDroite.txt',84,12); //Dragonet droite
     couleurTexte(White);

     //Entrée du choix
     deplacerCurseurXY(39,24);write ('Votre choix : ');

     readln(menuChoixCombatIHM);
end;

//-------------------------------------------------Interface combat-------------------------------------------------
//Procedure créant le cadre pour les options de combats
procedure cadreCombatIHM(mot: string);
begin
     dessinerCadreXY(2,20,138,40,double,White,Black);
     dessinerCadreXY(104,19,119,21,simple,White,Black);
     couleurTexte(15);//Blanc
     deplacerCurseurXY(112-(length(mot)div 2),20);
     write(mot);
end;

//Procedure créant le cadre pour les actions du joueur
procedure actionCombatIHM(mot: string);
begin
//Affichage cadre Actions
     dessinerCadreXY(4,23,36,38,simple,Brown,Black);
     dessinerCadreXY(8,22,20,24,simple,Brown,Black);
     couleurTexte(15);//Blanc
     deplacerCurseurXY(14-(length(mot)div 2),23);
     write(mot);

//Affichage bouton Attaquer
     dessinerCadreXY(6,26,34,28,simple,Brown,Black);
     couleurTexte(15);//Blanc
     deplacerCurseurXY(20-(length('1. ATTAQUER')div 2),27);
     write('1. ATTAQUER');

//Affichage bouton Inventaire
     dessinerCadreXY(6,30,34,32,simple,Brown,Black);
     couleurTexte(15);//Blanc
     deplacerCurseurXY(20-(length('2. INVENTAIRE')div 2),31);
     write('2. INVENTAIRE');

//Affichage bouton fuir
     dessinerCadreXY(6,34,34,36,simple,Brown,Black);
     couleurTexte(15);//Blanc
     deplacerCurseurXY(20-(length('3. FUIR')div 2),35);
     write('3. FUIR');
end;

//Procedure créant le cadre pour les infos du monstre
procedure infoMonstreIHM(nom: string);
begin
//Affichage cadre pour les infos du monstre
     dessinerCadreXY(65,23,136,30,simple,LightMagenta,Black);
     dessinerCadreXY(76,22,92,24,simple,LightMagenta,Black);
     couleurTexte(15);//Blanc
     deplacerCurseurXY(84-(length(nom)div 2),23); //(A modifier)
     write(nom);//(A modifier)

end;

//Procedure créant le cadre pour les infos du joueur
procedure infoJoueurIHM(nom: string);
begin
//Affichage cadre pour les infos du joueur
     dessinerCadreXY(65,32,136,39,simple,LightCyan,Black);
     dessinerCadreXY(76,31,92,33,simple,LightCyan,Black);
     couleurTexte(15);//Blanc
     deplacerCurseurXY(84-(length(nom)div 2),32);
     write(nom);
end;

//Affichage du Versus
procedure versusIHM();
begin
     couleurTexte(4); //Rouge
     dessiner('dessins/versus.txt',43,24);//Versus
     couleurTexte(15);//Blanc
end;

//Affichage cadre du choix
procedure cadreChoixActionsIHM();
begin
     dessinerCadreXY(40,37,61,39,simple,White,Black);
     deplacerCurseurXY(50-(length('Choix: ')div 2),38);
     write('Choix: ');
end;


//Fonction de l'interface de combat
function interfaceCombatIHM(): string;
begin
     cadreCombatIHM('COMBAT');
     actionCombatIHM('ACTIONS');
     infoMonstreIHM('Monstre');//A modifier
     infoJoueurIHM(getJoueur().nom);//A modifier
     versusIHM();
     cadreChoixActionsIHM();
     readln(interfaceCombatIHM);
end;

//-------------------------------------------------Difficulté 4-------------------------------------------------

//Fond d'ambiance Volcanique
procedure VolcaniqueIHM();
begin
     effacerEcran();
     changerTailleConsole(140,41);

     couleurTexte(6);//Marron
     dessiner('dessins/Difficulte4/sol.txt',40,15);//Sol

     couleurTexte(7);//Gris clair
     dessiner('dessins/Difficulte4/fumee.txt',9,0);  //Fumee du volcan

     couleurTexte(4);//Rouge
     dessiner('dessins/Difficulte4/meteorite2.txt',103,0);  //Flammes rouges de la météorite
     dessiner('dessins/Difficulte4/lave.txt',3,7);  //Lave du volcan


     couleurTexte(14);//Jaune
     dessinerSansEspace('dessins/Difficulte4/meteorite3.txt',103,0);  //Flammes jaunes

     couleurTexte(6);//Marron
     dessiner('dessins/Difficulte4/meteorite1.txt',103,0);  //Météorite
     dessinerSansEspace('dessins/Difficulte4/montagne.txt',3,7);     //Montagne

     couleurTexte(15);//Blanc

     //A CHANGER (TEST)
     dessinerSansEspace('dessins/Monstres/Stégausorus.txt',45,4);
     interfaceCombatIHM();
end;

//Interface de combat Difficulté 4
function Difficulte4IHM() : string;
begin
     VolcaniqueIHM();                 //Apelle la procédure d'ambiance volcanique
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

