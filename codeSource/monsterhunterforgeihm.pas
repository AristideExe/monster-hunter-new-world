unit monsterHunterForgeIHM;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils, GestionEcran, monsterHunterArmesEtArmures;

function choixItemForgeIHM() : string;
// Affiche l'interface de la forge en général
procedure forgeIHM();
// Afficher une arme en particulier
procedure afficherArmeForgeIHM(arme : typeArme; craftable : boolean;numeroArme : integer);
// Afficher une arme en particulier
procedure afficherArmureForgeIHM(armure : typeArmure; craftable : boolean;numeroArmure : integer);
// Affiche l'entête des colonnes pour la forge des armes
procedure enteteForgeArmeIHM();
// Affiche l'entête des colonnes pour la forge des armures
procedure enteteForgeArmureIHM();
// Procédure qui s'affiche lorsque le joueur essaye de forger quelque chose qu'il ne peut pas
procedure nePeutPasForgerIHM();
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
procedure nePeutPasForgerIHM();
begin
  dessinerCadreXY(30,12,90,18,double,White,Black);
  deplacerCurseurXY(44,14);write('Vous ne pouvez pas forger ceci');
  deplacerCurseurXY(42,16);write('Appuyez sur entrée pour continuer ');
  readln;
end;

// Affiche l'entête des colonnes pour la forge des armures
procedure enteteForgeArmureIHM();
begin
  effacerEcran();
  // Entête du numéro
  deplacerCurseurXY(5,4);write('Numéro');
  // Entête du nom
  deplacerCurseurXY(20,4); write('Nom');
  // Entête du type d'arme
  deplacerCurseurXY(62,4); write('Type');
  // Entête de l'élément de l'arme
  deplacerCurseurXY(78,4); write('Élément');
  // Entête de la valeur d'attaque
  deplacerCurseurXY(100,4); write('Valeur d''attaque');
end;

// Afficher une arme en particulier
procedure afficherArmureForgeIHM(armure : typeArmure; craftable : boolean;numeroArmure : integer);
begin
  if craftable then couleurTexte(green);
  // Affichage du numéro
  deplacerCurseurXY(5,numeroArmure+5);
  write(numeroArmure);
  // Affichage du nom
  deplacerCurseurXY(20,numeroArmure+5);
  write(armure.nom);
  // Affichage du type d'arme
  //deplacerCurseurXY(62,numeroArmure +5); write(armure.arme);
  // Affichage de l'élément de l'arme
  deplacerCurseurXY(78,numeroArmure +5); write(armure.element);
  // Affichage du taux d'attaque de l'arme
  //deplacerCurseurXY(100,numeroArmure +5); write(armure.valeurAttaque:6:2);

  couleurTexte(white);
end;

// Afficher une arme en particulier
procedure afficherArmeForgeIHM(arme : typeArme; craftable : boolean;numeroArme : integer);
begin
  if craftable then couleurTexte(green);
  // Affichage du numéro
  deplacerCurseurXY(5,numeroArme+5);
  write(numeroArme);
  // Affichage du nom
  deplacerCurseurXY(20,numeroArme+5);
  write(arme.nom);
  // Affichage du type d'arme
  deplacerCurseurXY(62,numeroArme +5); write(arme.arme);
  // Affichage de l'élément de l'arme
  deplacerCurseurXY(78,numeroArme +5); write(arme.element);
  // Affichage du taux d'attaque de l'arme
  deplacerCurseurXY(100,numeroArme +5); write(arme.valeurAttaque:6:2);

  couleurTexte(white);
end;

// Affiche l'entête des colonnes pour la forge des armes
procedure enteteForgeArmeIHM();
begin
  effacerEcran();
  // Entête du numéro
  deplacerCurseurXY(5,4);write('Numéro');
  // Entête du nom
  deplacerCurseurXY(20,4); write('Nom');
  // Entête du type d'arme
  deplacerCurseurXY(62,4); write('Type');
  // Entête de l'élément de l'arme
  deplacerCurseurXY(78,4); write('Élément');
  // Entête de la valeur d'attaque
  deplacerCurseurXY(100,4); write('Valeur d''attaque');
end;

// Affiche l'interface de la forge en général
procedure forgeIHM();
begin
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
  deplacerCurseurXY(20,28); write('0/ Retourner à la ville');
  deplacerCurseurXY(20,29); write('Votre choix : ');
  readln(choixItemForgeIHM);
end;

end.

