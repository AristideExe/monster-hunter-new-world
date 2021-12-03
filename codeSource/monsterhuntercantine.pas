unit monsterHunterCantine;

{$mode objfpc}{$H+}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils;

type
  typeNourriture = record
    nom : string;
    prixAchat : integer;
    bonusVie : integer;
    bonusVitesse : integer;
  end;

const
  NOMBRE_NOURRITURES_JEU = 3;

var
  nourrituresDisponibles : array [0..NOMBRE_NOURRITURES_JEU-1] of typeNourriture;

procedure cantine();
// Procédure qui remplie la variable des nourritures disponibles depuis le fichier csv
procedure remplirNourrituresDisponibles(fichier : string);




// =========================================================================== IMPLEMENTATION ===================================================================================
implementation
uses monsterHunterCantineIHM, monsterHunterVille, monsterHunterJoueur;

// ------------------------------------------------- CANTINE -----------------------------------------------
// Affichage de la nourriture possédées dans la cantine
procedure cantine();
var
  choix : string;
  compteurNourriture : integer;
  nourriture : typeNourriture;
  i : integer;
begin
  cantineIHM();
  enteteCantineIHM();

  // On initialise le compteur des nourritures possédées en commançant à 1 (car l'affichage commence à 1)
  compteurNourriture := 1;
  for i:=0 to length(nourrituresDisponibles) -1 do
  begin
    // Si le joueur possède au moins un exemplaire
    if (getJoueur.nourrituresPossedees[i] > 0) then
    begin
      afficherNourritureCantineIHM(nourrituresDisponibles[i],i,compteurNourriture);
      compteurNourriture := compteurNourriture +1;
    end
  end;
  // On récupère le choix de l'utilisateur qui peut être soit le choix d'une arme soit le choix pour retourner au menu de sélection
  readln(choix);


  // ACTIONS PAR RAPPORT AU CHOIX
  //choixInt := 0;
  //choixIsInt := TryStrToInt(choix,choixInt);
  // Si on veut retourner au choix de sélection
  if choix = '0' then ville()
  //// Si on a choisit une arme
  //else if choixIsInt and (choixInt>0) and (choixInt < compteurArme) then
  //begin
  //  // On essaye de trouver à quelle arme fait référence le choix en refaisant la même boucle qu'à l'affichage
  //  compteurArme := 1;
  //  for i:=0 to length(craftsArmesDisponibles) -1 do
  //  begin
  //    // On récupère l'item auquel le craft fait référence
  //    arme := armesDisponibles[i];
  //    // On vérifie si l'item est déjà dans l'inventaire ou non
  //    armePossedee := false;
  //    for j:=0 to length(craftsArmesDisponibles) -1 do
  //      if (getJoueur.armesPossedees[j].nom = arme.nom) or (getJoueur.armePortee.nom = arme.nom) then armePossedee := true;
  //    // Si le joueur ne possède pas l'arme alors on peut l'afficher après avoir vérifié si il peut le crafter ou pas
  //    if not armePossedee then
  //    begin
  //      if compteurArme = choixInt then positionArmeChoisie := i;
  //      compteurArme := compteurArme +1;
  //    end
  //  end;
  //  // On teste si le joueur peut crafter l'arme en question, si oui, on la craft, sinon on lui renvoit le message
  //  if peutCrafterArme(positionArmeChoisie) then forgerArme(positionArmeChoisie)
  //  else nePeutPasForger('1',craftsArmesDisponibles[positionArmeChoisie]);


  //end
  // Si l'utilisateur a mis un mauvais choix
  else cantine();
end;

// Procédure qui remplie la variable des nourritures disponibles depuis le fichier csv
procedure remplirNourrituresDisponibles(fichier : string);
var
  fichierNourriture : TextFile;
  ligne : string;
  listeLigne : array of string;
  compteur : integer;
begin
  assignFile(fichierNourriture, fichier);
  reset(fichierNourriture);
  // Lecture de la première ligne du fichier qui sert d'entête
  readln(fichierNourriture);
  compteur := 0;
  // On lit chaque ligne jusqu'à la fin du fichier
  repeat
        readln(fichierNourriture,ligne);
        // On transforme la ligne en une liste
        listeLigne:= ligne.Split(';'); //ligne.Split(';'); //splitString(ligne,';');

        // On remplie la liste des crafts disponibles avec tous les champs du csv
        nourrituresDisponibles[compteur].nom := listeLigne[0];
        nourrituresDisponibles[compteur].prixAchat := strToInt(listeLigne[1]);
        nourrituresDisponibles[compteur].bonusVie := strToInt(listeLigne[2]);
        nourrituresDisponibles[compteur].bonusVitesse := strToInt(listeLigne[3]);
        compteur := compteur +1;
  until EOF(fichierNourriture);
end;

end.

