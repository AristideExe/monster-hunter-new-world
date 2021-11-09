unit unitMonsterHunterLogic;

{$mode objfpc}{$H+}

interface

// Menu principal
procedure menu();

var
     nomPersonnage : string;
     taillePersonnage : string;
     sexePersonnage : string;


implementation
uses
  Classes, SysUtils,unitmonsterhunterhim,GestionEcran;

// Menu de création de personnage
procedure creationPersonnage();
begin
     creationPersonnageIHM(nomPersonnage, taillePersonnage, sexePersonnage);
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


// Affiche le message lorsque l'on quitte
procedure quitter();
begin
     quitterIHM();
end;



// Menu principal
procedure menu();
var
     choix : string;
begin
     choix := menuIHM();
     if (choix = '1') then creationPersonnage()
     else if (choix = '2') then choixSauvegarde()
     else if (choix = '3') then credits()
     else quitter();
end;
end.

