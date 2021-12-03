unit monsterHunterCantineIHM;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface

uses
  Classes, SysUtils,GestionEcran,monsterHunterCantine;

// Affiche le contour de la cantine
procedure cantineIHM();
// Affiche l'entête des colonnes pour la cantine
procedure enteteCantineIHM();
// Afficher une nourriture en particulier
procedure afficherNourritureCantineIHM(nourriture : typeNourriture ; numeroNourriture : integer);


// =========================================================================== IMPLEMENTATION ===================================================================================
implementation

// Afficher une nourriture en particulier
procedure afficherNourritureCantineIHM(nourriture : typeNourriture ; numeroNourriture : integer);
begin
  // Affichage du numéro
  deplacerCurseurXY(15,numeroNourriture+7);
  write(numeroNourriture);
  // Affichage du nom
  deplacerCurseurXY(30,numeroNourriture+7);
  write(nourriture.nom);
  // Affichage du prix
  deplacerCurseurXY(62,numeroNourriture +7); write(nourriture.prixAchat);
  // Affichage du bonus de vie
  deplacerCurseurXY(78,numeroNourriture +7); write(nourriture.bonusVie);
  // Affichage de l'élément de l'arme
  deplacerCurseurXY(100,numeroNourriture +7); write(nourriture.bonusVitesse);



  deplacerCurseurXY(100, 28);
end;

// Affiche l'entête des colonnes pour la cantine
procedure enteteCantineIHM();
begin
  // Entête du numéro
  deplacerCurseurXY(13,6);write('Numéro');
  // Entête du nom
  deplacerCurseurXY(30,6); write('Nom');
  // Entête du prix
  deplacerCurseurXY(62,6); write('Prix');
  // Entête de bonus de vie
  deplacerCurseurXY(78,6); write('Bonus de vie');
  // Entête de bonus de vitesse
  deplacerCurseurXY(95,6); write('Bonus de vitesse');

  deplacerCurseurXY(100, 28);
end;



// Affiche le contour de la cantine
procedure cantineIHM();
begin
  effacerEcran();
  CadrePrincipal('Cantine : sélectionnez un numéro pour manger');
  deplacerCurseurXY(10,28); write(' 0/ Retourner au menu de sélection de la forge ');
  deplacerCurseurXY(85,28); write(' Votre choix :   ');
end;

end.

