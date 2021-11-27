unit monsterHunterMarchand;

{$mode objfpc}{$H+}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils, monsterHunterMarchandIHM;

procedure marchand();




// =========================================================================== IMPLEMENTATION ===================================================================================
implementation
uses monsterHunterVille;

// ------------------------------------------------- MARCHAND -----------------------------------------------
procedure marchand();
var
  choix : string;
begin
  choix := marchandIHM();
  if choix = '0' then ville();
  else marchand;
end;

end.

