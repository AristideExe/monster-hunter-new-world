unit monsterHunterMarchandIHM;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils, GestionEcran, monsterHunterJoueur, monsterHunterArmesEtArmures, monsterHunterCantine;

// Affiche l'interface du marchand
function marchandIHM() : string;
// IHM de l'achat des composants
function achatObjetsIHM() : string;
// IHM de l'achat des composants
function achatComposantsIHM() : string;
// IHM qui s'affiche lorsque le joueur essaye d'acheter quelque chose sans en avoir les moyens
procedure nePeutPasAcheterIHM();
// IHM qui s'affiche lorsque le joueur essaye de vendre quelque chose en trop grande quantité
procedure nePeutPasVendreIHM();
// Demande la quantité que souhaite acheter ou vendre le joueur
function choisirQuantiteIHM() : string;
procedure venteComposantsIHM();
// Affiche un message si le joueur ne possède aucun composant
procedure aucunComposantPossedeIHM();
procedure enteteVenteComposantsIHM();
// Affichage d'un composant dans la vente
procedure afficherComposantIHM(compteurComposant, positionItem : integer);
// IHM qui s'affiche lorsqu'on a vendu des composants
procedure venduComposantsIHM(item : typeItemDeCraft; quantite : integer);


// =========================================================================== IMPLEMENTATION ===================================================================================
implementation

// Demande la quantité que souhaite acheter ou vendre le joueur
function choisirQuantiteIHM() : string;
begin
  dessinerCadreXY(30,12,90,18,double,White,Black);
  deplacerCurseurXY(49,13);write('Sélectionnez la quantité');
  deplacerCurseurXY(48,14);write('0 / Annuler la transaction');
  deplacerCurseurXY(55,16);write('Quantité : ');
  readln(choisirQuantiteIHM);
end;

// IHM qui s'affiche lorsque le joueur essaye d'acheter quelque chose sans en avoir les moyens
procedure nePeutPasAcheterIHM();
begin
  dessinerCadreXY(30,12,90,18,double,White,Black);
  deplacerCurseurXY(40,14);write('Vous ne pouvez pas acheter cette quantité');
  deplacerCurseurXY(42,16);write('Appuyez sur entrée pour continuer ');
  readln;
end;

// IHM qui s'affiche lorsque le joueur essaye de vendre quelque chose en trop grande quantité
procedure nePeutPasVendreIHM();
begin
  dessinerCadreXY(30,12,90,18,double,White,Black);
  deplacerCurseurXY(40,14);write('Vous ne pouvez pas vendre cette quantité');
  deplacerCurseurXY(42,16);write('Appuyez sur entrée pour continuer ');
  readln;
end;

// Affiche l'interface du marchand
function marchandIHM() : string;
begin
  effacerEcran();
  cadrePrincipal('Marchand');
  dessinerCadreXY(84,2,116,6,double,White,Black);

  // Affichage de l'argent
  deplacerCurseurXY(100 - round(length('Vous avez '+ IntToStr(getJoueur.argent) + ' Simonnaie')/2), 4); write('Vous avez ' + IntToStr(getJoueur.argent) + ' Simonnaie');

  // Affichage des options

  deplacerCurseurXY(70,13); write('1/ Acheter des objets');
  deplacerCurseurXY(70,16); write('2/ Acheter des composants');
  deplacerCurseurXY(70,19); write('3/ Vendre des composants');

  deplacerCurseurXY(20,28); write(' O/ Retourner à la ville ');
  deplacerCurseurXY(85,28); write(' Votre choix :   ');
  dessinCouleurSansEspaces('dessins/StandMarchand.txt',20,7);
  deplacerCurseurXY(100,28);
  readln(marchandIHM);
end;


// -------------------------------------------------- ACHAT D'OBJETS --------------------------------------------------
// IHM de l'achat des composants
function achatObjetsIHM() : string;
begin
  effacerEcran();
  cadrePrincipal('Achat d''objets (Vous avez ' + intToStr(getJoueur.argent) + ' Simonnaie)');

  // Entête
  deplacerCurseurXY(10,5);write('Numéro');
  deplacerCurseurXY(25,5); write('Nom');
  deplacerCurseurXY(48,5); write('Prix d''achat');
  deplacerCurseurXY(80,5); write('Quantité dans l''inventaire');

  // Affichage des bombes
  deplacerCurseurXY(10,7);write('1');
  deplacerCurseurXY(25,7); write('Bombes');
  deplacerCurseurXY(48,7); write('30 Simonnaie');
  deplacerCurseurXY(80,7); write(getJoueur.objetsPossedes[0]);

  // Affichage des potions de soin
  deplacerCurseurXY(10,8);write('2');
  deplacerCurseurXY(25,8); write('Potion de soin');
  deplacerCurseurXY(48,8); write('20 Simonnaie');
  deplacerCurseurXY(80,8); write(getJoueur.objetsPossedes[1]);

  // Affichage des pierres ponces
  deplacerCurseurXY(10,9);write('3');
  deplacerCurseurXY(25,9); write('Pierre ponce');
  deplacerCurseurXY(48,9); write('50 Simonnaie');
  deplacerCurseurXY(80,9); write(getJoueur.objetsPossedes[2]);

  // Affichage des choix
  deplacerCurseurXY(10,28); write(' 0/ Retourner au marchand ');
  deplacerCurseurXY(85,28); write(' Votre choix :   '); deplacerCurseurXY(100,28);

  readln(achatObjetsIHM);
end;





// ------------------------------------------------- ACHAT DE COMPOSANTS -----------------------------------------------
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

// IHM qui s'affiche lorsqu'on a vendu des composants
procedure venduComposantsIHM(item : typeItemDeCraft; quantite : integer);
begin
  dessinerCadreXY(30,12,90,18,double,White,Black);
  deplacerCurseurXY(42-(length(item.nom) div 2),14);write('Vous avez vendu ', quantite, 'x ', item.nom, ' pour ', item.prixVente*quantite, ' Simonnaie');
  deplacerCurseurXY(43,16);write('Appuyez sur entrée pour continuer ');
  readln;
end;

// Affichage du menu de vente de composants
procedure venteComposantsIHM();
begin
  effacerEcran();
  cadrePrincipal('Vente de composants');
  deplacerCurseurXY(10,28); write(' 0/ Retourner au marchand   -1 / Vendre tout ');
  deplacerCurseurXY(85,28); write(' Votre choix :   ');
end;

// Affiche un message si le joueur ne possède aucun composant
procedure aucunComposantPossedeIHM();
begin
  dessinerCadreXY(30,12,90,18,double,White,Black);
  deplacerCurseurXY(43,14);write('Vous ne possédez aucun composant');
  deplacerCurseurXY(38,16);write('Appuyez sur entrée pour revenir chez le marchand ');
  readln;
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

  deplacerCurseurXY(100,28);
end;

// Affichage d'un composant dans la vente
procedure afficherComposantIHM(compteurComposant, positionItem : integer);
begin
  // Entête du numéro
  deplacerCurseurXY(20,compteurComposant + 7);write(compteurComposant);
  // Entête du nom
  deplacerCurseurXY(35,compteurComposant + 7); write(itemsDeCraftsDisponibles[positionItem].nom);
  // Entête du prix de vente
  deplacerCurseurXY(60,compteurComposant + 7); write(itemsDeCraftsDisponibles[positionItem].prixVente, ' Simonnaie');
  // Entete de la quantité possédée
  deplacerCurseurXY(85,compteurComposant + 7); write(getJoueur.itemsPossedes[positionItem]);



  deplacerCurseurXY(100,28);
end;

end.

