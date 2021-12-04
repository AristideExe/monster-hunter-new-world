unit monsterHunterCombat;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils, monsterHunterCombatIHM, monsterHunterVille, monsterHunterGestionCombatMonstre, monsterHunterGestionCombatJoueur, monsterHunterJoueur, GestionEcran;

procedure choisirCombat();

//-------------------------------------------------------Fonctions/Procedures-------------------------------------------------------

//Procedure qui permet de lancer/actualiser la fenètre de combat en fonction de la difficulté
procedure combatDifficulte (difficulte:integer);

//Procedure qui execute l'action fuir/attaquer ou ouvrir l'inventaire
procedure choixCombatJoueur(choix:string);

//Procedure des attaques
procedure attaquantCombat(attaquant : integer);

//Procedure qui refais un choix
procedure choixActionJoueur ();

// =========================================================================== IMPLEMENTATION ===================================================================================
implementation
// ------------------------------------------ COMBAT ------------------------------------------

//Procedure de check de la mort
procedure checkMortCombat();
begin
     if ((getMonstreCombat.vie <> 0) and (getJoueur.vie <> 0)) then
     //On réattaque
     choixActionJoueur()

     else
     //On regarde si le monstre est mort
     estMortMonstre();
     estMortJoueur();
end;

//Procedure des attaques
procedure attaquantCombat(attaquant : integer);
var
  degats : integer;
begin

  //------------------------------ Joueur attaque ------------------------------
  if attaquant = 1 then
  begin

    //On stoque la valeur d'attaque dans une variable
    degats := round(getJoueur().armePortee.valeurAttaque * calculEmoussementArmeJoueur);

    //On inflige les dégats au monstre
    degatsCombatMonstre(degats); //On inflige des dégats équivalents a l'attaque de l'arme
    afficherEmoussementIHM();
    afficherStatsMonstreIHM();
  end

  //------------------------------ Monstre attaque ------------------------------
  else
  begin
    //On calcule les dégats du monstre sur le joueur
    degats := calculDmgJoueur();

    //Si des dégats sont fait, alors on les lui fait subir
    if degats > 0 then
    begin

      //On inflige les dégats au joueur
      degatsCombatJoueur(degats);
      afficherStatsJoueurIHM();
    end;

  end;

  //On attends 0.8 sec
  attendre(600);

end;

//Détermine qui commence a attaquer et lance l'attaque
procedure choixAttaquantCombat();
begin

    //Si le joueur est plus rapide il commence a attaquer
    if ((getJoueur().vitesse + getJoueur().vitesse) >= getMonstreCombat().vitesse) then
    begin

      //Le joueur attaque
      attaquantCombat(1);

      //On vérifie que le monstre n'est pas mort
      if getMonstreCombat().vie <> 0 then
      begin

        //Le monstre attaque
        attaquantCombat(2);

      end;

    end

    //Sinon le monstre commence
    else
    begin

      //Le monstre attaque
      attaquantCombat(2);

      //On vérifie que le monstre n'est pas mort
      if getJoueur().vie <> 0 then
      begin

        //Le joueur attaque
        attaquantCombat(1);

      end;

    end;

    //On check si il y a des morts
    checkMortCombat();
end;

//Test Fuite possible
procedure testFuiteCombat();
begin
    if (getJoueur.argent >= 100) then
    begin
      fuiteJoueur();
      fuiteDuCombatIHM();
      ville();
    end

    else
    begin
      fuiteImpossibleIHM();
      interfaceCombatIHM();
      choixActionJoueur();
    end;
end;

//Procédure qui fait le choix de l'item dans l'inventaire
procedure choixInventaireCombat (choix : string);
begin

    if ((choix = '1') and (getJoueur().objetsPossedes[0] > 0)) then
    begin
         utilisationBombeJoueur(); //Utiliser une bombe puis executer le code suivant
         interfaceCombatIHM();

         //On vérifie que le monstre n'est pas mort
         if getMonstreCombat().vie <> 0 then
         begin

              //Le monstre attaque
              attaquantCombat(2);

         end;

         checkMortCombat();

    end

    //On utilise une potion de soin
    else if (choix = '2') and (getJoueur().objetsPossedes[1] > 0) then
    begin
        utilisationPotionSoin();
        interfaceCombatIHM();

        //Le monstre attaque
        attaquantCombat(2);

    end

    //On utilise la pierre ponce
    else if ((choix = '3') and (getJoueur().objetsPossedes[2] > 0)) then
    begin
         utilisationPierrePonce();
         interfaceCombatIHM();

         //Le monstre attaque
         attaquantCombat(2);
    end

    //On retourne au combat
    else if choix = '0' then interfaceCombatIHM()

    //L'entree est mauvaise donc on redemande
    else choixInventaireCombat(cadreChoixActionsIHM());

    //si une action est effectuée on relance le combat
    if (choix = '0') or (choix = '2') or (choix = '3') then
       choixActionJoueur();

end;

//Procedure qui execute l'action ouvrir l'inventaire
procedure inventaireCombat ();
begin

    affichageInventaireCombatIHM();
    choixInventaireCombat(cadreChoixActionsIHM());

end;

//Procedure qui execute l'action fuir/attaquer ou ouvrir l'inventaire
procedure choixCombatJoueur(choix:string);
begin
  if choix = '1' then
  begin
     choixAttaquantCombat();
  end

  else if choix = '2' then
  begin
     inventaireCombat();
  end

  else if choix = '3' then
  begin
     testFuiteCombat();
  end

  else choixActionJoueur();

end;

//Procedure qui refais un choix
procedure choixActionJoueur ();
begin
    choixCombatJoueur(cadreChoixActionsIHM);
end;

//Procedure qui permet de lancer la fenètre de combat en fonction de la difficulté
procedure combatDifficulte (difficulte:integer);
begin
  if difficulte = 1 then
  begin
    Difficulte1IHM();
    choixCombatJoueur(cadreChoixActionsIHM);         //Difficulté1
  end

  else if difficulte = 2 then
  begin
    Difficulte2IHM();
    choixCombatJoueur(cadreChoixActionsIHM);    //Difficulté2
  end

  else if difficulte = 3 then
  begin
    Difficulte3IHM();
    choixCombatJoueur(cadreChoixActionsIHM);    //Difficulté3
  end

  else if difficulte = 4 then
  begin
    Difficulte4IHM();
    choixCombatJoueur(cadreChoixActionsIHM);    //Difficulté4
  end;

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
