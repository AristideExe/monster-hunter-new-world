unit monsterHunterMarchand;

{$mode objfpc}{$H+}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils, monsterHunterMarchandIHM, monsterHunterArmesEtArmures, monsterHunterJoueur, monsterHunterCantine;

procedure marchand();




// =========================================================================== IMPLEMENTATION ===================================================================================
implementation
uses monsterHunterVille;

// -------------------------------------------------- ACHAT OBJETS --------------------------------------------------
procedure achatObjets();
var
  choix : string;
  quantiteIsInt : boolean;
  quantiteInt : integer;
  i : integer;
const
  PRIX_BOMBE = 30;
  PRIX_POTION = 20;
  PRIX_PIERRE = 50;
begin

  choix := achatObjetsIHM();

  if choix = '0' then marchand()
  // Si on veut acheter des bombes
  else if choix = '1' then
  begin
       quantiteIsInt := TryStrToInt(choisirQuantiteIHM(),quantiteInt);
       while not quantiteIsInt do quantiteIsInt := TryStrToInt(choisirQuantiteIHM(),quantiteInt);
       // Si le joueur souhaite annuler la transaction
       if quantiteInt = 0 then achatObjets()
       // Sinon si la quantite est bonne on accepte la transaction
       else if (quantiteInt * PRIX_BOMBE <= getJoueur.argent) then
       begin
         ajouterObjetJoueur(0, quantiteInt);
         retirerArgentJoueur(quantiteInt * PRIX_BOMBE);
         achatObjets();
       end
       // Sinon si on a pas les moyens on affiche
       else
       begin
         nePeutPasAcheterIHM();
         achatObjets();
       end;
  end
  // Si on veut acheter des potions
  else if choix = '2' then
  begin
       quantiteIsInt := TryStrToInt(choisirQuantiteIHM(),quantiteInt);
       while not quantiteIsInt do quantiteIsInt := TryStrToInt(choisirQuantiteIHM(),quantiteInt);
       // Si le joueur souhaite annuler la transaction
       if quantiteInt = 0 then achatObjets()
       // Sinon si la quantite est bonne on accepte la transaction
       else if (quantiteInt * PRIX_POTION <= getJoueur.argent) then
       begin
         ajouterObjetJoueur(1, quantiteInt);
         retirerArgentJoueur(quantiteInt * PRIX_POTION);
         achatObjets();
       end
       // Sinon si on a pas les moyens on affiche
       else
       begin
         nePeutPasAcheterIHM();
         achatObjets();
       end;
  end
  // Si on veut acheter des pierres
  else if choix = '3' then
  begin
       quantiteIsInt := TryStrToInt(choisirQuantiteIHM(),quantiteInt);
       while not quantiteIsInt do quantiteIsInt := TryStrToInt(choisirQuantiteIHM(),quantiteInt);
       // Si le joueur souhaite annuler la transaction
       if quantiteInt = 0 then achatObjets()
       // Sinon si la quantite est bonne on accepte la transaction
       else if (quantiteInt * PRIX_PIERRE <= getJoueur.argent) then
       begin
         ajouterObjetJoueur(2, quantiteInt);
         retirerArgentJoueur(quantiteInt * PRIX_PIERRE);
         achatObjets();
       end
       // Sinon si on a pas les moyens on affiche
       else
       begin
         nePeutPasAcheterIHM();
         achatObjets();
       end;
  end



  // Si le joueur a fait un mauvais choix
  else achatObjets();
end;


// ------------------------------------------------- ACHAT COMPOSANTS -----------------------------------------------
procedure achatComposants();
var
  choix : string;
  quantiteIsInt : boolean;
  quantiteInt : integer;
  positionBois, positionFer : integer;
  i : integer;
const
  PRIX_BOIS = 5;
  PRIX_FER = 15;
begin

  // On initialise les variables de bois et de fer pour que ce soit plus simple en cherchant dans la variable des items dispo
  for i:=0 to NOMBRE_ITEM_DE_CRAFT_JEU-1 do
  begin
    if itemsDeCraftsDisponibles[i].nom = 'Bois' then positionBois := i
    else if itemsDeCraftsDisponibles[i].nom = 'Fer' then positionFer := i;
  end;

  choix := achatComposantsIHM();
  if choix = '0' then marchand()
  // Si on veut acheter du bois
  else if choix = '1' then
  begin
       quantiteIsInt := TryStrToInt(choisirQuantiteIHM(),quantiteInt);
       while not quantiteIsInt do quantiteIsInt := TryStrToInt(choisirQuantiteIHM(),quantiteInt);
       // Si le joueur souhaite annuler la transaction
       if quantiteInt = 0 then achatComposants()
       // Sinon si la quantite est bonne on accepte la transaction
       else if (quantiteInt * PRIX_BOIS <= getJoueur.argent) then
       begin
         ajouterItemJoueur(positionBois, quantiteInt);
         retirerArgentJoueur(quantiteInt * PRIX_BOIS);
         achatComposants();
       end
       // Sinon si on a pas les moyens on affiche
       else
       begin
         nePeutPasAcheterIHM();
         achatComposants();
       end;
  end
  // Si on veut acheter du fer
  else if choix = '2' then
  begin
       quantiteIsInt := TryStrToInt(choisirQuantiteIHM(),quantiteInt);
       while not quantiteIsInt do quantiteIsInt := TryStrToInt(choisirQuantiteIHM(),quantiteInt);
       // Si le joueur souhaite annuler la transaction
       if quantiteInt = 0 then achatComposants()
       // Sinon si la quantite est bonne on accepte la transaction
       else if (quantiteInt * PRIX_FER <= getJoueur.argent) then
       begin
         ajouterItemJoueur(positionFer, quantiteInt);
         retirerArgentJoueur(quantiteInt * PRIX_FER);
         achatComposants();
       end
       // Sinon si on a pas les moyens on affiche
       else
       begin
         nePeutPasAcheterIHM();
         achatComposants();
       end;
  end



  // Si le joueur a fait un mauvais choix
  else achatComposants();
end;



// ------------------------------------------------- VENTE COMPOSANTS -----------------------------------------------
// Procédure pour vendre ses composants
procedure venteComposants();
var
  compteurComposant : integer;
  i :integer;
  choix : string;
  choixInt, quantiteInt : integer;
  choixIsInt, quantiteIsInt : boolean;
  positionComposantChoisi : integer;
begin
  venteComposantsIHM();
  enteteVenteComposantsIHM();

  // On initialise le compteur des composants possédées en commançant à 1 (car l'affichage commence à 1)
  compteurComposant := 1;
  // On parcours tout l'inventaire de composants du joueur
  for i:=0 to NOMBRE_ITEM_DE_CRAFT_JEU-1 do
  begin
    // Si le joueur possède au moins 1 exemplaire du composant on l'affiche
    if (getJoueur.itemsPossedes[i] >= 1) then
    begin
         afficherComposantIHM(compteurComposant, i);
         compteurComposant := compteurComposant +1;
    end;
  end;

  // Si le joueur ne possède aucun composant
  if compteurComposant = 1 then
  begin
       aucunComposantPossedeIHM();
       marchand();
  end
  else
    begin
    // Choix du joueur
    readln(choix);

    //REPONSE EN FONCTION DU CHOIX
    choixIsInt := TryStrToInt(choix, choixInt);
    if choix = '0' then marchand()


    else if (choixIsInt) and (choixInt >= 1) and (choixInt < compteurComposant) then
    begin
         // On essaye de trouver à quoi le choix du joueur faisait référence en refaisant la boucle
         compteurComposant := 1;
        // On parcours tout l'inventaire de composants du joueur
        for i:=0 to NOMBRE_ITEM_DE_CRAFT_JEU-1 do
        begin
          // Si le joueur possède au moins 1 exemplaire du composant on l'affiche
          if (getJoueur.itemsPossedes[i] >= 1) then
          begin
               if (compteurComposant = choixInt) then positionComposantChoisi := i;
               compteurComposant := compteurComposant +1;
          end;
        end;

        // On demande la quantité que le joueur veut vendre
        quantiteIsInt := TryStrToInt(choisirQuantiteIHM(),quantiteInt);
        while not quantiteIsInt do quantiteIsInt := TryStrToInt(choisirQuantiteIHM(),quantiteInt);
        // Si le joueur souhaite annuler la transaction
        if quantiteInt = 0 then venteComposants()
        // Si le joueur vend une quantité valide
        else if quantiteInt <= getJoueur.itemsPossedes[positionComposantChoisi] then
        begin
            retirerItemJoueur(positionComposantChoisi, quantiteInt);
            ajouterArgentJoueur(quantiteInt * itemsDeCraftsDisponibles[positionComposantChoisi].prixVente);
            venduComposantsIHM(itemsDeCraftsDisponibles[positionComposantChoisi], quantiteInt);
            venteComposants();
        end
        // Si le joueur ne met pas une quantité valide
        else
        begin
          nePeutPasVendreIHM();
          venteComposants();
        end;

    end



    else venteComposants();
  end;
end;


// ------------------------------------------------- MARCHAND -----------------------------------------------
procedure marchand();
var
  choix : string;
begin
  choix := marchandIHM();
  if choix = '0' then ville()
  else if choix = '1' then achatObjets()
  else if choix = '2' then achatComposants()
  else if choix = '3' then venteComposants()
  else marchand();
end;

end.

