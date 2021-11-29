unit monsterHunterGestionCombatJoueur;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface

uses
  Classes, SysUtils, monsterHunterJoueur, monsterHunterMonstre, monsterHunterCombatIHM, monsterHunterGestionCombatMonstre, monsterHunterArmesEtArmures;

  // ------------------------------------------------- Types ---------------------------------------------


  // ------------------------------------------------- VARIABLES ---------------------------------------------


  // ------------------------------------------ FONCTIONS ET PROCEDURES --------------------------------------

   //Fonction qui gère la précision en fonction de l'arme
   function precisionArme(esquive:integer):integer;

// =========================================================================== IMPLEMENTATION ===================================================================================

implementation

//Fonction qui gère la précision en fonction de l'arme
function precisionArme(esquive:integer):integer;
begin
  case getJoueur.armePortee.arme of
  epee : precisionArme := round(esquive * 0.1);
  hache : precisionArme := round(esquive * 0.05);
  marteau : precisionArme := round(esquive * 0);
  couteau : precisionArme := round(esquive * 0.2);
  end;

end;

end.

