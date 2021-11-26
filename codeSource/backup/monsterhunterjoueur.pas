unit monsterHunterJoueur;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils, monsterHunterArmesEtArmures;

// ------------------------------------------------- TYPES -----------------------------------------------
type
  // Type qui représente un personnage
  typePersonnage = record
    nom : string;
    taille : string;
    sexe : string;
    vitesse : integer;
    // 5 éléments d'armure : casque, torse, jambières, bottes, gants
    armurePortee : array [0..4] of typeArmure;
    armuresPossedees : array [0..NOMBRE_ARMURES_JEU-1] of typeArmure;
    armePortee : typeArme;
    armesPossedees : array [0..NOMBRE_ARMES_JEU-1] of typeArme;
    // Liste dans lequel on met la quantité de chaque item
    itemsPossedes : array [0..NOMBRE_ITEM_DE_CRAFT_JEU-1] of integer;
  end;


// ------------------------------------------------- VARIABLES ---------------------------------------------
var
   // Variable qui représente le joueur
   joueur : typePersonnage;


// ------------------------------------------------- FONCTIONS ---------------------------------------------
// Fonction qui retourne le joueur
function getJoueur() : typePersonnage;
// Initialisation des stats du personnage à sa création
procedure initialisationPersonnage();
// Procédure pour retirer des items de craft de l'inventaire du joueur
procedure retirerItem(positionItem, nombreItem : integer);
// Procédure pour mettre une arme dans l'inventaire du personnage
procedure donnerArmeJoueur(positionArme : integer;arme : typeArme);








// =========================================================================== IMPLEMENTATION ===================================================================================
implementation
uses monsterHunterMenuIHM,monsterHunterVille;


// Menu de création de personnage
procedure creationPersonnage();
begin
  creationPersonnageIHM(joueur.nom, joueur.taille, joueur.sexe);

  while (joueur.sexe <> 'M') and (joueur.sexe <> 'F') do
        demanderSexeIHM(joueur.sexe);

  afficherPersonnageIHM(joueur.sexe);
  ville();
end;


// Initialisation des stats du personnage à sa création
procedure initialisationPersonnage();
var
  i,j, k : integer;
begin
  // Initialisatin de l'armure pour que toutes les valeurs soient vides
  for i:=0 to length(joueur.armurePortee) do modifierArmure(joueur.armurePortee[i],'NULL',typePieceArmure(i),normal,0,0);
  // On lui donne une armure pour commencer le jeu
  modifierArmure(joueur.armurePortee[1],armuresDisponibles[1].nom,armuresDisponibles[1].pieceArmure,armuresDisponibles[1].element,armuresDisponibles[1].valeurDefense,armuresDisponibles[1].tauxEsquive);

  // Modification de l'inventaire d'armures pour qu'il soit vide
  for i:=0 to length(joueur.armuresPossedees)-1 do modifierArmure(joueur.armuresPossedees[i],'NULL',typePieceArmure(i mod 5),normal,0,0);

  // On lui donne une épe de base pour commencer le jeu
  joueur.armePortee := armesDisponibles[0];


  // Modification de l'inventaire d'armes pour qu'il soit vide
  for j:=0 to length(joueur.armesPossedees)-1 do modifierArme(joueur.armesPossedees[j],'NULL',typePieceArme(0),normal,-1,-1,0);

  // Modification de l'inventaire d'items pour avoir aucun item
  for k:=0 to length(joueur.itemsPossedes)- 1 do joueur.itemsPossedes[k] := 0;
  // Remplissage pour tester les crafts
  joueur.itemsPossedes[1] := 60;
  joueur.itemsPossedes[2] := 56;

  //fixe la vitesse du joueur à 100
  joueur.vitesse:=100;


  creationPersonnage();
end;





// --------------------------------------------- FONCTIONS POUR MODIFIER LE JOUEUR -----------------------------------------
// Procédure pour retirer des items de craft de l'inventaire du joueur
procedure retirerItem(positionItem, nombreItem : integer);
begin
  joueur.itemsPossedes[positionItem] := joueur.itemsPossedes[positionItem] - nombreItem;
end;

// Procédure pour mettre une arme dans l'inventaire du personnage
procedure donnerArmeJoueur(positionArme : integer;arme : typeArme);
begin
  joueur.armesPossedees[positionArme] := arme;
end;


// --------------------------------------------- FONCTIONS DE RENVOI -----------------------------------------
// Renvoie le joueur
function getJoueur() : typePersonnage;
begin
  getJoueur := joueur
end;

end.

