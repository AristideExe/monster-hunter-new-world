unit monsterHunterJoueur;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils, monsterHunterArmesEtArmures, monsterHunterCantine;

// ------------------------------------------------- TYPES -----------------------------------------------
type
  // Type qui représente un personnage
  typePersonnage = record
    nom : string;
    taille : string;
    sexe : string;
    vie : integer;
    vitesse : integer;
    argent : integer;
    // 5 éléments d'armure : casque, torse, jambières, bottes, gants
    armurePortee : array [0..4] of typeArmure;
    armuresPossedees : array [0..NOMBRE_ARMURES_JEU-1] of typeArmure;
    armePortee : typeArme;
    armesPossedees : array [0..NOMBRE_ARMES_JEU-1] of typeArme;
    // Liste dans lequel on met la quantité de chaque item
    itemsPossedes : array [0..NOMBRE_ITEM_DE_CRAFT_JEU-1] of integer;
    // La quantité de chaque objet que possède le joueur (0 : bombe, 1 :  potion de soin, 2 : pierre ponce)
    objetsPossedes : array[0..2] of integer;
    objetsPortes : array[0..2] of integer;
    // La quantité de chaque nourriture que possède le joueur
    nourrituresPossedees: array[0..NOMBRE_NOURRITURES_JEU-1] of integer;
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
procedure retirerItemJoueur(positionItem, nombreItem : integer);

// Procédure pour donner des items au joueur
procedure ajouterItemJoueur(positionItem, nombreItem : integer);

// Procédure pour donner un objet au joueur
procedure ajouterObjetJoueur(positionObjet, quantite : integer);

// Procédure pour retirer un objet au joueur
procedure retirerObjetJoueur(positionObjet, quantite : integer);

// Procédure pour donner de la nourriture au joueur
procedure ajouterNourritureJoueur(positionNourriture, quantite : integer);

// Procédure pour retirer de la nourriture au joueur
procedure retirerNourritureJoueur(positionNourriture, quantite : integer);

// Procédure pour vider l'inventaire d'objets du joueur
procedure viderInventaireObjetsJoueur();

// Procédure pour mettre une arme dans l'inventaire du personnage
procedure donnerArmeJoueur(positionArme : integer;arme : typeArme);

// Procédure pour mettre une armure dans l'inventaire du personnage
procedure donnerArmureJoueur(positionArmure : integer;armure : typeArmure);

// Procédure pour retirer de l'argent au joueur
procedure retirerArgentJoueur(quantite : integer);

//Procedure qui modifie les pv du joueur
procedure modifierVieJoueur (nouvelleVie:integer);

// Procédure pour ajouter de l'argent au joueur
procedure ajouterArgentJoueur(quantite : integer);

// Procédure pour réinitialiser l'emoussement de l'arme portée par le jouer
procedure reinitialiserEmoussementArmeJoueur();


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

  // Modification de l'inventaire d'armures pour qu'il soit vide
  for i:=0 to length(joueur.armuresPossedees)-1 do modifierArmure(joueur.armuresPossedees[i],'NULL',typePieceArmure(i mod 5),normal,0,0);

  // On lui donne une épe de base pour commencer le jeu
  joueur.armePortee := armesDisponibles[0];


  // Modification de l'inventaire d'armes pour qu'il soit vide
  for j:=0 to length(joueur.armesPossedees)-1 do modifierArme(joueur.armesPossedees[j],'NULL',typePieceArme(0),normal,-1,-1,0);

  // Modification de l'inventaire d'items pour avoir aucun item
  for k:=0 to length(joueur.itemsPossedes)- 1 do joueur.itemsPossedes[k] := 0;


  // Modification de l'inventaire de nourriture pour qu'il soit vide
  for i:=0 to length(joueur.nourrituresPossedees)-1 do joueur.nourrituresPossedees[i] := 0;

  //fixe la vitesse du joueur à 100
  joueur.vitesse:=100;

  //fixe les pv du joueur à 100
  joueur.vie:=100;

  //Fixe l'argent du joueur à 100 Simonnaie
  joueur.argent:=100;

  creationPersonnage();
end;


// --------------------------------------------- FONCTIONS POUR MODIFIER LE JOUEUR -----------------------------------------
// Procédure pour retirer des items de craft de l'inventaire du joueur
procedure retirerItemJoueur(positionItem, nombreItem : integer);
begin
  joueur.itemsPossedes[positionItem] := joueur.itemsPossedes[positionItem] - nombreItem;
end;

// Procédure pour donner des items au joueur
procedure ajouterItemJoueur(positionItem, nombreItem : integer);
begin
  joueur.itemsPossedes[positionItem] := joueur.itemsPossedes[positionItem] + nombreItem;
end;

// Procédure pour donner de la nourriture au joueur
procedure ajouterNourritureJoueur(positionNourriture, quantite : integer);
begin
  joueur.nourrituresPossedees[positionNourriture] := joueur.nourrituresPossedees[positionNourriture] + quantite;
end;

// Procédure pour retirer de la nourriture au joueur
procedure retirerNourritureJoueur(positionNourriture, quantite : integer);
begin
  joueur.nourrituresPossedees[positionNourriture] := quantite - joueur.nourrituresPossedees[positionNourriture];
end;

// Procédure pour donner un objet au joueur
procedure ajouterObjetJoueur(positionObjet, quantite : integer);
begin
  joueur.objetsPossedes[positionObjet] := joueur.objetsPossedes[positionObjet] + quantite;
end;

// Procédure pour retirer un objet au joueur
procedure retirerObjetJoueur(positionObjet, quantite : integer);
begin
  joueur.objetsPossedes[positionObjet] := joueur.objetsPossedes[positionObjet] - quantite;
end;

// Procédure pour vider l'inventaire d'objets du joueur
procedure viderInventaireObjetsJoueur();
begin
  joueur.objetsPossedes[0] := 0;
  joueur.objetsPossedes[1] := 0;
  joueur.objetsPossedes[2] := 0;
end;

// Procédure pour réinitialiser l'emoussement de l'arme portée par le jouer
procedure reinitialiserEmoussementArmeJoueur();
begin
  joueur.armePortee.emoussement := joueur.armePortee.emoussementDepart;
end;

// Procédure pour retirer de l'argent au joueur
procedure retirerArgentJoueur(quantite : integer);
begin
  joueur.argent := joueur.argent - quantite;
end;

// Procédure pour ajouter de l'argent au joueur
procedure ajouterArgentJoueur(quantite : integer);
begin
  joueur.argent := joueur.argent + quantite;
end;

// Procédure pour mettre une arme dans l'inventaire du personnage
procedure donnerArmeJoueur(positionArme : integer;arme : typeArme);
begin
  joueur.armesPossedees[positionArme] := arme;
end;

// Procédure pour mettre une armure dans l'inventaire du personnage
procedure donnerArmureJoueur(positionArmure : integer;armure : typeArmure);
begin
  joueur.armuresPossedees[positionArmure] := armure;
end;

//Procedure qui modifie les pv du joueur
procedure modifierVieJoueur (nouvelleVie:integer);
begin
  joueur.vie := nouvelleVie;
end;

// --------------------------------------------- FONCTIONS DE RENVOI -----------------------------------------
// Renvoie le joueur
function getJoueur() : typePersonnage;
begin
  getJoueur := joueur
end;

end.

