unit monsterHunterCombat;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils, monsterHunterCombatIHM, monsterHunterVille, monsterHunterGestionCombatMonstre, monsterHunterGestionCombatJoueur, monsterHunterJoueur;

procedure choisirCombat();

//-------------------------------------------------------Fonctions/Procedures-------------------------------------------------------

//Procedure qui permet de lancer/actualiser la fenètre de combat en fonction de la difficulté
procedure combatDifficulte (difficulte:integer);

//Procedure qui execute l'action fuir/attaquer ou ouvrir l'inventaire
procedure choixCombatJoueur(choix:string; difficulte: integer);

// =========================================================================== IMPLEMENTATION ===================================================================================
implementation
// ------------------------------------------ COMBAT ------------------------------------------

//Procedure qui execute l'action fuir/attaquer ou ouvrir l'inventaire
procedure choixCombatJoueur(choix:string; difficulte: integer);
begin
  if choix = '1' then
  begin
    degatsCombatMonstre(round(getJoueur().armePortee.valeurAttaque)); //On inflige des dégats équivalents a l'attaque de l'arme

    if getMonstreCombat.vie <> 0 then
       combatDifficulte(difficulte)

    else
      begin
        lootMonstreMortIHM(lootMortMonstre);
        //On retourne en ville
       ville();
      end;
  end

  else combatDifficulte(difficulte);

end;

//Procedure qui permet de lancer/actualiser la fenètre de combat en fonction de la difficulté
procedure combatDifficulte (difficulte:integer);
begin
  if difficulte = 1 then choixCombatJoueur(Difficulte1IHM(),difficulte)         //Difficulté1
  else if difficulte = 2 then choixCombatJoueur(Difficulte2IHM(),difficulte)    //Difficulté2
  else if difficulte = 3 then choixCombatJoueur(Difficulte3IHM(),difficulte)    //Difficulté3
  else if difficulte = 4 then choixCombatJoueur(Difficulte4IHM(),difficulte)    //Difficulté4

end;

// ------------------------------------------ CHOISIR COMBAT ---------------------------------------------

//Permet de choisir la difficulté
procedure choisirCombat();
var
  choix: string;

begin
  choix := menuChoixCombatIHM();

  if (choix = '1') then
  begin
    initialisationCombatMonstre(1);
    combatDifficulte(1);
  end

  else if (choix = '2') then
  begin
    initialisationCombatMonstre(2);
    combatDifficulte(2);
  end

  else if (choix = '3') then
  begin
    initialisationCombatMonstre(3);
    combatDifficulte(3);
  end


  else if (choix = '4') then
  begin
    initialisationCombatMonstre(4);
    combatDifficulte(4);
  end

  else if (choix = '0') then ville()             //Renvoie dans la ville
  else choisirCombat();

end;

end.
