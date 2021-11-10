unit unitMonsterHunterLogic;

{$mode objfpc}{$H+}

interface

// Menu principal
procedure menu();

var
  nomPersonnage: string;
  taillePersonnage: string;
  sexePersonnage: string;

// Renvoie le nom du personnage
function getNomPersonnage() : string;










implementation

uses
  Classes, SysUtils, unitmonsterhunterhim, GestionEcran;

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
  creationPersonnageIHM(nomPersonnage, taillePersonnage, sexePersonnage);
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
  if (choix = '1') then
    creationPersonnage()
  else if (choix = '2') then
    choixSauvegarde()
  else if (choix = '3') then
    credits()
  else
    quitter();
end;




// -------------------------------- TOUTES LES FONCTIONS DE GET --------------------------------

// Renvoie le nom du personnage
function getNomPersonnage() : string;
begin
  getNomPersonnage := nomPersonnage;
end;

// Renvoie la taille du personnage
function getTaillePersonnage() : string;
begin
  getTaillePersonnage := taillePersonnage;
end;

// Renvoie le sexe du personnage
function getSexePersonnage() : string;
begin
  getSexePersonnage := sexePersonnage;
end;

end.

