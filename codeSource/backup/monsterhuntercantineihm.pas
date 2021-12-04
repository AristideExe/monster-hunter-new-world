unit monsterHunterCantineIHM;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface

uses
  Classes, SysUtils,GestionEcran,monsterHunterCantine, monsterHunterJoueur;

// Affichage pour sélectionner si on veut manger ou acheter de la nourriture
function cantineIHM() : string;
// Affiche l'entête des colonnes pour la cantine
procedure enteteNourritureIHM();
// Afficher une nourriture en particulier
procedure afficherNourritureIHM(nourriture : typeNourriture ; positionNourriture, numeroNourriture : integer);
procedure nePeutPasMangerIHM();
procedure mangerNourritureIHM(nourriture:typeNourriture);
procedure achatNourritureIHM();
// Affiche le contour de l'endroit pour manger
procedure mangerIHM();
// Demande la quantité que souhaite acheter le joueur
function choisirQuantiteIHM() : string;
// IHM qui s'affiche lorsque le joueur essaye d'acheter de la nourriture sans en avoir les moyens
procedure nePeutPasAcheterIHM();


// =========================================================================== IMPLEMENTATION ===================================================================================
implementation

// ------------------------------------------------- ACHETER NOURRITURE -----------------------------------------------
// Demande la quantité que souhaite acheter le joueur
function choisirQuantiteIHM() : string;
begin
  dessinerCadreXY(30,12,90,18,double,White,Black);
  deplacerCurseurXY(49,13);write('Sélectionnez la quantité');
  deplacerCurseurXY(48,14);write('0 / Annuler la transaction');
  deplacerCurseurXY(55,16);write('Quantité : ');
  readln(choisirQuantiteIHM);
end;

// IHM qui s'affiche lorsque le joueur essaye d'acheter de la nourriture sans en avoir les moyens
procedure nePeutPasAcheterIHM();
begin
  dessinerCadreXY(30,12,90,18,double,White,Black);
  deplacerCurseurXY(40,14);write('Vous ne pouvez pas acheter cette quantité');
  deplacerCurseurXY(42,16);write('Appuyez sur entrée pour continuer ');
  readln;
end;






// ------------------------------------------------- MANGER -----------------------------------------------
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
procedure afficherNourritureIHM(nourriture : typeNourriture ; positionNourriture, numeroNourriture : integer);
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

  deplacerCurseurXY(100, 28);
end;

// Affiche l'entête des colonnes pour la cantine
procedure enteteNourritureIHM();
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

procedure achatNourritureIHM();
begin
  effacerEcran();
  CadrePrincipal('Vente : sélectionnez un numéro pour acheter');
  deplacerCurseurXY(10,28); write(' 0/ Retourner à la cantine ');
  deplacerCurseurXY(85,28); write(' Votre choix :   ');
end;


// Affiche un message si le joueur ne possède aucune nourriture
procedure aucuneNourriturePossedeeIHM();
begin
  dessinerCadreXY(30,12,90,18,double,White,Black);
  deplacerCurseurXY(43,14);write('Vous ne possédez aucune nourriture');
  deplacerCurseurXY(38,16);write('Appuyez sur entrée pour revenir à la chambre ');
  readln;
end;

// Affiche le contour de l'endroit pour manger
procedure mangerIHM();
begin
  effacerEcran();
  CadrePrincipal('Cantine : sélectionnez un numéro pour manger');

  // Affichage des bonus
  dessinerCadreXY(43,23,77,28,double,White,Black);
  deplacerCurseurXY(46,25); write('Bonus de vie : ', getJoueur.buffVie); if getJoueur.buffVie = 50 then write(' (max)');
  deplacerCurseurXY(46,26); write('Bonus de vitesse : ', getJoueur.buffVitesse); if getJoueur.buffVitesse = 30 then write(' (max)');


  deplacerCurseurXY(10,28); write(' 0/ Retourner à la cantine ');
  deplacerCurseurXY(85,28); write(' Votre choix :   ');
end;




// ------------------------------------------------- CANTINE -----------------------------------------------
// Affichage pour sélectionner si on veut manger ou acheter de la nourriture
function cantineIHM() : string;
begin
  effacerEcran();
  cadrePrincipal('Cantine');
  deplacerCurseurXY(15,15); write('1/ Manger');
  deplacerCurseurXY(15,17); write('2/ Acheter de la nourriture');

  deplacerCurseurXY(10,28); write(' 0/ Retourner à la cantine ');
  deplacerCurseurXY(85,28); write(' Votre choix :   ');
  deplacerCurseurXY(100,28);
  readln(cantineIHM);
end;

end.

