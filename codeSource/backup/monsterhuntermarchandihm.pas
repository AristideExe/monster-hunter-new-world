unit monsterHunterMarchandIHM;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils, GestionEcran, monsterHunterJoueur, monsterHunterArmesEtArmures;

// Affiche l'interface du marchand
function marchandIHM() : string;
// IHM de l'achat des composants
function achatComposantsIHM() : string;
// IHM qui s'affiche lorsque le joueur essaye d'acheter quelque chose sans en avoir les moyens
procedure nePeutPasAcheterIHM();
// IHM qui s'affiche lorsque le joueur essaye de vendre quelque chose en trop grande quantité
procedure nePeutPasVendreIHM();
// Demande la quantité que souhaite acheter ou vendre le joueur
function choisirQuantiteIHM() : string;
procedure venteComposantsIHM();
procedure enteteVenteComposantsIHM();
// Affichage d'un composant dans la vente
procedure afficherComposantIHM(compteurComposant, positionItem : integer);

// =========================================================================== IMPLEMENTATION ===================================================================================
implementation

// Demande la quantité que souhaite acheter ou vendre le joueur
function choisirQuantiteIHM() : string;
begin
  dessinerCadreXY(30,12,90,18,double,White,Black);
  deplacerCurseurXY(40,14);write('Sélectionnez la quantité');
  deplacerCurseurXY(39,15);write('0 / Annuler la transaction');
  deplacerCurseurXY(37,16);write('Quantité : ');
  readln(choisirQuantiteIHM);
end;

// IHM qui s'affiche lorsque le joueur essaye d'acheter quelque chose sans en avoir les moyens
procedure nePeutPasAcheterIHM();
begin
  dessinerCadreXY(30,12,90,18,double,White,Black);
  deplacerCurseurXY(40,14);write('Vous ne pouvez pas acheter ceci');
  deplacerCurseurXY(42,16);write('Appuyez sur entrée pour continuer ');
  readln;
end;

// IHM qui s'affiche lorsque le joueur essaye de vendre quelque chose en trop grande quantité
procedure nePeutPasVendreIHM();
begin
  dessinerCadreXY(30,12,90,18,double,White,Black);
  deplacerCurseurXY(40,14);write('Vous ne pouvez pas vendre autant');
  deplacerCurseurXY(42,16);write('Appuyez sur entrée pour continuer ');
  readln;
end;

// Affiche l'interface du marchand
function marchandIHM() : string;
begin
  effacerEcran();
  cadrePrincipal('Marchand');

  // Affichage de l'argent
  deplacerCurseurXY(80, 5); write('Vous avez ', getJoueur.argent, ' Simonnaie');

  // Affichage des options
  deplacerCurseurXY(17,19); write('1/ Acheter des objets');
  deplacerCurseurXY(80,19); write('2/ Acheter des composants');
  deplacerCurseurXY(17,23); write('3/ Acheter de la nourriture');
  deplacerCurseurXY(80,23); write('4/ Vendre des composants');

  deplacerCurseurXY(20,28); write(' O/ Retourner à la ville ');
  deplacerCurseurXY(85,28); write(' Votre choix :   ');
  deplacerCurseurXY(100,28);
  readln(marchandIHM);
end;

// IHM de l'achat des composants
function achatComposantsIHM() : string;
var
  i : integer;
  positionBois, positionFer : integer;
begin
  // Initialisation de la position du bois et du fer pour simplifier le reste
  for i:=0 to NOMBRE_ITEM_DE_CRAFT_JEU-1 do
  begin
    if itemsDeCraftsDisponibles[i].nom = 'Bois' then positionBois := i
    else if itemsDeCraftsDisponibles[i].nom = 'Fer' then positionFer := i;
  end;

  effacerEcran();
  cadrePrincipal('Achat de composants (Vous avez ' + intToStr(getJoueur.argent) + ' Simonnaie)');

  // Entête
  deplacerCurseurXY(10,5);write('Numéro');
  deplacerCurseurXY(25,5); write('Nom');
  deplacerCurseurXY(48,5); write('Prix d''achat');
  deplacerCurseurXY(80,5); write('Quantité dans l''inventaire');

  // Affichage du bois
  deplacerCurseurXY(10,7);write('1');
  deplacerCurseurXY(25,7); write('Bois');
  deplacerCurseurXY(48,7); write('5 Simonnaie');
  deplacerCurseurXY(80,7); write(getJoueur.itemsPossedes[positionBois]);

  // Affichage du fer
  deplacerCurseurXY(10,8);write('2');
  deplacerCurseurXY(25,8); write('Fer');
  deplacerCurseurXY(48,8); write('15 Simonnaie');
  deplacerCurseurXY(80,8); write(getJoueur.itemsPossedes[positionFer]);

  // Affichage des choix
  deplacerCurseurXY(10,28); write(' 0/ Retourner au marchand ');
  deplacerCurseurXY(85,28); write(' Votre choix :   '); deplacerCurseurXY(100,28);

  readln(achatComposantsIHM);
end;





// ------------------------------------------------- VENTE DE COMPOSANTS -----------------------------------------------

// Affichage du menu de vente de composants
procedure venteComposantsIHM();
begin
  effacerEcran();
  cadrePrincipal('Vente de composants');
end;

// Affichage de l'entête de vente de composants
procedure enteteVenteComposantsIHM();
begin
  // Entête du numéro
  deplacerCurseurXY(20,6);write('Numéro');
  // Entête du nom
  deplacerCurseurXY(35,6); write('Nom');
  // Entête du prix de vente
  deplacerCurseurXY(60,6); write('Prix de vente');
  // Entete de la quantité possédée
  deplacerCurseurXY(85,6); write('Quantité possédée');
end;

// Affichage d'un composant dans la vente
procedure afficherComposantIHM(compteurComposant, positionItem : integer);
begin
  // Entête du numéro
  deplacerCurseurXY(20,compteurComposant + 7);write(compteurComposant);
  // Entête du nom
  deplacerCurseurXY(35,compteurComposant + 7); write(itemsDeCraftsDisponibles[positionItem].nom);
  // Entête du prix de vente
  deplacerCurseurXY(60,compteurComposant + 7); write(itemsDeCraftsDisponibles[positionItem].prixVente);
  // Entete de la quantité possédée
  deplacerCurseurXY(85,compteurComposant + 7); write(getJoueur.itemsPossedes[positionItem]);
end;

end.

