unit monsterHunterForge;

{$mode objfpc}{$H+}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils, monsterHunterForgeIHM;

procedure choixItemForge();




// =========================================================================== IMPLEMENTATION ===================================================================================
implementation
uses monsterHunterVille;

procedure forgeArmure();


procedure forgeArme();
begin

end;

// ------------------------------------------------- FORGE -----------------------------------------------
procedure forge(itemAAfficher : string);
begin
  // On affiche d'abord l'ihm de la forge autour
  forgeIHM();

  // On cherche à savoir si on doit s'occuper des armes ou des armures
  // Si on a choisit les armes
  if itemAAfficher = '1' then forgeArme();
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

