unit monsterHunterChambre;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils, monsterHunterArmesEtArmures, monsterHunterChambreIHM;

procedure chambre();
// Permet d'afficher le menu pour sélectionner si on veut accéder aux casques, aux plastrons, aux jambieres, aux bottes ou aux gants
procedure selectionArmureArmoire();



// =========================================================================== IMPLEMENTATION ===================================================================================
implementation
uses monsterHunterVille, monsterHunterJoueur;




// ----------------------------------------------------- DORMIR ------------------------------------------------------
procedure dormir();
begin
  dormirIHM();
  reinitialiserVieJoueur();
  readln;
  chambre();
end;


// ----------------------------------------------------- OBJETS ------------------------------------------------------
procedure objets();
var
  choix : string;
begin
  choix := objetsIHM();
  if choix = '0' then chambre()
  else objets;
end;

// ----------------------------------------------------- ARMOIRE ------------------------------------------------------
procedure armoire(pieceArmure : typePieceArmure);
var
  i : integer;
  compteurArmure : integer;
  choix : string;
  choixIsInt : boolean;
  choixInt : integer;
  // Position de l'arme que le joueur choisit de porter
  positionArmureChoisie : integer;
begin
  armoireIHM();
  enteteArmoireIHM();

  // AFFICHAGE DES ARMURES POSSEDEES
  compteurArmure := 1;
  // On affiche toutes les armures qui sont la bonne pièce sauf celles dont le nom est 'NULL'
  for i:=0 to length(getJoueur.armuresPossedees) - 1 do
  begin
    if (getJoueur.armuresPossedees[i].nom <> 'NULL') and (getJoueur.armuresPossedees[i].pieceArmure = pieceArmure) then
    begin
      afficherArmureIHM(getJoueur.armuresPossedees[i], compteurArmure);
      compteurArmure := compteurArmure + 1;
    end;
  end;

  // Si le joueur ne possède aucune armure
  if compteurArmure = 1 then
  begin
    aucuneArmurePossedeeIHM();
    chambre();
  end
  // Si le joueur possède au moins une armure
  else
  begin

    // Ecriture du choix par le joueur
    readln(choix);

    // ACTIONS PAR RAPPORT AU CHOIX
    choixInt := 0;
    choixIsInt := TryStrToInt(choix,choixInt);
    // Si on veut retourner au menu de sélection
    if choix = '0' then selectionArmureArmoire()
    // Si on a choisit une armure
    else if choixIsInt and (choixInt>0) and (choixInt < compteurArmure) then
    begin
      // On essaye de trouver à quelle arme fait référence le choix en refaisant la même boucle qu'à l'affichage
      compteurArmure := 1;
      for i:=0 to length(getJoueur.armuresPossedees) - 1 do
      begin
        if (getJoueur.armuresPossedees[i].nom <> 'NULL') and (getJoueur.armuresPossedees[i].pieceArmure = pieceArmure) then
        begin
          if compteurArmure = choixInt then positionArmureChoisie := i;
          compteurArmure := compteurArmure + 1;
        end;
      end;

      // On échange l'arme que le joueur a choisi avec l'arme qu'il porte
      echangerArmures(joueur.armurePortee[ord(pieceArmure)],joueur.armuresPossedees[positionArmureChoisie]);
      chambre();
    end
    else armoire(pieceArmure);
  end;
end;

// Permet d'afficher le menu pour sélectionner si on veut accéder aux casques, aux plastrons, aux jambieres, aux bottes ou aux gants
procedure selectionArmureArmoire();
var choix: string;
begin
  choix := selectionArmureArmoireIHM();
  // Si le joueur souhaite revenir à la chambre
  if choix = '0' then chambre()
  // Si le joueur a choisit une pièce d'armure
  else if (choix = '1') or (choix = '2') or (choix = '3') or (choix = '4') or (choix = '5') then armoire(typePieceArmure(strToInt(choix) - 1))
  // Si le joueur veut voir ses objets
  else if choix = '6' then objets()
  // Si le joueur a fait un mauvais choix
  else selectionArmureArmoire();
end;

// ----------------------------------------------------- MALLE --------------------------------------------------------
procedure malle();
var
  i : integer;
  compteurArme : integer;
  choix : string;
  choixIsInt : boolean;
  choixInt : integer;
  // Position de l'arme que le joueur choisit de porter
  positionArmeChoisie : integer;
begin
  malleIHM();
  enteteMalleIHM();



  // AFFICHAGE DES ARMES POSSEDEES
  compteurArme := 1;
  // On affiche toutes les armes sauf celles dont le nom est 'NULL'
  for i:=0 to length(getJoueur.armesPossedees) - 1 do
  begin
    if getJoueur.armesPossedees[i].nom <> 'NULL' then
    begin
      afficherArmeIHM(getJoueur.armesPossedees[i], compteurArme);
      compteurArme := compteurArme + 1;
    end;
  end;

  // Si le joueur ne possède aucune arme
  if compteurArme = 1 then
  begin
    aucuneArmePossedeeIHM();
    chambre();
  end
  // Si le joueur possède au moins une arme
  else
  begin

    // Ecriture du choix par le joueur
    readln(choix);

    // ACTIONS PAR RAPPORT AU CHOIX
    choixInt := 0;
    choixIsInt := TryStrToInt(choix,choixInt);
    // Si on veut retourner à la chambre
    if choix = '0' then chambre()
    // Si on a choisit une arme
    else if choixIsInt and (choixInt>0) and (choixInt < compteurArme) then
    begin
      // On essaye de trouver à quelle arme fait référence le choix en refaisant la même boucle qu'à l'affichage
      compteurArme := 1;
      for i:=0 to length(getJoueur.armesPossedees) - 1 do
      begin
        if getJoueur.armesPossedees[i].nom <> 'NULL' then
        begin
          if compteurArme = choixInt then positionArmeChoisie := i;
          compteurArme := compteurArme + 1;
        end;
      end;

      // On échange l'arme que le joueur a choisi avec l'arme qu'il porte
      echangerArmes(joueur.armePortee,joueur.armesPossedees[positionArmeChoisie]);
      chambre();
    end
    else malle();
  end;
end;

// ----------------------------------------------------- CHAMBRE ------------------------------------------------------
// Procédure qui affiche tous les objets de l'inventaire et qui permet de retourner à la ville ou d'aller au menu de changement d'armure
procedure chambre();
var
  i : integer;
  choix : string;
begin
  choix := chambreIHM();
  if choix = '0' then ville()
  else if choix = '1' then malle()
  else if choix = '2' then selectionArmureArmoire()
  else if choix = '3' then dormir()
  else chambre();
end;

end.

