unit unitMonsterHunterLogic;

{$mode objfpc}{$H+}

interface

// Menu principal
procedure menu();
// Ville du lobby
procedure ville();
//Chambre
procedure chambre();


// TYPES
type
  typeElement = (normal,feu,eau,glace,plante,tonerre,lumiere,tenebres,electrique);
  typePieceArmure = (casque,torse,jambieres,bottes,gants);
  typePieceArme = (epee,hache,couteau,marteau);
  typeArmure = record
             nom : string;
             pieceArmure : typePieceArmure;
             element : typeElement;
             valeurDefense : real;
             tauxEsquive : real;
  end;
  typeArme = record
             nom : string;
             arme : typePieceArme;
             element : typeElement;
             emoussementDepart : integer;
             emoussement: integer;
             valeurAttaque : real;
  end;
  arrayPieceArmure = array [0..19] of typeArmure;


  typePersonnage = record
             nom : string;
             taille : string;
             sexe : string;
             // 5 éléments d'armure : casque, torse, jambières, bottes, gants
             armurePortee : array [0..4] of typeArmure;
             armuresPossedees : array [0..99] of typeArmure;
             armePortee : typeArme;
             armesPossedees : array [0..24] of typeArme;
  end;



// VARIABLES PERSONNAGE
var
  joueur : typePersonnage;




// FONCTIONS POUR RETOURNER LE JOUEUR
function getJoueur() : typePersonnage;
// Renvoie l'armure suivant le type d'armure
function getArmureJoueur(armure : typePieceArmure) : typeArmure;
// Renvoie la liste des pièces demandées dans l'inventaire
function getPiecesPossedees(piece : typePieceArmure) : arrayPieceArmure;









implementation

uses
  Classes, SysUtils, unitmonsterhunterIHM;

// Affiche le message lorsque l'on quitte
procedure quitter();
begin
  //quitterIHM();
end;

// Procédure pour modifier les valeurs d'une armure plus facilement
procedure modifierArmure(var armure : typeArmure; nom : string; pieceArmure : typePieceArmure; element : typeElement; valeurDefense, tauxEsquive : real);
begin
  armure.nom := nom;
  armure.pieceArmure := pieceArmure;
  armure.element := element;
  armure.valeurDefense := valeurDefense;
  armure.tauxEsquive := tauxEsquive;
end;

// Procédure pour modifier les valeurs d'une arme plus facilement
procedure modifierArme(var arme : typeArme; nom :string; typeArme : typePieceArme; element : typeElement;emoussementDepart,emoussement : integer ; valeurAttaque : real);
begin
  arme.nom := nom;
  arme.arme := typeArme;
  arme.element := element;
  arme.emoussementDepart := emoussementDepart;
  arme.emoussement := emoussement;
  arme.valeurAttaque := valeurAttaque;
end;


// Procédure pour échanger deux armures
procedure echangerArmures(var armure1, armure2 : typeArmure);
var
  armureTemp : typeArmure;
begin
  armureTemp := armure1;
  armure1 := armure2;
  armure2 := armureTemp;
end;


procedure choisirCombat();
begin
  explorationIHM();
end;



procedure cantine();
begin
  cantineIHM();
end;

procedure marchand();
begin
end;

procedure forge();
begin
end;





// --------------------------------- TOUTES LES PROCÉDURES DE LA CHAMBRE ---------------------------------

procedure malle();
begin
  malleIHM();
end;

procedure armoire(armureAAfficher : integer;titre:string);
var
  choix : string;
  choixIsInt : boolean;
  choixInt : integer;
  pieceArmureChoisie : typePieceArmure;
  arrayPieceArmureChoisie : arrayPieceArmure;
  i, compteurArmure : integer;
begin
  choix := armoireIHM(armureAAfficher,titre);
  choixInt := 0;
  choixIsInt := TryStrToInt(choix,choixInt);
  // Si on veut retourner au menu
  if choix = '0' then chambre()
  // Si on veut afficher un autre type d'armure
  else if choix = '-1' then armoire(0,'Casques')
  else if choix = '-2' then armoire(1,'Plastrons')
  else if choix = '-3' then armoire(2,'Jambieres')
  else if choix = '-4' then armoire(3,'Bottes')
  else if choix = '-5' then armoire(4,'Gants')



  // Si on a choisit une armure
  else if choixIsInt and (choixInt>0) and (choixInt < length(joueur.armesPossedees)) then
  begin
       pieceArmureChoisie := typePieceArmure(armureAAfficher);
       compteurArmure := 0;
       // On essaie de trouver à quelle armure le choix faisait référence
       for i:=0 to length(joueur.armuresPossedees) do
       begin
           if (joueur.armuresPossedees[i].pieceArmure = pieceArmureChoisie) and (joueur.armuresPossedees[i].nom <> 'NULL') then
           begin
                if (compteurArmure = choixInt - 1) then echangerArmures(joueur.armurePortee[armureAAfficher],joueur.armuresPossedees[i]);
                compteurArmure := compteurArmure +1;
           end;
       end;
       chambre();
  end



  // Si c'est un mauvais choix
  else armoire(armureAAfficher,titre);
end;






procedure chambre();
var choix : string;
begin
  choix := chambreIHM();
  if choix = '1' then ville()
  else if choix = '2' then armoire(0,'Casques')
  else if choix = '3' then malle()
  else chambre();
end;




// -------------------------------------------- VILLE ------------------------------------------------------
procedure ville();
var
  choix: string;
begin
  choix := villeIHM();
  if (choix = '1') then
    chambre()
  else if (choix = '2') then
    forge()
  else if (choix = '3') then
    marchand()
  else if (choix = '4') then
    cantine()
  else if (choix = '5') then
    choisirCombat()
  else
    ville();
end;



// -------------------------------- TOUTES LES PROCÉDURES DE LANCEMENT DU JEU --------------------------------


// Menu de création de personnage
procedure creationPersonnage();
begin
  creationPersonnageIHM(joueur.nom, joueur.taille, joueur.sexe);

  while (joueur.sexe <> 'M') and (joueur.sexe <> 'F') do
        demanderSexeIHM(joueur.sexe);

  afficherPersonnageIHM(joueur.sexe);
  ville();
end;




// Initialisation des stats du personnage à sa création
procedure initialisationPersonnage();
var
  i,j : integer;
begin
  // Initialisatin de l'armure portée avec un torse de départ
  for i:=0 to length(joueur.armurePortee) do modifierArmure(joueur.armurePortee[i],'NULL',typePieceArmure(i),normal,0,0);
  modifierArmure(joueur.armurePortee[1],'Plastron d''entrainement',typePieceArmure(1),normal,5,2);

  // Modification de l'inventaire d'armures pour qu'il soit vide
  for i:=0 to length(joueur.armuresPossedees)-1 do modifierArmure(joueur.armuresPossedees[i],'NULL',typePieceArmure(i mod 5),normal,0,0);
  //test ajout armures au pif
  for i:=0 to 99 do modifierArmure(joueur.armuresPossedees[i],'Armure' + IntToStr(random(500)),typePieceArmure(i mod 5),normal,random(50),i);

  // Initialisation de l'arme pour avoir une épée de base
  modifierArme(joueur.armePortee,'Epee d''entrainement',epee,normal,100,100,15);

  // Modification de l'inventaire d'armes pour qu'il soit vide
  for j:=0 to length(joueur.armesPossedees)-1 do modifierArme(joueur.armesPossedees[j],'NULL',typePieceArme(0),normal,-1,-1,0);

  creationPersonnage();
end;







// Affiche les différentes sauvegardes
procedure choixSauvegarde();
begin
end;

// Affiche les crédits
procedure credits();
begin
  creditsIHM();
  menu();
end;



// Menu principal
procedure menu();
var
  choix: string;
begin
  choix := menuIHM();
  if (choix = '1') then initialisationPersonnage()
  else if (choix = '2') then choixSauvegarde()
  else if (choix = '3') then credits()
  else if (choix = '4') then quitter()
  else menu();
end;







// -------------------------------- TOUTES LES FONCTIONS DE GET --------------------------------

// Renvoie le joueur
function getJoueur() : typePersonnage;
begin
  getJoueur := joueur
end;

// Renvoie l'armure suivant le type d'armure
function getArmureJoueur(armure :typePieceArmure) : typeArmure;
begin
  if (armure = casque) then getArmureJoueur := joueur.armurePortee[0]
  else if (armure = torse ) then getArmureJoueur := joueur.armurePortee[1]
  else if (armure= jambieres ) then getArmureJoueur := joueur.armurePortee[2]
  else if (armure = bottes) then getArmureJoueur := joueur.armurePortee[3]
  else if (armure = gants) then getArmureJoueur := joueur.armurePortee[4];
end;

// Renvoie la liste des pièces demandées dans l'inventaire
function getPiecesPossedees(piece : typePieceArmure) : arrayPieceArmure;
var nbPieces, i : integer;
begin
  nbPieces := 0;
  for i:=0 to length(joueur.armuresPossedees) - 1 do
     begin
         if joueur.armuresPossedees[i].pieceArmure = piece then
         begin
              getPiecesPossedees[nbPieces] := joueur.armuresPossedees[i];
              nbPieces := nbPieces + 1;
         end;
     end;
end;



end.

