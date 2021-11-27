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

  // ------------------------------------------ FONCTIONS ET PROCEDURES --------------------------------------

  //Initialisation du monstre pour le combat
  procedure initialisationCombatMonstre (difficulte : integer);

  //Procédure qui renvoie le monstre généré
  function getMonstreCombat():typeMonstre;

// =========================================================================== IMPLEMENTATION ===================================================================================
implementation

//Fonction qui renvoie le monstre généré
function getMonstreCombat():typeMonstre;
begin
  getMonstreCombat := monstreCombat;
end;

//Génère un monstre en fonction de la difficulté choisie
procedure generationMonstre(difficulte : integer);
begin
  //Nécéssaire pour un random réeussi
  Randomize;

  if difficulte = 1 then monstreCombat := getMonstres()[random(2)]
  else if difficulte = 2 then monstreCombat := getMonstres()[random(2) + 2]
  else if difficulte = 3 then monstreCombat := getMonstres()[random(2) + 4]
  else if difficulte = 4 then monstreCombat := getMonstres()[random(1) + 7]; //2 + 6
  write(getMonstres()[random(2)].nom);

end;

//Initialisation du monstre pour le combat
procedure initialisationCombatMonstre(difficulte : integer);
begin
  generationMonstre(difficulte);
end;

end.

