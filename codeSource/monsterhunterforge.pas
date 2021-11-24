unit monsterHunterForge;

{$mode objfpc}{$H+}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils,monsterHunterArmesEtArmures, monsterHunterForgeIHM;

procedure choixItemForge();




// =========================================================================== IMPLEMENTATION ===================================================================================
implementation
uses monsterHunterVille, monsterHunterJoueur;

procedure forgeArmure();
begin

end;

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
  if (craft.nombreItemsDeCraft >= 5) and (getJoueur.itemsPossedes[craft.Item5] < craft.quantiteItem5) then peutCrafterArme := false;
end;


procedure forgerArme(craft : typeCraft);
begin

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
  // L'arme que le joueur choisit de crafter
  armeChoisie : typeArme;
const
  NOMBRE_COLONNES_AFFICHAGE = 2;
begin
  // AFFICHAGE DES CRAFTS
  // On affiche d'abord l'ihm de la forge autour
   forgeIHM();

  for i:=0 to length(craftsArmesDisponibles) -1 do
  begin
    // On récupère l'item auquel le craft fait référence
    arme := armesDisponibles[i];
    // On vérifie si l'item est déjà dans l'inventaire ou non
    armePossedee := false;
    compteurArme := 1;
    for j:=0 to length(craftsArmesDisponibles) -1 do
      if (getJoueur.armesPossedees[j].nom = arme.nom) or (getJoueur.armePortee.nom = arme.nom) then armePossedee := true;
    // Si le joueur ne possède pas l'arme alors on peut l'afficher après avoir vérifié si il peut le crafter ou pas
    if not armePossedee then
    begin
      afficherArmeForgeIHM(arme,peutCrafterArme(i),i mod NOMBRE_COLONNES_AFFICHAGE,i div NOMBRE_COLONNES_AFFICHAGE);
      compteurArme := compteurArme +1;
    end
  end;
  readln(choix);


  // ACTIONS PAR RAPPORT AU CHOIX
  //choixInt := 0;
  //choixIsInt := TryStrToInt(choix,choixInt);
  //// Si on veut retourner au choix de sélection
  //if choix = '0' then choixItemForge()
  //// Si on a choisit une armure
  //else if choixIsInt and (choixInt>0) and (choixInt <= compteurArme) then
  //begin
  //  // On essaye de trouver à quelle arme fait référence le choix
  //  armePossedee := false;
  //  compteurArme := 0;
  //  for i:=0 to length(craftsArmesDisponibles) -1 do
  //  begin
  //    for j:=0 to length(craftsArmesDisponibles) -1 do
  //      if (getJoueur.armesPossedees[j].nom = arme.nom) or (getJoueur.armePortee.nom = arme.nom) then armePossedee := true;
  //    // Si le joueur ne possède pas l'arme alors on incrémente le compteur
  //    if not armePossedee then compteurArme := compteurArme +1;
  //    if choixInt = compteurArme then armeChoisie := armesDisponibles[i];
  //  end;
  //  write(armeChoisie.nom);
  //  readln;

  end
  else forgeArme();


end;

// ------------------------------------------------- FORGE -----------------------------------------------
procedure forge(itemAAfficher : string);
begin

  // On cherche à savoir si on doit s'occuper des armes ou des armures
  // Si on a choisit les armes
  if itemAAfficher = '1' then forgeArme()
  // Si on a choisit les armures
  else forgeArmure();
end;

// Choix de l'iterm à afficher
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

