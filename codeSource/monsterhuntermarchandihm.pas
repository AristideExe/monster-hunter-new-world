unit monsterHunterMarchandIHM;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils, GestionEcran, monsterHunterJoueur;

// Affiche l'interface du marchand
function marchandIHM() : string;

// =========================================================================== IMPLEMENTATION ===================================================================================
implementation

// Affiche l'interface du marchand
function marchandIHM() : string;
begin
  effacerEcran();
  cadrePrincipal('Marchand');

  // Affichage de l'argent
  deplacerCurseurXY(90, 5); write('Vous avez ', getJoueur.argent, ' de Simonnaie');

  // Affichage des options
  deplacerCurseurXY(48,8); write('1/ Acheter des objets');
  deplacerCurseurXY(84,8); write('2/ Acheter des composants');
  deplacerCurseurXY(47,15); write('3/ Acheter de la nourriture');
  deplacerCurseurXY(83,15); write('4/ Vendre des composants');

  deplacerCurseurXY(20,28); write(' O/ Retourner à la ville ');
  deplacerCurseurXY(85,28); write(' Votre choix :   ');
  deplacerCurseurXY(100,28);
  readln(marchandIHM);
end;

end.

