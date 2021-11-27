unit monsterHunterMonstre;

{$mode objfpc}{$H+}
 {$codepage utf8}
/// ============================================================================= INTERFACE ======================================================================================
interface

uses
  Classes, SysUtils;

type
  // Type qui représente les loots que peuvent donner un monstre
  monstreLoot = record
    nomLoot : string;
    quantiteMinimum : integer;       //quantité de loot minimum d'un loot
    quantiteMaximum : integer;       //quantité de loot maximum d'un loot

  end;

  //Type qui représente un monstre
  typeMonstre = record
    nom : string;
    vie : integer;
    esquive : integer;
    vitesse : integer;
    dmgAttaque : integer;         //Attaque normale
    dmgAttaqueSpe : integer;      //Attque spéciale
    loot : array [0..2] of monstreLoot;            //Fait un tableau contenant les 3 loots du monstre en question ainsi que la quantité de loot

  end;

  //Type qui représente la liste des monstres
  listMonstre = array [0..7] of typeMonstre;

  // ------------------------------------------------- VARIABLES ---------------------------------------------
  var
    monstres : listMonstre; //Créé un tableau comprenant tout les monstres

  // ------------------------------------------ FONCTIONS ET PROCEDURES --------------------------------------

  //Initialisation des monstres
  procedure initialisationMonstres(fichier:string);

  //Obtient les monstres
  function getMonstres():listMonstre;

// =========================================================================== IMPLEMENTATION ===================================================================================
implementation

//Obtient les monstres
function getMonstres(): listMonstre; //test
begin
    getMonstres := monstres;
end;

//Modifie les stats d'un monstre
procedure modifierStatsMonstre(var monster : typeMonstre; nomMonstre:string ; vieMonstre, esquiveMonstre, vitesseMonstre, dmgAttaqueMonstre, dmgAttaqueSpeMonstre : integer);
begin
     //Chaque stat des monstres est modifiée
     monster.nom:= nomMonstre;
     monster.vie:=vieMonstre;
     monster.esquive:=esquiveMonstre;
     monster.vitesse:=vitesseMonstre;
     monster.dmgAttaque:=dmgAttaqueMonstre;
     monster.dmgAttaqueSpe:=dmgAttaqueSpeMonstre;
end;

//Modifie les loots du monstre
procedure modifierLootMonstre(var monster : typeMonstre; lootMonstre : array of monstreLoot);
begin
     //Le loot du monstre est modifié
     monster.loot := lootMonstre;
end;

//Génération des attributs des monstres
procedure monstresAttributs(fichier : string);
var
  fichierMonstre : TextFile;       //Lis le fichier
  ligne : string;                  //Représente une ligne du fichier
  listeLigne : array of string;    //Tableau de chaque case
  compteur : integer;              //compte les lignes parcourues

  i: integer; //Variable de boucle

  //Attributs
  nom : string;
  vie : integer;
  esquive : integer;
  vitesse : integer;
  dmgAttaque : integer;
  dmgAttaqueSpe : integer;
  loot : array [0..2] of monstreLoot;

begin
  compteur:=0;
  assignFile(fichierMonstre, fichier);
  reset(fichierMonstre);

  // Lecture de la premiere ligne du fichier qui sert d'entête
  readln(fichierMonstre);

  // On lit chaque ligne jusqu'à la fin du fichier
  repeat
        readln(fichierMonstre,ligne);

        // On transforme la ligne en une liste
        listeLigne := ligne.Split(';');

        //On remplit les attributs du monstre a partir du fichier CSV
        nom:=listeLigne[0];
        vie:=strToInt(listeLigne[1]);
        esquive:=strToInt(listeLigne[2]);
        vitesse:=strToInt(listeLigne[3]);
        dmgAttaque:=strToInt(listeLigne[4]);
        dmgAttaqueSpe:=strToInt(listeLigne[5]);

        //On rempli le tableau des loots (pour chaque loot du monstre)
        for i:=0 to 2 do
        begin

             loot[i].nomLoot := listeLigne[6+3*i];                    //Nom du loot
             loot[i].quantiteMinimum := strToInt(listeLigne[7+3*i]);  //Quantité de drop minimum du loot
             loot[i].quantiteMaximum := strToInt(listeLigne[8+3*i]); //Quantité de drop maximum du loot

        end;

        //On change les Stats
        modifierStatsMonstre(monstres[compteur], nom,vie,esquive,vitesse,dmgAttaque,dmgAttaqueSpe);
        modifierLootMonstre(monstres[compteur], loot);

        compteur := compteur + 1;

  until(EOF(fichierMonstre));

end;

//Initialisation des monstres
procedure initialisationMonstres(fichier:string);
begin
  monstresAttributs(fichier);    //Envoie le chemin du fichier csv a la procedure
end;


end.
