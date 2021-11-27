unit monsterHunterGestionCombatMonstre;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface

uses
  Classes, SysUtils, monsterHunterJoueur, monsterHunterMonstre;

  // ------------------------------------------------- Types ---------------------------------------------


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
  function getMonstreCombatPV():integer;

// =========================================================================== IMPLEMENTATION ===================================================================================
implementation

//Fonction qui renvoie le monstre généré
function getMonstreCombat():typeMonstre;
begin
  getMonstreCombat := monstreCombat;
end;

//Fonction qui donne les pv max du monstre
function getMonstreCombatPV():integer;
begin
    getMonstreCombatPV := pvMaxMonstre;
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

//Initialisation du monstre pour le combat
procedure initialisationCombatMonstre(difficulte : integer);
begin
  generationMonstre(difficulte);
end;

end.

