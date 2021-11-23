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

procedure forgeArme();
var
  i,j : integer;
  arme : typeArme;
  armePossedee : boolean;
begin
  // AFFICHAGE DES CRAFTS
  for i:=0 to length(craftsArmesDisponibles) -1 do
  begin
    // On récupère l'item auquel le craft fait référence
    arme := armesDisponibles[i];
    // On vérifie si l'item est déjà dans l'inventaire ou non
    armePossedee := false;
    for j:=0 to length(craftsArmesDisponibles) -1 do
      if (getJoueur.armesPossedees[j].nom = arme.nom) or (getJoueur.armePortee.nom = arme.nom) then armePossedee := true;
    // Si le joueur ne possède pas l'arme alors on peut l'afficher après avoir vérifié si il peut le crafter ou pas

    if not armePossedee then afficherArmeForgeIHM(arme,true);
  end;
  readln;
end;

// ------------------------------------------------- FORGE -----------------------------------------------
procedure forge(itemAAfficher : string);
begin
  // On affiche d'abord l'ihm de la forge autour
  forgeIHM();

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

