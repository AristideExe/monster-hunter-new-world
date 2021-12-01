unit monsterHunterForge;

{$mode objfpc}{$H+}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils,monsterHunterArmesEtArmures, monsterHunterForgeIHM;

procedure choixItemForge();
// Procédure qui appelle qui appelle soit la forge à armes soit celle à armures
procedure forge(itemAAfficher : string);




// =========================================================================== IMPLEMENTATION ===================================================================================
implementation
uses monsterHunterVille, monsterHunterJoueur;

// Procédure que l'on appelle si le joueur essaye de forger quelque chose qu'il ne peut pas forger
procedure nePeutPasForger(forgeDeRetour : string; craft : typeCraft);
begin
  nePeutPasForgerIHM(craft);
  forge(forgeDeRetour);
end;




// ------------------------------------------------- FORGE DES ARMURES-----------------------------------------------
// Fonction qui renvoit si le joueur peut crafter ou non une arme
function peutCrafterArmure(positionArmure : integer) : boolean;
var
  craft : typeCraft;
begin
  //// On récupère le craft en question
  craft := craftsArmuresDisponibles[positionArmure];
  //On suppose que le joueur peut crafter l'item de base
  peutCrafterArmure := true;
  // On teste pour chaque item si le joueur a assez de quantité de chaque
  // Je n'ai pas trouvé de moyen de le compacter ...
  if (getJoueur.itemsPossedes[craft.Item1] < craft.quantiteItem1) then peutCrafterArmure := false;
  if (craft.nombreItemsDeCraft >= 2) and (getJoueur.itemsPossedes[craft.Item2] < craft.quantiteItem2) then peutCrafterArmure := false;
  if (craft.nombreItemsDeCraft >= 3) and (getJoueur.itemsPossedes[craft.Item3] < craft.quantiteItem3) then peutCrafterArmure := false;
  if (craft.nombreItemsDeCraft >= 4) and (getJoueur.itemsPossedes[craft.Item4] < craft.quantiteItem4) then peutCrafterArmure := false;
  //if (craft.nombreItemsDeCraft >= 5) and (getJoueur.itemsPossedes[craft.Item5] < craft.quantiteItem5) then peutCrafterArme := false;
end;

// Procédure pour forger une arme et l'ajouter à l'inventaire
procedure forgerArmure(positionArmure : integer);
var
  craft : typeCraft;
begin
  // On récupère le craft de l'armure
  craft := craftsArmuresDisponibles[positionArmure];
  // On retire la bonne quantité d'item dans l'inventaire du joueur
  retirerItemJoueur(craft.item1,craft.quantiteItem1);
  if (craft.nombreItemsDeCraft >= 2) then retirerItemJoueur(craft.item2,craft.quantiteItem2);
  if (craft.nombreItemsDeCraft >= 3) then retirerItemJoueur(craft.item3,craft.quantiteItem3);
  if (craft.nombreItemsDeCraft >= 4) then retirerItemJoueur(craft.item4,craft.quantiteItem4);
  if (craft.nombreItemsDeCraft >= 5) then retirerItemJoueur(craft.item5,craft.quantiteItem5);
  // On ajoute l'arme dans l'inventaire du joueur
  donnerArmureJoueur(positionArmure,armuresDisponibles[positionArmure]);
  afficherMessageCraftIHM(armuresDisponibles[positionArmure].nom);
  readln;
  // On retourne à la forge
  forge(intToStr(ord(armuresDisponibles[positionArmure].pieceArmure) + 2));
end;

// Procédure pour la forge des armures
procedure forgeArmure(piece : typePieceArmure);
var
  i,j : integer;
  armure: typeArmure;
  armurePossedee : boolean;
  choix : string;
  choixIsInt : boolean;
  choixInt : integer;
  compteurArmure : integer;
  // Position de l'arme que le joueur choisit de crafter
  positionArmureChoisie : integer;
begin
  // AFFICHAGE DES CRAFTS
  // On affiche d'abord l'ihm de la forge
  forgeIHM();
  enteteForgeArmureIHM();

  // On initialise le compteur des armes possédées en commançant à 1 (car l'affichage commence à 1)
  compteurArmure := 1;
  for i:=0 to length(craftsArmuresDisponibles) -1 do
  begin
    // On récupère l'item auquel le craft fait référence
    armure := armuresDisponibles[i];
    // On vérifie si l'item est déjà dans l'inventaire ou non
    armurePossedee := false;
    for j:=0 to length(craftsArmuresDisponibles) -1 do
      if (getJoueur.armuresPossedees[j].nom = armure.nom) or (getJoueur.armuresPossedees[ord(piece)].nom = armure.nom) then armurePossedee := true;
    // Si le joueur ne possède pas l'arme et qu'elle correspond à la piece d'armure que l'on recherche alors on peut l'afficher après avoir vérifié si il peut le crafter ou pas
    if not (armurePossedee) and (armure.pieceArmure = piece) then
    begin
      afficherArmureForgeIHM(armure,peutCrafterArmure(i),compteurArmure);
      compteurArmure := compteurArmure +1;
    end
  end;
  // On récupère le choix de l'utilisateur qui peut être soit le choix d'une arme soit le choix pour retourner au menu de sélection
  readln(choix);


  // ACTIONS PAR RAPPORT AU CHOIX
  choixInt := 0;
  choixIsInt := TryStrToInt(choix,choixInt);
  // Si on veut retourner au choix de sélection
  if choix = '0' then choixItemForge()
  // Si on a choisit une arme
  else if choixIsInt and (choixInt>0) and (choixInt < compteurArmure) then
  begin
    // On essaye de trouver à quelle arme fait référence le choix en refaisant la même boucle qu'à l'affichage
    compteurArmure := 1;
    for i:=0 to length(craftsArmuresDisponibles) -1 do
    begin
      // On récupère l'item auquel le craft fait référence
      armure := armuresDisponibles[i];
      // On vérifie si l'item est déjà dans l'inventaire ou non
      armurePossedee := false;
      for j:=0 to length(craftsArmuresDisponibles) -1 do
        if (getJoueur.armuresPossedees[j].nom = armure.nom) or (getJoueur.armuresPossedees[ord(piece)].nom = armure.nom) then armurePossedee := true;
      // Si le joueur ne possède pas l'arme et qu'elle correspond à la piece d'armure que l'on recherche alors on peut l'afficher après avoir vérifié si il peut le crafter ou pas
      if not (armurePossedee) and (armure.pieceArmure = piece) then
      begin
        if choixInt = compteurArmure then positionArmureChoisie := i;
        compteurArmure := compteurArmure +1;
      end
    end;
    // On teste si le joueur peut crafter l'arme en question, si oui, on la craft, sinon on lui renvoit le message
    if peutCrafterArmure(positionArmureChoisie) then forgerArmure(positionArmureChoisie)
    else nePeutPasForger(intToStr(ord(piece) +2),craftsArmuresDisponibles[positionArmureChoisie]);


  end
  // Si l'utilisateur a mis un mauvais choix
  else forgeArmure(piece);
end;





// ------------------------------------------------- FORGE DES ARMES-----------------------------------------------
// Fonction qui renvoit si le joueur peut crafter ou non une arme
function peutCrafterArme(positionArme : integer) : boolean;
var
  craft : typeCraft;
begin
  // On récupère le craft en question
  craft := craftsArmesDisponibles[positionArme];
  // On suppose que le joueur peut crafter l'item de base
  peutCrafterArme := true;
  // On teste pour chaque item si le joueur a assez de quantité de chaque
  // Je n'ai pas trouvé de moyen de le compacter ...
  if (getJoueur.itemsPossedes[craft.Item1] < craft.quantiteItem1) then peutCrafterArme := false;
  if (craft.nombreItemsDeCraft >= 2) and (getJoueur.itemsPossedes[craft.Item2] < craft.quantiteItem2) then peutCrafterArme := false;
  if (craft.nombreItemsDeCraft >= 3) and (getJoueur.itemsPossedes[craft.Item3] < craft.quantiteItem3) then peutCrafterArme := false;
  if (craft.nombreItemsDeCraft >= 4) and (getJoueur.itemsPossedes[craft.Item4] < craft.quantiteItem4) then peutCrafterArme := false;
  //if (craft.nombreItemsDeCraft >= 5) and (getJoueur.itemsPossedes[craft.Item5] < craft.quantiteItem5) then peutCrafterArme := false;
end;

// Procédure pour forger une arme et l'ajouter à l'inventaire
procedure forgerArme(positionArme : integer);
var
  craft : typeCraft;
begin
  // On récupère le craft de l'arme
  craft := craftsArmesDisponibles[positionArme];
  // On retire la bonne quantité d'item dans l'inventaire du joueur
  retirerItem(craft.item1,craft.quantiteItem1);
  if (craft.nombreItemsDeCraft >= 2) then retirerItem(craft.item2,craft.quantiteItem2);
  if (craft.nombreItemsDeCraft >= 3) then retirerItem(craft.item3,craft.quantiteItem3);
  if (craft.nombreItemsDeCraft >= 4) then retirerItem(craft.item4,craft.quantiteItem4);
  if (craft.nombreItemsDeCraft >= 5) then retirerItem(craft.item5,craft.quantiteItem5);
  // On ajoute l'arme dans l'inventaire du joueur
  donnerArmeJoueur(positionArme,armesDisponibles[positionArme]);
  afficherMessageCraftIHM(armesDisponibles[positionArme].nom);
  readln;
  // On retourne à la forge
  forge('1');
end;

// Procédure pour la forge des armes
procedure forgeArme();
var
  i,j : integer;
  arme : typeArme;
  armePossedee : boolean;
  choix : string;
  choixIsInt : boolean;
  choixInt : integer;
  compteurArme : integer;
  // Position de l'arme que le joueur choisit de crafter
  positionArmeChoisie : integer;
begin
  // AFFICHAGE DES CRAFTS
  // On affiche d'abord l'ihm de la forge
  forgeIHM();
  enteteForgeArmeIHM();

  // On initialise le compteur des armes possédées en commançant à 1 (car l'affichage commence à 1)
  compteurArme := 1;
  for i:=0 to length(craftsArmesDisponibles) -1 do
  begin
    // On récupère l'item auquel le craft fait référence
    arme := armesDisponibles[i];
    // On vérifie si l'item est déjà dans l'inventaire ou non
    armePossedee := false;
    for j:=0 to length(craftsArmesDisponibles) -1 do
      if (getJoueur.armesPossedees[j].nom = arme.nom) or (getJoueur.armePortee.nom = arme.nom) then armePossedee := true;
    // Si le joueur ne possède pas l'arme alors on peut l'afficher après avoir vérifié si il peut le crafter ou pas
    if not armePossedee then
    begin
      afficherArmeForgeIHM(arme,peutCrafterArme(i),compteurArme, i = length(craftsArmesDisponibles) -1);
      compteurArme := compteurArme +1;
    end
  end;
  // On récupère le choix de l'utilisateur qui peut être soit le choix d'une arme soit le choix pour retourner au menu de sélection
  readln(choix);


  // ACTIONS PAR RAPPORT AU CHOIX
  choixInt := 0;
  choixIsInt := TryStrToInt(choix,choixInt);
  // Si on veut retourner au choix de sélection
  if choix = '0' then choixItemForge()
  // Si on a choisit une arme
  else if choixIsInt and (choixInt>0) and (choixInt < compteurArme) then
  begin
    // On essaye de trouver à quelle arme fait référence le choix en refaisant la même boucle qu'à l'affichage
    compteurArme := 1;
    for i:=0 to length(craftsArmesDisponibles) -1 do
    begin
      // On récupère l'item auquel le craft fait référence
      arme := armesDisponibles[i];
      // On vérifie si l'item est déjà dans l'inventaire ou non
      armePossedee := false;
      for j:=0 to length(craftsArmesDisponibles) -1 do
        if (getJoueur.armesPossedees[j].nom = arme.nom) or (getJoueur.armePortee.nom = arme.nom) then armePossedee := true;
      // Si le joueur ne possède pas l'arme alors on peut l'afficher après avoir vérifié si il peut le crafter ou pas
      if not armePossedee then
      begin
        if compteurArme = choixInt then positionArmeChoisie := i;
        compteurArme := compteurArme +1;
      end
    end;
    // On teste si le joueur peut crafter l'arme en question, si oui, on la craft, sinon on lui renvoit le message
    if peutCrafterArme(positionArmeChoisie) then forgerArme(positionArmeChoisie)
    else nePeutPasForger('1',craftsArmesDisponibles[positionArmeChoisie]);


  end
  // Si l'utilisateur a mis un mauvais choix
  else forgeArme();
end;



// ------------------------------------------------- FORGE -----------------------------------------------
// Procédure qui appelle qui appelle soit la forge à armes soit celle à armures
procedure forge(itemAAfficher : string);
begin

  // On cherche à savoir si on doit s'occuper des armes ou des armures
  // Si on a choisit les armes
  if itemAAfficher = '1' then forgeArme()
  // Si on a choisit les armures
  else forgeArmure(typePieceArmure(strToInt(itemAAfficher) - 2));
end;

// Choix de l'item à afficher
procedure choixItemForge();
var
  choix : string;
begin
  choix := choixItemForgeIHM();
  if choix = '0' then ville()
  else if (choix = '1') or (choix = '2') or (choix = '3') or (choix = '4') or (choix = '5') or (choix = '6') then forge(choix)
  else choixItemForge();
end;

end.

