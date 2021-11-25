unit monsterHunterChambre;

{$mode objfpc}{$H+}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils, monsterHunterIHM, monsterHunterArmesEtArmures, monsterHunterChambreIHM;

procedure chambre();



// =========================================================================== IMPLEMENTATION ===================================================================================
implementation
uses monsterHunterVille, monsterHunterJoueur;

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
  // AFFICHAGE DES ARMES POSSEDEES
  compteurArme := 1;
  // On affiche toutes les armes sauf celles dont le nom est 'NULL'
  for i:=0 to length(getJoueur.armesPossedees) - 1 do
  begin
    if getJoueur.armesPossedees[i].nom <> 'NULL' then
    begin
      afficherArmeIHM(getJoueur.armesPossedees[i], compteurArme, i = length(getJoueur.armesPossedees) -1);
      compteurArme := compteurArme + 1;
    end;
  end;

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

// ----------------------------------------------------- CHAMBRE ------------------------------------------------------
// Procédure qui affiche tous les objets de l'inventaire et qui permet de retourner à la ville ou d'aller au menu de changement d'armure
procedure chambre();
var
  i : integer;
  choix : string;
begin
  chambreIHM();
  // On affiche les armures si le joueur possède l'armure
  for i:=0 to 4 do afficherArmureChambreIHM(getJoueur.armurePortee[i],i);
  // On affiche l'arme du joueur
  afficherArmeChambreIHM(getJoueur.armePortee);


  readln(choix);
  if choix = '0' then ville()
  else if choix = '1' then malle()
  else chambre();
end;

end.

