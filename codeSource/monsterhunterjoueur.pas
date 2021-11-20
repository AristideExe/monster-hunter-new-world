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
    // 5 éléments d'armure : casque, torse, jambières, bottes, gants
    armurePortee : array [0..4] of typeArmure;
    armuresPossedees : array [0..NOMBRE_ARMURES_JEU-1] of typeArmure;
    armePortee : typeArme;
    armesPossedees : array [0..NOMBRE_ARMES_JEU-1] of typeArme;
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
uses monsterHunterIHM;


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
  i,j : integer;
begin
  // Initialisatin de l'armure portée avec un torse de départ
  for i:=0 to length(joueur.armurePortee) do modifierArmure(joueur.armurePortee[i],'NULL',typePieceArmure(i),normal,0,0);
  modifierArmure(joueur.armurePortee[1],'Plastron d''entrainement',typePieceArmure(1),normal,5,2);

  // Modification de l'inventaire d'armures pour qu'il soit vide
  for i:=0 to length(joueur.armuresPossedees)-1 do modifierArmure(joueur.armuresPossedees[i],'NULL',typePieceArmure(i mod 5),normal,0,0);
  //test ajout armures au pif
  for i:=0 to 99 do modifierArmure(joueur.armuresPossedees[i],'Armure' + IntToStr(random(500)),typePieceArmure(i mod 5),normal,random(50),random(30));

  // Initialisation de l'arme pour avoir une épée de base
  modifierArme(joueur.armePortee,'Epee d''entrainement',epee,normal,100,100,15);


  // Modification de l'inventaire d'armes pour qu'il soit vide
  for j:=0 to length(joueur.armesPossedees)-1 do modifierArme(joueur.armesPossedees[j],'NULL',typePieceArme(0),normal,-1,-1,0);
  //test ajout armes au pif
  for i:=0 to 24 do modifierArme(joueur.armesPossedees[i],'Arme'+IntToStr(random(500)),epee,normal,100,100,random(70));

  creationPersonnage();
end;



// --------------------------------------------- FONCTIONS DE RENVOI -----------------------------------------
// Renvoie le joueur
function getJoueur() : typePersonnage;
begin
  getJoueur := joueur
end;

end.

