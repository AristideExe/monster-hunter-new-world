unit monsterHunterMenu;

{$mode objfpc}{$H+}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils,monsterHunterIHM,monsterHunterJoueur, monsterHunterArmesEtArmures;


// ------------------------------------------------- PROCEDURES ---------------------------------------------
// Initialisation du jeu au lancement
procedure initialisationJeu();
procedure menu();


// =========================================================================== IMPLEMENTATION ===================================================================================
implementation




// Affiche le message lorsque l'on quitte
procedure quitter();
begin
  //quitterIHM();
end;


// Affiche les crédits
procedure credits();
begin
  creditsIHM();
  menu();
end;


// Affiche les différentes sauvegardes
procedure choixSauvegarde();
begin
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



// Initialisation du jeu (remplissage des variables avec les données)
procedure initialisationJeu();
begin
  remplirArmuresDisponibles('nomsStatsObjets/armures.csv');
  remplirArmesDisponibles('nomsStatsObjets/armes.csv');
  menu();
end;



end.

