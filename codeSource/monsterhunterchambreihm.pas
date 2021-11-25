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
procedure afficherArmureChambreIHM(armure : typeArmure; ligne : integer);
// Affiche l'arme portée dans la chambre
procedure afficherArmeChambreIHM(arme : typeArme);
// Affichage d'une seule arme dans la malle
procedure afficherArmeIHM(arme : typeArme; numeroArme : integer; derniereLigne : boolean);
// IHM de la malle des armes
procedure malleIHM();

// =========================================================================== IMPLEMENTATION ===================================================================================
implementation

// ----------------------------------------------------- MALLE ------------------------------------------------------
// IHM de la malle des armes
procedure malleIHM();
begin
  effacerEcran();
  deplacerCurseurXY(5,1); write('Malle à armes : sélectionnez un numéro pour porter l''arme');
  deplacerCurseurXY(5,28); write('0/ Retourner à la chambre');
  deplacerCurseurXY(5,29); write('Votre choix : ');
end;

// Affichage d'une seule arme dans la malle
procedure afficherArmeIHM(arme : typeArme; numeroArme : integer; derniereLigne : boolean);
begin
  deplacerCurseurXY(10,numeroArme +5);write(numeroArme, ' : ',arme.nom);
  if derniereLigne then deplacerCurseurXY(18,29);
end;

// ----------------------------------------------------- CHAMBRE ------------------------------------------------------
// IHM de la chambre
procedure chambreIHM();
begin
  effacerEcran();
  deplacerCurseurXY(5,1); write('Chambre');
  deplacerCurseurXY(5,28); write('0/ Retourner à la ville       1/ Ouvrir la malle à armes       2/ Ouvrir l''armoire à armures');
  deplacerCurseurXY(5,29); write('Votre choix : ');
end;


// Affiche l'arme portée dans la chambre
procedure afficherArmeChambreIHM(arme : typeArme);
begin
  deplacerCurseurXY(80,15); write(arme.nom);
  deplacerCurseurXY(19,29);
end;

// Affiche une seule armure dans la chambre
procedure afficherArmureChambreIHM(armure : typeArmure; ligne : integer);
begin
  // Si l'armure du joueur n'est pas nulle
  if armure.nom <> 'NULL' then
  begin
       deplacerCurseurXY(10,ligne*5 + 4);write(upCase(toStringPieceArmure(armure.pieceArmure)), ' : ',armure.nom);
       deplacerCurseurXY(10,ligne*5 + 5);write('Valeur de défense : ',armure.valeurDefense:6:2);
       deplacerCurseurXY(10,ligne*5 + 6);write('Taux d''esquive : ',armure.tauxEsquive:6:2);
  end
  else
  begin
    deplacerCurseurXY(10,ligne*5 + 5);
    write('Vous ne portez pas de ', toStringPieceArmure(armure.pieceArmure));
  end;

end;



end.

