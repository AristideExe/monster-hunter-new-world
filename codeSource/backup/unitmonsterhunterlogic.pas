unit unitMonsterHunterLogic;

{$mode objfpc}{$H+}

interface

// Menu principal
procedure menu();


// TYPES
type
  typeElement = (normal,feu,eau,glace,plante,tonerre,lumiere,tenebres,electrique);
  typePieceArmure = (casque,torse,jambieres,bottes,gants);
  typePieceArme = (epee,hache,couteau,marteau);
  typeArmure = record
             nom : string;
             pieceArmure : typePieceArmure;
             element : typeElement;
             durabilite : integer;
             valeurDefense : real;
             tauxEsquive : real;
  end;
  typeArme = record
             nom : string;
             arme : typePieceArme;
             element : typeElement;
             durabilite : integer;
             valeurAttaque : real;
  end;

  typePersonnage = record
             nom : string;
             taille : string;
             sexe : string;
             // 5 éléments d'armure : casque, torse, jambières, bottes, gants
             armurePortee : array [0..4] of typeArmure;
             armuresPossedees : array [0..99] of typeArmure;
             armePortee : typeArme;
             armesPossedees : array [0..24] of typeArme;
  end;



// VARIABLES PERSONNAGE
var
  joueur : typePersonnage;




// FONCTIONS POUR RETOURNER LE JOUEUR
function getJoueur() : typePersonnage;










implementation

uses
  Classes, SysUtils, unitmonsterhunterIHM;

// Affiche le message lorsque l'on quitte
procedure quitter();
begin
  //quitterIHM();
end;

// Procédure pour modifier les valeurs d'une armure plus facilement
procedure modifierArmure(var armure : typeArmure; nom : string; pieceArmure : typePieceArmure; element : typeElement; durabilite : integer; valeurDefense, tauxEsquive : real);
begin
  armure.nom := nom;
  armure.pieceArmure := pieceArmure;
  armure.element := element;
  armure.durabilite := durabilite;
  armure.valeurDefense := valeurDefense;
  armure.tauxEsquive := tauxEsquive;
end;

// Procédure pour modifier les valeurs d'une arme plus facilement
procedure modifierArme(var arme : typeArme; nom :string; typeArme : typePieceArme; element : typeElement; durabilite : integer; valeurAttaque : real);
begin
  arme.nom := nom;
  arme.arme := typeArme;
  arme.element := element;
  arme.durabilite := durabilite;
  arme.valeurAttaque := valeurAttaque;
end;

// -------------------------------- TOUTES LES PROCÉDURES DE LA VILLE --------------------------------

procedure choisirCombat();
begin
  explorationIHM();
end;



procedure cantine();
begin
end;

procedure marchand();
begin
end;

procedure forge();
begin
end;

procedure chambre();
begin
  chambreIHM();
end;

// Ville du lobby
procedure ville();
var
  choix: string;
begin
  choix := villeIHM();
  if (choix = '1') then
    chambre()
  else if (choix = '2') then
    forge()
  else if (choix = '3') then
    marchand()
  else if (choix = '4') then
    cantine()
  else if (choix = '5') then
    choisirCombat()
  else
    ville();
end;



// -------------------------------- TOUTES LES PROCÉDURES DE LANCEMENT DU JEU --------------------------------


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
  for i:=0 to length(joueur.armurePortee) do modifierArmure(joueur.armurePortee[i],'NULL',typePieceArmure(i),normal,-1,0,0);
  modifierArmure(joueur.armurePortee[1],'Plastron d''entrainement',typePieceArmure(1),normal,100,5,2);

  // Modification de l'inventaire d'armures pour qu'il soit vide
  for i:=0 to length(joueur.armuresPossedees)-1 do modifierArmure(joueur.armuresPossedees[i],'NULL',typePieceArmure(i mod 5),normal,-1,0,0);
  //test ajout armure au pif
  modifierArmure(joueur.armuresPossedees[32],'Armure de la mort qui tue',torse,normal,1500,25,12);

  // Initialisation de l'arme pour avoir une épée de base
  modifierArme(joueur.armePortee,'Epee d''entrainement',epee,normal,100,15);

  // Modification de l'inventaire d'armes pour qu'il soit vide
  for j:=0 to length(joueur.armesPossedees)-1 do modifierArme(joueur.armesPossedees[j],'NULL',typePieceArme(0),normal,-1,0);

  creationPersonnage();
end;







// Affiche les différentes sauvegardes
procedure choixSauvegarde();
begin
end;

// Affiche les crédits
procedure credits();
begin
  creditsIHM();
  menu();
end;



// Menu principal
procedure menu();
var
  choix: string;
begin
  choix := menuIHM();
  if (choix = '1') then initialisationPersonnage()
  else if (choix = '2') then choixSauvegarde()
  else if (choix = '3') then credits()
  else if (choix = '4') then quitter()
  else menu();
end;




// -------------------------------- TOUTES LES FONCTIONS DE GET --------------------------------

// Renvoie le joueur
function getJoueur() : typePersonnage;
begin
  getJoueur := joueur
end;



end.

