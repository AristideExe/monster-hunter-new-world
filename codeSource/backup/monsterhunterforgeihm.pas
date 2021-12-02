unit monsterHunterForgeIHM;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils, GestionEcran, monsterHunterArmesEtArmures, monsterHunterJoueur;

function choixItemForgeIHM() : string;
// Affiche l'interface de la forge en général
procedure forgeIHM();
// Afficher une arme en particulier

procedure afficherArmeForgeIHM(arme : typeArme; craftable : boolean;numeroArme : integer; derniereLigne : boolean);
// Afficher une arme en particulier
procedure afficherArmureForgeIHM(armure : typeArmure; craftable : boolean;numeroArmure : integer);



// Affiche l'entête des colonnes pour la forge des armes
procedure enteteForgeArmeIHM();
// Affiche l'entête des colonnes pour la forge des armures
procedure enteteForgeArmureIHM();
// Procédure qui s'affiche lorsque le joueur essaye de forger quelque chose qu'il ne peut pas
procedure nePeutPasForgerIHM(craft : typeCraft);
// Procédure qui s'affiche lorsque le joueur a crafté un objet
procedure afficherMessageCraftIHM(nomObjet : string);



// =========================================================================== IMPLEMENTATION ===================================================================================
implementation

// Procédure qui s'affiche lorsque le joueur a crafté un objet
procedure afficherMessageCraftIHM(nomObjet : string);
begin
  dessinerCadreXY(30,12,90,18,double,White,Black);
  deplacerCurseurXY(32,14);write('Félicitations, vous avez fabriqué ', nomObjet);
  deplacerCurseurXY(42,16);write('Appuyez sur entrée pour continuer ');
end;

// Procédure qui s'affiche lorsque le joueur essaye de forger quelque chose qu'il ne peut pas
procedure nePeutPasForgerIHM(craft : typeCraft);
var
  compteurItemsManquants : integer;
begin
  compteurItemsManquants := 0;

  dessinerCadreXY(20,10,100,20,double,White,Black);
  deplacerCurseurXY(44,11);write('Vous ne pouvez pas forger ceci');

  // On essaye de trouver ce qu'il mangue au joueur pour crafter l'objet

  // On affiche tous les items manquants ligne par ligne
  deplacerCurseurXY(50,12);write('Il vous manque : ');
  // Item 1
  if (getJoueur.itemsPossedes[craft.Item1] < craft.quantiteItem1) then
  begin
    deplacerCurseurXY(50,compteurItemsManquants + 13); write('- ', (craft.quantiteItem1 - getJoueur.itemsPossedes[craft.Item1]), 'x ' ,itemsDeCraftsDisponibles[craft.item1].nom);
    compteurItemsManquants := compteurItemsManquants + 1;
  end;
  if (craft.item2 <> -1 ) and (getJoueur.itemsPossedes[craft.Item2] < craft.quantiteItem2) then
  begin
    deplacerCurseurXY(50,compteurItemsManquants + 13); write('- ', (craft.quantiteItem2 - getJoueur.itemsPossedes[craft.Item2]), 'x ' ,itemsDeCraftsDisponibles[craft.item2].nom);
    compteurItemsManquants := compteurItemsManquants + 1;
  end;
  if (craft.item3 <> -1 ) and (getJoueur.itemsPossedes[craft.Item3] < craft.quantiteItem3) then
  begin
    deplacerCurseurXY(50,compteurItemsManquants + 13); write('- ', (craft.quantiteItem3 - getJoueur.itemsPossedes[craft.Item3]), 'x ' ,itemsDeCraftsDisponibles[craft.item3].nom);
    compteurItemsManquants := compteurItemsManquants + 1;
  end;
  if (craft.item4 <> -1 ) and (getJoueur.itemsPossedes[craft.Item4] < craft.quantiteItem4) then
  begin
    deplacerCurseurXY(50,compteurItemsManquants + 13); write('- ', (craft.quantiteItem4 - getJoueur.itemsPossedes[craft.Item4]), 'x ' ,itemsDeCraftsDisponibles[craft.item4].nom);
    compteurItemsManquants := compteurItemsManquants + 1;
  end;
  if (craft.item5 <> -1 ) and (getJoueur.itemsPossedes[craft.Item5] < craft.quantiteItem5) then
  begin
    deplacerCurseurXY(50,compteurItemsManquants + 13); write('- ', (craft.quantiteItem5 - getJoueur.itemsPossedes[craft.Item5]), 'x ' ,itemsDeCraftsDisponibles[craft.item5].nom);
    compteurItemsManquants := compteurItemsManquants + 1;
  end;


  deplacerCurseurXY(42,19);write('Appuyez sur entrée pour continuer ');
  readln;
end;

// Affiche l'entête des colonnes pour la forge des armures
procedure enteteForgeArmureIHM();
begin
  // Entête du numéro
  deplacerCurseurXY(13,6);write('Numéro');
  // Entête du nom
  deplacerCurseurXY(30,6); write('Nom');
  // Entête de l'élément de l'arme
  deplacerCurseurXY(62,6); write('Élément');
  // Entête de la valeur d'attaque
  deplacerCurseurXY(78,6); write('Valeur defense');
  // Entête du taux d'esquive
  deplacerCurseurXY(95,6); write('Taux d''esquive');
end;

// Afficher une armure en particulier
procedure afficherArmureForgeIHM(armure : typeArmure; craftable : boolean;numeroArmure : integer);
begin
  if craftable then couleurTexte(green);
  // Affichage du numéro
  deplacerCurseurXY(15,numeroArmure+7);
  write(numeroArmure);
  // Affichage du nom
  deplacerCurseurXY(30,numeroArmure+7);
  write(armure.nom);
  // Affichage du type d'arme
  deplacerCurseurXY(81,numeroArmure +7); write(armure.valeurDefense:6:2);
  // Affichage de l'élément de l'arme
  deplacerCurseurXY(62,numeroArmure +7); write(armure.element);
  // Affichage du taux d'attaque de l'arme
  deplacerCurseurXY(97,numeroArmure +7); write(armure.tauxEsquive:6:2);

  couleurTexte(white);
end;

// Afficher une arme en particulier
procedure afficherArmeForgeIHM(arme : typeArme; craftable : boolean;numeroArme : integer; derniereLigne : boolean);
begin
  if craftable then couleurTexte(green);
  // Affichage du numéro
  deplacerCurseurXY(15,numeroArme+7);
  write(numeroArme);
  // Affichage du nom
  deplacerCurseurXY(30,numeroArme+7);
  write(arme.nom);
  // Affichage du type d'arme
  deplacerCurseurXY(62,numeroArme +7); write(arme.arme);
  // Affichage de l'élément de l'arme

  deplacerCurseurXY(78,numeroArme +7); write(arme.element);
  // Affichage de l'élément de l'arme
  deplacerCurseurXY(100,numeroArme +7); write(arme.valeurAttaque:6:2);



  couleurTexte(white);

  if derniereLigne then deplacerCurseurXY(99, 28);
end;

// Affiche l'entête des colonnes pour la forge des armes
procedure enteteForgeArmeIHM();
begin
  // Entête du numéro
  deplacerCurseurXY(13,6);write('Numéro');
  // Entête du nom
  deplacerCurseurXY(30,6); write('Nom');
  // Entête du type d'arme
  deplacerCurseurXY(62,6); write('Type');
  // Entête de l'élément de l'arme
  deplacerCurseurXY(78,6); write('Élément');
  // Entête de la valeur d'attaque
  deplacerCurseurXY(95,6); write('Valeur d''attaque');
end;

// Affiche l'interface de la forge en général
procedure forgeIHM();
begin
  effacerEcran();
  CadrePrincipal('Forge : armes');
  deplacerCurseurXY(10,28); write(' 0/ Retourner au menu de sélection de la forge ');
  deplacerCurseurXY(85,28); write(' Votre choix :   ');
end;

function choixItemForgeIHM() : string;
begin
  effacerEcran();
  CadrePrincipal('Forge : Voici les différents type d''item');

  dessinerCadreXY(42,8,112,15,simple,White,Black);
  dessinerCadreXY(42,15,112,23,simple,White,Black);

  dessinerSansEspace('dessins/Chevalier.txt',6,6);

  dessinerCadreXY(46,7,73,9,simple,White,Black);
  dessinerCadreXY(82,7,108,9,simple,White,Black);
  dessinerCadreXY(45,14,73,16,simple,White,Black);
  dessinerCadreXY(81,14,108,16,simple,White,Black);
  dessinerCadreXY(46,22,71,24,simple,White,Black);
  dessinerCadreXY(83,22,108,24,simple,White,Black);

  deplacerCurseurXY(48,8); write('1/ Afficher les armes');
  deplacerCurseurXY(84,8); write('2/ Afficher les casques');
  deplacerCurseurXY(47,15); write('3/ Afficher les plastrons');
  deplacerCurseurXY(83,15); write('4/ Afficher les jambières');
  deplacerCurseurXY(48,23); write('5/ Afficher les bottes');
  deplacerCurseurXY(85,23); write('6/ Afficher les gants');


  deplacerCurseurXY(20,28); write(' 0/ Retourner à la ville ');
  deplacerCurseurXY(85,28); write(' Votre choix :   ');
  deplacerCurseurXY(100,28);

  readln(choixItemForgeIHM);
end;

end.

