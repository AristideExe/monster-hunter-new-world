unit monsterHunterChambreIHM;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface

uses
  Classes, SysUtils, GestionEcran, monsterHunterJoueur, monsterHunterArmesEtArmures;

// IHM de la chambre
procedure chambreIHM();
// Affiche une seule armure dans la chambre
procedure afficherArmureChambre(armure : typeArmure; ligne : integer);

// =========================================================================== IMPLEMENTATION ===================================================================================
implementation

// IHM de la chambre
procedure chambreIHM();
begin
  effacerEcran();
  //deplacerCurseurXY()
end;

// Affiche une seule armure dans la chambre
procedure afficherArmureChambre(armure : typeArmure; ligne : integer);
begin
  if armure.nom <> 'NULL' then
  begin
  deplacerCurseurXY(ligne*5 + 5, 10); write(armure.nom);
  end
  else
  deplacerCurseurXY(10,ligne*5 + 5); write('Vous ne possédez pas de ', armure.pieceArmure);

end;



end.

