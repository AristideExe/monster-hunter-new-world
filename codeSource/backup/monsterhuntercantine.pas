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
  compteurNourriture, positionNourritureChoisie : integer;
  nourriture : typeNourriture;
  i : integer;
  choixInt : integer;
  choixIsInt : boolean;
  nourritureChoisie : typeNourriture;
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
  choixInt := 0;
  choixIsInt := TryStrToInt(choix,choixInt);
  // Si on veut retourner au choix de sélection
  if choix = '0' then ville()
  // Si on a choisit une nourriture
  else if (choixInt > 0) and (choixInt < compteurNourriture) then
  begin
    // Si les bonus sont déjà au max on autorise pas le joueur à manger
    if (getJoueur.buffVie = 50) and (getJoueur.buffVitesse = 30) then
    begin
         nePeutPasMangerIHM();
         cantine();
    end;
    else
    begin
    // On refait la boucle pour essayer de trouver à quelle nourriture fait référence le choix du joueur
    compteurNourriture := 1;
     for i:=0 to length(nourrituresDisponibles) -1 do
     begin
       // Si le joueur possède au moins un exemplaire
       if (getJoueur.nourrituresPossedees[i] > 0) then
       begin
         if (compteurNourriture = choixInt) then positionNourritureChoisie := i;
         compteurNourriture := compteurNourriture +1;
       end
     end;
     nourritureChoisie := nourrituresDisponibles[positionNourritureChoisie];
     donneBuffJoueur(nourritureChoisie.bonusVie,nourritureChoisie.bonusVitesse);
     retirerNourritureJoueur(positionNourritureChoisie, 1);
     mangerNourritureIHM(nourritureChoisie);
     cantine();
    end;
  end
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

