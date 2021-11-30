unit monsterHunterCombatIHM;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface

uses
  Classes, SysUtils, GestionEcran, monsterHunterJoueur, monsterHunterMonstre, monsterHunterGestionCombatMonstre;

// ------------------------------------------ FONCTIONS ET PROCEDURES --------------------------------------

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

//Procedure créant le cadre pour les options de combats
procedure cadreCombatIHM(mot: string);

//procedure qui affiche les loots du monstre vaincu
procedure lootMonstreMortIHM (quantite:typeLootMonstre);

// =========================================================================== IMPLEMENTATION ===================================================================================
implementation
uses monsterHunterCombat,  monsterHunterGestionCombatJoueur;

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

//Procédure qui affiche les stats du monstre
procedure afficherStatsMonstreIHM();
var
  couleurVie : Byte;
  ratioPV : Real;

begin
     ratioPV:= monstreCombat.vie  / getMonstreCombatPVMax();                   //On initialise la ratio PV courants/pv Max

     //On change la couleur de la barre de vie en fonction des pv restants
     if ratioPV >= 0.75 then couleurVie:= Green               //Couleur vert
     else if ratioPV >= 0.5 then couleurVie := LightGreen     //Couleur vert clair
     else if ratioPV >= 0.25 then couleurVie:= Yellow         //Couleur Jaune
     else if ratioPV >= 0 then couleurVie:= red;              //Couleur rouge

     //Indicateurs d'une barre de vie pleine
     couleurTexte(DarkGray);
     deplacerCurseurXY(71,26); write('▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒');
     deplacerCurseurXY(71,27); write('▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒');

     //On regarde le ratio de pv pour gérer les 2 barres de vie
     if (ratioPV <= 0.5) and (ratioPV > 0) then
     begin
        dessinerCadreXY(71,26,round(71+40*(ratioPV)*2),26,simple,couleurVie,couleurVie);                //Première partie de la barre de vie du monstre
     end

     else if (ratioPV > 0.5) then
     begin
        dessinerCadreXY(71,26,111,26,simple,couleurVie,couleurVie);                     //Première partie de la barre de vie du monstre
        dessinerCadreXY(71,27,round(71+40*(ratioPV-0.5)*2),27,simple,couleurVie,couleurVie);                //Deuxième partie de sa vie
     end;

     couleurTexte(White);         //On réinitialise les paramètres de couleur
     couleurFond(Black);          //On réinitialise les paramètres de couleur

     deplacerCurseurXY(115,26);                                       //115,26
     write('hp : ',monstreCombat.vie,' / ',getMonstreCombatPVMax());

end;

//Procédure qui affiche les stats du Joueur
procedure afficherStatsJoueurIHM();
var
  couleurVie : Byte;
  ratioPV : Real;
  pvMax : integer;

begin
     if round(getJoueur().vie) > 100 then pvMax := 150
     else pvMax:=100;

     ratioPV:= round(getJoueur().vie)  / pvMax;                      //On initialise la ratio PV courants/pv Max

     //On change la couleur de la barre de vie en fonction des pv restants
     if ratioPV > 1 then couleurVie:= Blue                    //couleur bleu (si le joueur a un buff pv)
     else if ratioPV >= 0.75 then couleurVie:= Green          //Couleur vert
     else if ratioPV >= 0.5 then couleurVie := LightGreen     //Couleur vert clair
     else if ratioPV >= 0.25 then couleurVie:= Yellow         //Couleur Jaune
     else if ratioPV >= 0 then couleurVie:= red;              //Couleur rouge

     //Indicateurs d'une barre de vie pleine
     couleurTexte(DarkGray);
     deplacerCurseurXY(71,35); write('▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒');

     //On regarde le ratio de pv pour gérer la barre de vie
     if (ratioPV > 0) and (ratioPV <= 1) then dessinerCadreXY(71,35,round(71+40*(ratioPV)),35,simple,couleurVie,couleurVie)      //Barre de vie du Joeur
     else if ratioPV > 1 then dessinerCadreXY(71,35,round(71+40*(ratioPV)),35,simple,couleurVie,couleurVie);                       //Barre de vie du Joeur si il possède un buff d pv

     couleurTexte(White);         //On réinitialise les paramètres de couleur
     couleurFond(Black);          //On réinitialise les paramètres de couleur

     deplacerCurseurXY(115,35);                                       //115,26
     write('hp : ',round(getJoueur().vie),' / ',pvMax);

end;

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
     afficherStatsMonstreIHM();

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
     afficherStatsJoueurIHM();
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
     infoMonstreIHM(getMonstreCombat().nom);
     infoJoueurIHM(getJoueur().nom);
     versusIHM();
     cadreChoixActionsIHM();
     readln(interfaceCombatIHM);
end;

//Procedure qui dessine le monstre en question
procedure spawnMonstreIHM();
begin
     //récipère le nom du monstre et récupère le dessin en fonction.
     dessinCouleurSansEspaces('dessins/Monstres/' + getMonstreCombat().nom + '.txt',45,5);
end;

//-------------------------------------------------Difficulté 4-------------------------------------------------

//Fond d'ambiance de la difficulté 4
procedure decor4IHM();
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

     spawnMonstreIHM();
end;

//Interface de combat Difficulté 4
function Difficulte4IHM() : string;
begin
     decor4IHM();                                   //Apelle la procédure d'ambiance volcanique
     Difficulte4IHM := interfaceCombatIHM();        //On affiche l'interface de combat (Et on lis l'entrée utilisateur)
end;


//-------------------------------------------------Difficulté 3-------------------------------------------------

//Fond d'ambiance de la difficulté 3
procedure decor3IHM();
begin
     effacerEcran();
     changerTailleConsole(140,41);

     //Ton décor

     spawnMonstreIHM();
end;

//Interface de combat Difficulté 3
function Difficulte3IHM() : string;
begin
     decor3IHM();
     Difficulte3IHM := interfaceCombatIHM();        //On affiche l'interface de combat (Et on lis l'entrée utilisateur)
end;

//-------------------------------------------------Difficulté 2-------------------------------------------------

//Fond d'ambiance de la difficulté 2
procedure decor2IHM();
begin
     effacerEcran();
     changerTailleConsole(140,41);

     //Ton décor

     spawnMonstreIHM();
end;

//Interface de combat Difficulté 2
function Difficulte2IHM() : string;
begin
     decor2IHM();
     Difficulte2IHM := interfaceCombatIHM();        //On affiche l'interface de combat (Et on lis l'entrée utilisateur)

end;

//-------------------------------------------------Difficulté 1-------------------------------------------------

//Fond d'ambiance de la difficulté 1
procedure decor1IHM();
begin
     effacerEcran();
     changerTailleConsole(140,41);

     //Ton décor

     spawnMonstreIHM();
end;

//Interface de combat Difficulté 1
function Difficulte1IHM() : string;
begin
     decor1IHM();
     Difficulte1IHM := interfaceCombatIHM();        //On affiche l'interface de combat (Et on lis l'entrée utilisateur)

end;

//-------------------------------------------------Autre-------------------------------------------------

//procedure qui affiche les loots du monstre vaincu
procedure lootMonstreMortIHM (quantite : typeLootMonstre);
begin
     //On affiche le loot drop par le monstre
     cadreCombatIHM('Loot');
     deplacerCurseurXY(70-(length('Bravo, vous venez de vaincre un(e) ' + getMonstreCombat.nom + ' !') div 2),24);
     write('Bravo, vous venez de vaincre un(e) ' + getMonstreCombat.nom + ' !');
     deplacerCurseurXY(70-(length('En dépeçant le monstre vous avez obtenu :') div 2),25);
     write('En dépeçant le monstre vous avez obtenu :');

     //Affichage des loots
     deplacerCurseurXY(70-(length(IntToStr(quantite[0]) + ' ' + getMonstreCombat.loot[0].nomLoot) div 2),27);
     write(IntToStr(quantite[0]) + ' ' + getMonstreCombat.loot[0].nomLoot);
     deplacerCurseurXY(70-(length(IntToStr(quantite[1]) + ' ' + getMonstreCombat.loot[1].nomLoot) div 2),28);
     write(IntToStr(quantite[1]) + ' ' + getMonstreCombat.loot[1].nomLoot);
     deplacerCurseurXY(70-(length(IntToStr(quantite[2]) + ' ' + getMonstreCombat.loot[2].nomLoot) div 2),29);
     write(IntToStr(quantite[2]) + ' ' + getMonstreCombat.loot[2].nomLoot);

     //Indiaction avant de retourner en ville
     deplacerCurseurXY(70-(length('Appyez sur entree pour retourner en ville') div 2),34);
     Write('Appuyez sur entree pour retourner en ville');

     //On attends qu'il appuie sur entree
     readln;

     //On change la taille de la fenêtre et on retourne en ville
     changerTailleConsole(120,30);


end;

end.
