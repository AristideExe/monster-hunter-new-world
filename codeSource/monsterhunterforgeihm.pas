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
procedure afficherArmeForgeIHM(arme : typeArme; craftable : boolean;numeroArme : integer; derniereLigne : boolean);
// Affiche l'entête des colonnes pour la forge des armes
procedure enteteForgeArmeIHM();
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


  deplacerCurseurXY(20,28); write(' O/ Retourner à la ville ');
  deplacerCurseurXY(85,28); write(' Votre choix :   ');
  deplacerCurseurXY(100,28);

  readln(choixItemForgeIHM);
end;

end.

