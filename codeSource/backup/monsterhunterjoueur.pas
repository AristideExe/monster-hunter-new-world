unit monsterHunterJoueur;

{$mode objfpc}{$H+}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils, monsterHunterArmesEtArmures, monsterHunterVille;

// ------------------------------------------------- TYPES -----------------------------------------------
type
  // Type qui représente un personnage
  typePersonnage = record
    nom : string;
    taille : string;
    sexe : string;
<<<<<<< HEAD
=======
    piecesOr : integer;
    buffAttaque : real;
    buffVitesse : real;
>>>>>>> 80cd3a972133886fc852fa3db54ea7f76eea889a
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








// =========================================================================== IMPLEMENTATION ===================================================================================
implementation
uses monsterHunterIHM, monsterHunterMenuIHM;


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
  modifierArme(joueur.armePortee,armesDisponibles[0].nom,armesDisponibles[0].arme,armesDisponibles[0].element,armesDisponibles[0].emoussementDepart,armesDisponibles[0].emoussement,armesDisponibles[0].valeurAttaque);


  // Modification de l'inventaire d'armes pour qu'il soit vide
  for j:=0 to length(joueur.armesPossedees)-1 do modifierArme(joueur.armesPossedees[j],'NULL',typePieceArme(0),normal,-1,-1,0);

  // Modification de l'inventaire d'items pour avoir aucun item
  for j:=0 to length(joueur.itemsPossedes)- 1 do joueur.itemsPossedes[j] := 0;
  // Remplissage pour tester les crafts
  joueur.itemsPossedes[0] := 5;
  joueur.itemsPossedes[3] := 10;


  creationPersonnage();
end;



// --------------------------------------------- FONCTIONS DE RENVOI -----------------------------------------
// Renvoie le joueur
function getJoueur() : typePersonnage;
begin
  getJoueur := joueur
end;

end.

