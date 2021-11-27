unit monsterHunterArmesEtArmures;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, typInfo, strUtils, SysUtils;

// ------------------------------------------------- CONSTANTES ---------------------------------------------
const
  NOMBRE_ARMURES_JEU = 100;
  NOMBRE_ARMES_JEU = 17;
  NOMBRE_CRAFT_ARMES_JEU = 17;
  NOMBRE_CRAFT_ARMURES_JEU = 30;
  NOMBRE_ITEM_DE_CRAFT_JEU = 23;


  // ------------------------------------------------- TYPES -----------------------------------------------
type
  // Enumération des éléments disponibles
  typeElement = (normal,feu,eau,glace,plante,tonerre,lumiere,tenebres,electrique);
  // Enumération qui représente les parties d'armures disponibles
  typePieceArmure = (casque,torse,jambieres,bottes,gants);
  // Enumération qui représente les différentes armes disponibles
  typePieceArme = (epee,hache,marteau,couteau);
  // Type qui représente une armure
  typeArmure = record
             nom : string;
             pieceArmure : typePieceArmure;
             element : typeElement;
             valeurDefense : real;
             tauxEsquive : real;
  end;
  // Type qui représente une arme
  typeArme = record
             nom : string;
             arme : typePieceArme;
             element : typeElement;
             emoussementDepart : integer;
             emoussement: integer;
             valeurAttaque : real;
  end;
  // Array qui représente une pièce d'armure en particulier
  arrayPieceArmure = array [0..4] of typeArmure;
  // Type qui représente un craft
  typeCraft = record
             nombreItemsDeCraft : integer;
             item1 : integer;
             quantiteItem1 : integer;
             item2 : integer;
             quantiteItem2 : integer;
             item3 : integer;
             quantiteItem3 : integer;
             item4 : integer;
             quantiteItem4 : integer;
             item5 : integer;
             quantiteItem5 : integer;
  end;


  // ------------------------------------------------- VARIABLES ---------------------------------------------
var
  armuresDisponibles : array[0..NOMBRE_ARMURES_JEU-1] of typeArmure;
  armesDisponibles : array[0..NOMBRE_ARMES_JEU-1] of typeArme;
  craftsArmesDisponibles : array[0..NOMBRE_CRAFT_ARMES_JEU-1] of typeCraft;
  craftsArmuresDisponibles : array[0..NOMBRE_CRAFT_ARMURES_JEU-1] of typeCraft;


// ------------------------------------------------- FONCTIONS ---------------------------------------------
// Renvoi le string pour une pièce d'armure
function toStringPieceArmure(piece : typePieceArmure) : string;
// Fonction qui renvoie l'armure portée par le joueur en fonction de la piece demandée
function getArmureJoueur(armure : typePieceArmure) : typeArmure;
// Fonction qui renvoie la liste des pièces d'armures possédées par le joueur en fonction de la pièce demandée
function getPiecesPossedees(piece : typePieceArmure) : arrayPieceArmure;
// Procédure qui remplie la variable des armures disponibles depuis le fichier csv
procedure remplirArmuresDisponibles(fichier : string);
// Procédure qui remplie la variable des armes disponibles depuis le fichier csv
procedure remplirArmesDisponibles(fichier : string);
// Procédure qui remplie la variable des crafts disponibles depuis le fichier csv
procedure remplirCraftArmesDisponibles(fichier : string);
// Procédure qui remplie la variable des crafts d'armures disponibles depuis le fichier csv
procedure remplirCraftArmuresDisponibles(fichier : string);
// Procédure pour échanger deux armures
procedure echangerArmures(var armure1, armure2 : typeArmure);
// Procédure pour échanger deux armes
procedure echangerArmes(var arme1, arme2 : typeArme);
// Procédure pour modifier les valeurs d'une armure plus facilement
procedure modifierArmure(var armure : typeArmure; nom : string; pieceArmure : typePieceArmure; element : typeElement; valeurDefense, tauxEsquive : real);
// Procédure pour modifier les valeurs d'une arme plus facilement
procedure modifierArme(var arme : typeArme; nom :string; typeArme : typePieceArme; element : typeElement;emoussementDepart,emoussement : integer ; valeurAttaque : real);



// =========================================================================== IMPLEMENTATION ===================================================================================
implementation
uses monsterHunterJoueur;




// ----------------------------------------- FONCTIONS DE RENVOI DE STRING D'ÉNUMÉRATIONS ---------------------------------------------
// Renvoi le string pour une pièce d'armure
function toStringPieceArmure(piece : typePieceArmure) : string;
begin
  case piece of
  casque : toStringPieceArmure := 'casque';
  torse : toStringPieceArmure := 'torse';
  jambieres : toStringPieceArmure := 'jambières';
  bottes : toStringPieceArmure := 'bottes';
  gants : toStringPieceArmure := 'gants';
  end;
end;



// ----------------------------------------- FONCTIONS DE RENVOIE D'ÉLÉMENTS D'ÉNUMÉRATIONS ---------------------------------------------
// Fonction qui renvoit l'élément de l'énumération typeArme qui correspond au str passé en paramètre
function trouverArme(arme : string) : typePieceArme;
var
  i : integer;
begin
  for i:=0 to ord(high(typePieceArme)) do
      if (arme = getEnumName(TypeInfo(typePieceArme),i)) then trouverArme := typePieceArme(i);
end;

// Fonction qui renvoit l'élément de l'énumération typePieceArme qui correspond au str passé en paramètre
function trouverPieceArmure(piece : string) : typePieceArmure;
var
  i : integer;
begin
  for i:=0 to ord(high(typePieceArmure)) do
      if (piece = getEnumName(TypeInfo(typePieceArmure),i)) then trouverPieceArmure := typePieceArmure(i);
end;

// Fonction qui renvoit l'élément de l'énumération typeElement qui correspond au str passé en paramètre
function trouverElement(element : string) : typeElement;
var
  i : integer;
begin
  for i:=0 to ord(high(typeElement)) do
      if (element = getEnumName(TypeInfo(typeElement),i)) then trouverElement := typeElement(i);
end;






// ---------------------------------------------- PROCÉDURES D'ÉCHANGES D'ARMES ET ARMURES ----------------------------------------------
// Procédure pour échanger deux armures
procedure echangerArmures(var armure1, armure2 : typeArmure);
var
  armureTemp : typeArmure;
begin
  armureTemp := armure1;
  armure1 := armure2;
  armure2 := armureTemp;
end;

// Procédure pour échanger deux armes
procedure echangerArmes(var arme1, arme2 : typeArme);
var
  armeTemp : typeArme;
begin
  armeTemp := arme1;
  arme1 := arme2;
  arme2 := armeTemp;
end;




// ----------------------------- PROCÉDURES DE MODIFICATION D'ARMURES, D'ARMES ET DE CRAFT --------------------------------
// Procédure pour modifier les valeurs d'une armure plus facilement
procedure modifierArmure(var armure : typeArmure; nom : string; pieceArmure : typePieceArmure; element : typeElement; valeurDefense, tauxEsquive : real);
begin
  armure.nom := nom;
  armure.pieceArmure := pieceArmure;
  armure.element := element;
  armure.valeurDefense := valeurDefense;
  armure.tauxEsquive := tauxEsquive;
end;

// Procédure pour modifier les valeurs d'une arme plus facilement
procedure modifierArme(var arme : typeArme; nom :string; typeArme : typePieceArme; element : typeElement;emoussementDepart,emoussement : integer ; valeurAttaque : real);
begin
  arme.nom := nom;
  arme.arme := typeArme;
  arme.element := element;
  arme.emoussementDepart := emoussementDepart;
  arme.emoussement := emoussement;
  arme.valeurAttaque := valeurAttaque;
end;

// Procédure pour modifier les valeurs d'un craft plus facilement
procedure modifierCraft(var craft : typeCraft; nombreItemsDeCraft, item1, quantiteItem1, item2, quantiteItem2, item3, quantiteItem3, item4, quantiteItem4, item5, quantiteItem5 : integer);
begin
  craft.nombreItemsDeCraft := nombreItemsDeCraft;
  craft.item1 := item1;
  craft.quantiteItem1 := quantiteItem1;
  craft.item2 := item2;
  craft.quantiteItem2 := quantiteItem2;
  craft.item3 := item3;
  craft.quantiteItem3:= quantiteItem3;
  craft.item4 := item4;
  craft.quantiteItem4 := quantiteItem4;
  craft.item5 := item5;
  craft.quantiteItem5 := quantiteItem5;
end;






// ----------------------------- PROCÉDURES DE REMPLISSAGE DES ITEMS DE CRAFT ET DES CRAFTS SUIVANT LES FICHIERS CSV --------------------------------
// Procédure qui remplie la variable des crafts d'armes disponibles depuis le fichier csv
procedure remplirCraftArmesDisponibles(fichier : string);
var
  fichierCraft : TextFile;
  ligne : string;
  listeLigne : array of string;
  compteur : integer;
begin
  assignFile(fichierCraft, fichier);
  reset(fichierCraft);
  // Lecture de la première ligne du fichier qui sert d'entête
  readln(fichierCraft);
  compteur := 0;
  // On lit chaque ligne jusqu'à la fin du fichier
  repeat
        readln(fichierCraft,ligne);
        // On transforme la ligne en une liste
        listeLigne:= ligne.Split(';'); //ligne.Split(';'); //splitString(ligne,';');

        // On remplie la liste des crafts disponibles avec tous les champs du csv
        modifierCraft(craftsArmesDisponibles[compteur],strToInt(listeLigne[0]),strToInt(listeLigne[1]),strToInt(listeLigne[2]),strToInt(listeLigne[3]),strToInt(listeLigne[4]),
        strToInt(listeLigne[5]),strToInt(listeLigne[6]),strToInt(listeLigne[7]),strToInt(listeLigne[8]) ,strToInt(listeLigne[9]),strToInt(listeLigne[10]));
        compteur := compteur +1;
  until EOF(fichierCraft);
end;

// Procédure qui remplie la variable des crafts d'armures disponibles depuis le fichier csv
procedure remplirCraftArmuresDisponibles(fichier : string);
var
  fichierCraft : TextFile;
  ligne : string;
  listeLigne : array of string;
  compteur : integer;
begin
  assignFile(fichierCraft, fichier);
  reset(fichierCraft);
  // Lecture de la première ligne du fichier qui sert d'entête
  readln(fichierCraft);
  compteur := 0;
  // On lit chaque ligne jusqu'à la fin du fichier
  repeat
        readln(fichierCraft,ligne);
        // On transforme la ligne en une liste
        listeLigne:= ligne.Split(';'); //ligne.Split(';'); //splitString(ligne,';');

        // On remplie la liste des crafts disponibles avec tous les champs du csv
        modifierCraft(craftsArmuresDisponibles[compteur],strToInt(listeLigne[0]),strToInt(listeLigne[1]),strToInt(listeLigne[2]),strToInt(listeLigne[3]),strToInt(listeLigne[4]),
        strToInt(listeLigne[5]),strToInt(listeLigne[6]),strToInt(listeLigne[7]),strToInt(listeLigne[8]) ,strToInt(listeLigne[9]),strToInt(listeLigne[10]));
        compteur := compteur +1;
  until EOF(fichierCraft);
end;






// ----------------------------- PROCÉDURES DE REMPLISSAGE DES ARMES ET ARMURES SUIVANT LES FICHIERS CSV --------------------------------
// Procédure qui remplie la variable des armures disponibles depuis le fichier csv
procedure remplirArmuresDisponibles(fichier : string);
var
  fichierArmures : TextFile;
  ligne : string;
  listeLigne : array of string;
  // Stats de chaque armure
  nom : string;
  pieceArmure : typePieceArmure;
  element : typeElement;
  valeurDefense, tauxEsquive : real;
  compteur : integer;
begin
  compteur := 0;
  assignFile(fichierArmures,fichier);
  reset(fichierArmures);
  // Lecture de la premiere ligne du fichier qui sert d'entête
  readln(fichierArmures);
  // On lit chaque ligne jusqu'à la fin du fichier
  repeat
        readln(fichierArmures,ligne);
        // On transforme la ligne en une liste
        listeLigne := ligne.Split(';'); //ligne.Split(';'); //splitString(ligne,';');

        // On met chaque valeur dans une variable
        nom := listeLigne[0];
        pieceArmure := trouverPieceArmure(listeLigne[1]);
        element := trouverElement(listeLigne[2]);
        valeurDefense := strToFloat(listeLigne[3]);
        tauxEsquive := strToFloat(listeLigne[4]);

        // On modifie chaque armure
        modifierArmure(armuresDisponibles[compteur],nom,pieceArmure,element,valeurDefense,tauxEsquive);

        compteur := compteur + 1;
  until(EOF(fichierArmures)) ;
end;

// Procédure qui remplie la variable des armes disponibles depuis le fichier csv
procedure remplirArmesDisponibles(fichier : string);
var
  fichierArmes : TextFile;
  ligne : string;
  listeLigne : array of string;
  // Stats de chaque armure
  nom : string;
  arme : typePieceArme;
  element : typeElement;
  emoussementDepart,emoussement : integer;
  valeurAttaque : real;
  compteur : integer;
begin
  compteur := 0;
  assignFile(fichierArmes,fichier);
  reset(fichierArmes);
  // Lecture de la premiere ligne du fichier qui sert d'entête
  readln(fichierArmes);
  // On lit chaque ligne jusqu'à la fin du fichier
  repeat
        readln(fichierArmes,ligne);
        // On transforme la ligne en une liste
        listeLigne := ligne.Split(';'); //ligne.Split(';'); //splitString(ligne,';');

        // On met chaque valeur dans une variable
        nom := listeLigne[0];
        arme := trouverArme(listeLigne[1]);
        element := trouverElement(listeLigne[2]);
        emoussementDepart := strToInt(listeLigne[3]);
        emoussement := strToInt(listeLigne[4]);
        valeurAttaque := strToFloat(listeLigne[5]);

        // On modifie chaque armure
        modifierArme(armesDisponibles[compteur],nom,arme,element,emoussementDepart,emoussement,valeurAttaque);

        compteur := compteur + 1;
  until(EOF(fichierArmes)) ;
end;






// --------------------------------------------- FONCTIONS DE RENVOI -----------------------------------------
// Fonction qui renvoie l'armure portée par le joueur en fonction de la piece demandée
function getArmureJoueur(armure :typePieceArmure) : typeArmure;
begin
  if (armure = casque) then getArmureJoueur := getjoueur.armurePortee[0]
  else if (armure = torse ) then getArmureJoueur := getjoueur.armurePortee[1]
  else if (armure= jambieres ) then getArmureJoueur := getjoueur.armurePortee[2]
  else if (armure = bottes) then getArmureJoueur := getjoueur.armurePortee[3]
  else if (armure = gants) then getArmureJoueur := getjoueur.armurePortee[4];
end;


// Fonction qui renvoie la liste des pièces d'armures possédées par le joueur en fonction de la pièce demandée
function getPiecesPossedees(piece : typePieceArmure) : arrayPieceArmure;
var nbPieces, i : integer;
begin
  nbPieces := 0;
  for i:=0 to length(getjoueur.armuresPossedees) - 1 do
     begin
         if getjoueur.armuresPossedees[i].pieceArmure = piece then
         begin
              getPiecesPossedees[nbPieces] := getjoueur.armuresPossedees[i];
              nbPieces := nbPieces + 1;
         end;
     end;
end;

end.

