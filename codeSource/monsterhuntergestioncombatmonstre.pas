unit monsterHunterGestionCombatMonstre;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface

uses
  Classes, SysUtils, monsterHunterJoueur, monsterHunterMonstre, monsterHunterVille;

  // ------------------------------------------------- Types ---------------------------------------------
  type
    typeLootMonstre = array [0..3] of integer;


  // ------------------------------------------------- VARIABLES ---------------------------------------------
  var
     monstreCombat : typeMonstre;
     pvMaxMonstre : integer;
  // ------------------------------------------ FONCTIONS ET PROCEDURES --------------------------------------

  //Initialisation du monstre pour le combat
  procedure initialisationCombatMonstre (difficulte : integer);

  //Procédure qui renvoie le monstre généré
  function getMonstreCombat():typeMonstre;

  //Fonction qui donne les pv max du monstre
  function getMonstreCombatPVMax():integer;

  //Procédure qui met des dégats au monstre
  procedure degatsCombatMonstre(degats : integer);

// =========================================================================== IMPLEMENTATION ===================================================================================
implementation

uses
  monsterHunterGestionCombatJoueur, monsterHunterCombatIHM;

//Fonction qui renvoie le monstre généré
function getMonstreCombat():typeMonstre;
begin
  getMonstreCombat := monstreCombat;
end;

//Fonction qui donne les pv max du monstre
function getMonstreCombatPVMax():integer;
begin
    getMonstreCombatPVMax := pvMaxMonstre;
end;

//Génère un monstre en fonction de la difficulté choisie
procedure generationMonstre(difficulte : integer);
var
   numMonstre : integer;
begin
  //Nécéssaire pour un random réeussi
  Randomize;

  if difficulte = 1 then numMonstre := random(2)           //choisis aléatoirement parmis les monstres du lvl 1
  else if difficulte = 2 then numMonstre := random(2) + 2  //choisis aléatoirement parmis les monstres du lvl 2
  else if difficulte = 3 then numMonstre := random(2) + 4  //choisis aléatoirement parmis les monstres du lvl 3
  else if difficulte = 4 then numMonstre := random(2) + 6; //choisis aléatoirement parmis les monstres du lvl 4

  monstreCombat := getMonstres()[numMonstre];
  pvMaxMonstre:= getMonstres()[numMonstre].vie;
end;

//Procedure qui donne les loots une fois le monstre tué
function lootMortMonstre ():typeLootMonstre;
var
   quantiteLoot1 : integer;
   quantiteLoot2 : integer;
   quantiteLoot3 : integer;
   i : integer;
   numMonstre : integer;

begin
  Randomize;

  quantiteLoot1 := Random(getMonstreCombat.loot[0].quantiteMaximum) + getMonstreCombat.loot[0].quantiteMinimum;      //Donne un montant d'un item entre une quantité min et une quantité max
  quantiteLoot2 := Random(getMonstreCombat.loot[1].quantiteMaximum) + getMonstreCombat.loot[1].quantiteMinimum;      //Donne un montant d'un autre item entre une quantité min et une quantité max
  quantiteLoot3 := Random(getMonstreCombat.loot[2].quantiteMaximum) + getMonstreCombat.loot[2].quantiteMinimum;      //Donne un montant d'un autre item entre une quantité min et une quantité max

  //On récupère le numéro du monstre
  for i := 0 to length(monstres) do
      if getMonstreCombat.nom = monstres[i].nom then numMonstre:=i;

  //On donne le loot au joueur
  joueur.itemsPossedes[numMonstre + 2] := joueur.itemsPossedes[numMonstre + 2] + quantiteLoot1;             //Loot 1
  joueur.itemsPossedes[numMonstre + 2 + 8] := joueur.itemsPossedes[numMonstre + 2 + 8] + quantiteLoot2;     //Loot 2
  joueur.itemsPossedes[numMonstre + 2 + 16] := joueur.itemsPossedes[numMonstre + 2 + 16] + quantiteLoot3;     //Loot 3

  //On affiche le tout
  lootMortMonstre[0] := quantiteLoot1;
  lootMortMonstre[1] := quantiteLoot2;
  lootMortMonstre[2] := quantiteLoot3;

end;

//Procédure qui met des dégats au monstre
procedure degatsCombatMonstre(degats : integer);
begin
  Randomize;

  if (Random(100)+ 1) >= (getMonstreCombat.esquive - precisionArme(getMonstreCombat.esquive)) then
  begin
    if (getMonstreCombat.vie - degats) < 0 then
    begin
      monstreCombat.vie := 0; //On tue le monstre
      lootMonstreMortIHM(lootMortMonstre);

      //On retourne en ville
      ville();

    end

    else monstreCombat.vie:= getMonstreCombat.vie - degats;      //On inflige les dégats de l'arme au monstre

  end;

end;

//Initialisation du monstre pour le combat
procedure initialisationCombatMonstre(difficulte : integer);
begin
  generationMonstre(difficulte);
end;

end.

