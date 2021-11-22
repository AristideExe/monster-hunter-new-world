unit monsterHunterVille;

{$mode objfpc}{$H+}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils, monsterHunterIHM, monsterHunterMarchand, monsterHunterCantine, monsterHunterCombat, monsterHunterForge, monsterHunterChambre;
// Ville
procedure ville();



// =========================================================================== IMPLEMENTATION ===================================================================================
implementation



// ------------------------------------------------- VILLE -----------------------------------------------
procedure ville();
var
  choix: string;
begin
  choix := villeIHM();
  if (choix = '1') then
    chambre()
  else if (choix = '2') then
    choixItemForge()
  else if (choix = '3') then
    marchand()
  else if (choix = '4') then
    cantine()
  else if (choix = '5') then
    choisirCombat()
  else
    ville();
end;

end.

