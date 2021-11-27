unit monsterHunterCombat;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils, monsterHunterCombatIHM, monsterHunterVille;

procedure choisirCombat();




// =========================================================================== IMPLEMENTATION ===================================================================================
implementation

// ------------------------------------------ CHOISIR COMBAT ---------------------------------------------

//Permet de choisir la difficulté
procedure choisirCombat();
var
  choix: string;

begin
  choix := menuChoixCombatIHM();
  if (choix = '1') then Difficulte1IHM()         //Difficulté1
  else if (choix = '2') then Difficulte2IHM()    //Difficulté2
  else if (choix = '3') then Difficulte3IHM()    //Difficulté3
  else if (choix = '4') then Difficulte4IHM()    //Difficulté4
  else if (choix = '0') then ville()             //Renvoie dans la ville
  else choisirCombat();

end;

// ------------------------------------------ COMBAT ------------------------------------------


end.
