unit monsterHunterCantineIHM;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface

uses
  Classes, SysUtils,GestionEcran,monsterHunterCantine, monsterHunterJoueur;

// Affiche le contour de la cantine
procedure cantineIHM();
// Affiche l'entête des colonnes pour la cantine
procedure enteteCantineIHM();
// Afficher une nourriture en particulier
procedure afficherNourritureCantineIHM(nourriture : typeNourriture ; positionNourriture, numeroNourriture : integer);
procedure nePeutPasMangerIHM();
procedure mangerNourritureIHM(nourriture:typeNourriture);


// =========================================================================== IMPLEMENTATION ===================================================================================
implementation

procedure nePeutPasMangerIHM();
begin
  dessinerCadreXY(30,12,90,18,double,White,Black);
  deplacerCurseurXY(44,14);write('Vos bonus sont déjà au maximum');
  deplacerCurseurXY(42,16);write('Appuyez sur entrée pour continuer ');
  readln;
end;

procedure mangerNourritureIHM(nourriture:typeNourriture);
begin
  dessinerCadreXY(30,12,90,18,double,White,Black);
  deplacerCurseurXY(52 - (length(nourriture.nom) div 2),14);write('Vous avez mangé ', nourriture.nom);
  deplacerCurseurXY(43,16);write('Appuyez sur entrée pour continuer ');
  readln
end;


// Afficher une nourriture en particulier
procedure afficherNourritureCantineIHM(nourriture : typeNourriture ; positionNourriture, numeroNourriture : integer);
begin
  // Affichage du numéro
  deplacerCurseurXY(11,numeroNourriture+7);
  write(numeroNourriture);
  // Affichage du nom
  deplacerCurseurXY(23,numeroNourriture+7);
  write(nourriture.nom);
  // Affichage du prix
  deplacerCurseurXY(50,numeroNourriture +7); write(nourriture.prixAchat);
  // Affichage du bonus de vie
  deplacerCurseurXY(63,numeroNourriture +7); write(nourriture.bonusVie);
  // Affichage de l'élément de l'arme
  deplacerCurseurXY(77,numeroNourriture +7); write(nourriture.bonusVitesse);
  // Affichage de la quantité possédée
  deplacerCurseurXY(95,numeroNourriture +7); write(getJoueur.nourrituresPossedees[positionNourriture]);

  deplacerCurseurXY(100, 28);;
end;

// Affiche l'entête des colonnes pour la cantine
procedure enteteCantineIHM();
begin
  // Entête du numéro
  deplacerCurseurXY(11,6);write('Numéro');
  // Entête du nom
  deplacerCurseurXY(23,6); write('Nom');
  // Entête du prix
  deplacerCurseurXY(50,6); write('Prix');
  // Entête de bonus de vie
  deplacerCurseurXY(63,5); write('Bonus de');
  deplacerCurseurXY(64,6); write('vie');
  // Entête de bonus de vitesse
  deplacerCurseurXY(77,5); write('Bonus  de');
  deplacerCurseurXY(78,6); write('vitesse');
  // Entete de la quantité possédée
  deplacerCurseurXY(95,6); write('Quantité possédée');

  deplacerCurseurXY(100, 28);
end;



// Affiche le contour de la cantine
procedure cantineIHM();
begin
  effacerEcran();
  CadrePrincipal('Cantine : sélectionnez un numéro pour manger');
  deplacerCurseurXY(10,28); write(' 0/ Retourner à la ville ');
  deplacerCurseurXY(85,28); write(' Votre choix :   ');
end;

end.

