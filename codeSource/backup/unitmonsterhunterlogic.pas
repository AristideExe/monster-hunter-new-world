unit unitMonsterHunterLogic;

{$mode objfpc}{$H+}

interface

// Menu principal
procedure menu();


// TYPES
type
  typeElement = (normal,feu,eau,glace,plante,tonerre,lumiere,tenebres,electrique,roche,acier);
  typePieceArmure = (casque,torse,jambieres,bottes,gants);
  typeArmure = record
             nom : string;
             pieceArmure : typePieceArmure;
             element : typeElement;
             durabilite : integer;
             valeurDefense : real;
             tauxEsquive : real;
  end;
  typePersonnage = record
             nom : string;
             taille : string;
             sexe : string;
  end;



// VARIABLES PERSONNAGE
var
  joueur : typePersonnage;




// FONCTIONS POUR RETOURNER LE JOUEUR
function getJoueur() : typePersonnage;










implementation

uses
  Classes, SysUtils, unitmonsterhunterhim;

// Affiche le message lorsque l'on quitte
procedure quitter();
begin
  quitterIHM();
end;




// -------------------------------- TOUTES LES PROCÉDURES DE LA VILLE --------------------------------

procedure choisirCombat();
begin
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




// Initialisation des stats du personnage à sa création
procedure initialisationPersonnage();
begin
     ville();
end;




// -------------------------------- TOUTES LES PROCÉDURES DE LANCEMENT DU JEU --------------------------------


// Menu de création de personnage
procedure creationPersonnage();
begin
  creationPersonnageIHM(joueur.nom, joueur.taille, joueur.sexe);
  initialisationPersonnage();
end;

// Affiche les différentes sauvegardes
procedure choixSauvegarde();
begin
end;

// Affiche les crédits
procedure credits();
begin
  creditsIHM();
  menuIHM();
end;



// Menu principal
procedure menu();
var
  choix: string;
begin
  choix := menuIHM();
  if (choix = '1') then creationPersonnage()
  else if (choix = '2') then choixSauvegarde()
  else if (choix = '3') then credits()
  else if (choix = '4') then quitter();
end;




// -------------------------------- TOUTES LES FONCTIONS DE GET --------------------------------

// Renvoie le joueur
function getJoueur() : typePersonnage;
begin
  getJoueur := joueur;
end;



end.

