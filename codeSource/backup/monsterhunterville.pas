unit monsterHunterVille;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils, monsterHunterIHM, monsterHunterMarchand, monsterHunterCantine, monsterHunterForge, monsterHunterChambre;
// Ville
procedure ville();



// =========================================================================== IMPLEMENTATION ===================================================================================
implementation
uses monsterHunterCombat, monsterHunterMenu;


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
  else if (choix = '6') then
    menu()
  else
    ville();
end;

end.

