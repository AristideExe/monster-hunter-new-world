unit monsterHunterCombat;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils, monsterHunterCombatIHM, monsterHunterVille, monsterHunterGestionCombatMonstre;

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
  if (choix = '1') then
  begin
    initialisationCombatMonstre(1);
    Difficulte1IHM()         //Difficulté1
    interfaceCombatIHM()
  end

  else if (choix = '2') then
  begin
    initialisationCombatMonstre(2);
    Difficulte2IHM()    //Difficulté2
  end

  else if (choix = '3') then
  begin
    initialisationCombatMonstre(3);
    Difficulte3IHM()    //Difficulté3
  end


  else if (choix = '4') then
  begin
    initialisationCombatMonstre(4);
    Difficulte4IHM()    //Difficulté4
  end

  else if (choix = '0') then ville()             //Renvoie dans la ville
  else choisirCombat();

end;

// ------------------------------------------ COMBAT ------------------------------------------


end.
