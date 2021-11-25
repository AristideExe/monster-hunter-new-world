unit monsterHunterChambre;

{$mode objfpc}{$H+}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils, monsterHunterIHM, monsterHunterArmesEtArmures, monsterHunterChambreIHM;

procedure chambre();



// =========================================================================== IMPLEMENTATION ===================================================================================
implementation
uses monsterHunterVille, monsterHunterJoueur;

// ----------------------------------------------------- CHAMBRE ------------------------------------------------------
// Procédure qui affiche tous les objets de l'inventaire et qui permet de retourner à la ville ou d'aller au menu de changement d'armure
procedure chambre();
var
  i : integer;
  choix : string;
begin
  chambreIHM();
  // On affiche les armures si le joueur possède l'armure
  for i:=0 to 4 do afficherArmureChambre(getJoueur.armurePortee[i],i);
  readln;
end;

end.

