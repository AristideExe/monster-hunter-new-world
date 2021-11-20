unit monsterHunterArmesEtArmures;

{$mode objfpc}{$H+}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils, typInfo, strUtils;

// ------------------------------------------------- CONSTANTES ---------------------------------------------
const
  NOMBRE_ARMURES_JEU = 100;
  NOMBRE_ARMES_JEU = 25;


  // ------------------------------------------------- TYPES -----------------------------------------------
type
  typeElement = (normal,feu,eau,glace,plante,tonerre,lumiere,tenebres,electrique);
  typePieceArmure = (casque,torse,jambieres,bottes,gants);
  typePieceArme = (epee,hache,couteau,marteau);
  typeArmure = record
             nom : string;
             pieceArmure : typePieceArmure;
             element : typeElement;
             valeurDefense : real;
             tauxEsquive : real;
  end;
  typeArme = record
             nom : string;
             arme : typePieceArme;
             element : typeElement;
             emoussementDepart : integer;
             emoussement: integer;
             valeurAttaque : real;
  end;
  arrayPieceArmure = array [0..((NOMBRE_ARMURES_JEU div 5)-1)] of typeArmure;


  // ------------------------------------------------- VARIABLES ---------------------------------------------
var
  armuresDisponibles : array[0..NOMBRE_ARMURES_JEU-1] of typeArmure;
  armesDisponibles : array[0..NOMBRE_ARMES_JEU-1] of typeArme;


// ------------------------------------------------- FONCTIONS ---------------------------------------------
// Fonction qui renvoie l'armure portée par le joueur en fonction de la piece demandée
function getArmureJoueur(armure : typePieceArmure) : typeArmure;
// Fonction qui renvoie la liste des pièces d'armures possédées par le joueur en fonction de la pièce demandée
function getPiecesPossedees(piece : typePieceArmure) : arrayPieceArmure;
// Procédure qui remplie la variable des armures disponibles depuis le fichier csv
procedure remplirArmuresDisponibles(fichier : string);
// Procédure qui remplie la variable des armes disponibles depuis le fichier csv
procedure remplirArmesDisponibles(fichier : string);
// Procédure pour échanger deux armures
procedure echangerArmures(var armure1, armure2 : typeArmure);
// Procédure pour échanger deux armes
procedure echangerArmes(var arme1, arme2 : typeArme);
// Procédure pour modifier les valeurs d'une armure plus facilement
procedure modifierArmure(var armure : typeArmure; nom : string; pieceArmure : typePieceArmure; element : typeElement; valeurDefense, tauxEsquive : real);
// Procédure pour modifier les valeurs d'une arme plus facilement
procedure modifierArme(var arme : typeArme; nom :string; typeArme : typePieceArme; element : typeElement;emoussementDepart,emoussement : integer ; valeurAttaque : real);z



// =========================================================================== IMPLEMENTATION ===================================================================================
implementation
uses monsterHunterJoueur;





// ----------------------------------------- FONCTIONS DE RENVOIE D'ÉLÉMENTS D'ÉNUMÉRATIONS ---------------------------------------------
// Fonction qui renvoit l'élément de l'énumération typeArme qui correspond au str passé en paramètre
function trouverArme(arme : string) : typePieceArme;
var
  i : integer;
begin
  for i:=0 to ord(high(typePieceArme))-1 do
  begin
      if (arme = getEnumName(TypeInfo(typePieceArme),i)) then trouverArme := typePieceArme(i);
  end;
end;

// Fonction qui renvoit l'élément de l'énumération typePieceArme qui correspond au str passé en paramètre
function trouverPieceArmure(piece : string) : typePieceArmure;
var
  i : integer;
begin
  for i:=0 to ord(high(typePieceArmure))-1 do
  begin
      if (piece = getEnumName(TypeInfo(typePieceArmure),i)) then trouverPieceArmure := typePieceArmure(i);
  end;
end;

// Fonction qui renvoit l'élément de l'énumération typeElement qui correspond au str passé en paramètre
function trouverElement(element : string) : typeElement;
var
  i : integer;
begin
  for i:=0 to ord(high(typeElement))-1 do
  begin
      if (element = getEnumName(TypeInfo(typeElement),i)) then trouverElement := typeElement(i);
  end;
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




// ----------------------------- PROCÉDURES DE MODIFICATION D'ARMURES ET D'ARMES --------------------------------
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
        listeLigne := splitString(ligne,';');

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
        listeLigne := splitString(ligne,';');

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

