unit monsterHunterForgeIHM;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils, GestionEcran;

function choixItemForgeIHM() : string;
// Affiche l'interface de la forge en général
function forgeIHM() : string;



// =========================================================================== IMPLEMENTATION ===================================================================================
implementation

// Affiche l'interface de la forge en général
function forgeIHM() : string;
begin
  effacerEcran();
  deplacerCurseurXY(10,1); write('Forge');
  deplacerCurseurXY(10,28); write('0/ Retourner au menu de sélection de la forge');
  deplacerCurseurXY(10,29); write('Votre choix : ');
end;

function choixItemForgeIHM() : string;
begin
  effacerEcran();
  deplacerCurseurXY(20,1); write('Forge : choix de l''objet à afficher');
  deplacerCurseurXY(50,10); write('1/ Afficher les armes');
  deplacerCurseurXY(50,11); write('2/ Afficher les casques');
  deplacerCurseurXY(50,12); write('3/ Afficher les plastrons');
  deplacerCurseurXY(50,13); write('4/ Afficher les jambières');
  deplacerCurseurXY(50,14); write('5/ Afficher les bottes');
  deplacerCurseurXY(50,15); write('6/ Afficher les gants');
  deplacerCurseurXY(20,28); write('O/ Retourner à la ville');
  deplacerCurseurXY(20,29); write('Votre choix : ');
  readln(choixItemForgeIHM);
end;

end.

