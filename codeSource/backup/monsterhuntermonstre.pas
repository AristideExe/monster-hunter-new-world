unit monsterHunterMonstre;

{$mode objfpc}{$H+}

// ============================================================================= INTERFACE ======================================================================================
interface

uses
  Classes, SysUtils;

type
  // Type qui représente les loots que peuvent donner un monstre
  nombreLoot = record
    nomLoot : string;
    quantiteMinimum : integer;       //quantité de loot minimum d'un loot
    quantiteMaximum : integer;       //quantité de loot maximum d'un loot

  end;

  // Type qui représente un monstre
  typeMonstre = record
    nom : string;
    vie : integer;
    esquive : integer;
    vitesse : integer;
    dmgAttaque : integer;         //Attaque normale
    dmgAttaqueSpe : integer;      //Attque spéciale
    loot : nombreLoot;            //Fait un tableau contenant les loots du monstre en question ainsi

  end;

  // ------------------------------------------------- VARIABLES ---------------------------------------------
var
  monstres : array [0..7] of typeMonstre; //Créé un tableau comprenant tout les monstres

  // ------------------------------------------ FONCTIONS ET PROCEDURES --------------------------------------

//Initialisation des monstres
procedure initialisationMonstres();

// =========================================================================== IMPLEMENTATION ===================================================================================
implementation

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

//Génération des attributs des monstres
procedure monstresAttributs(fichier : string);
var
  fichierMonstre : TextFile;       //Lis le fichier
  ligne : string;                  //Représente une ligne du fichier
  listeLigne : array of string;    //Tableau de chaque case
  compteur : integer;              //compte les lignes parcourues

  //Attributs
  nom : string;
  vie : integer;
  esquive : integer;
  vitesse : integer;
  dmgAttaque : integer;
  dmgAttaqueSpe : integer;

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

        //On change les Stats
        modifierStatsMonstre(monstres[compteur], nom,vie,esquive,vitesse,dmgAttaque,dmgAttaqueSpe);

        compteur := compteur + 1;

  until(EOF(fichierMonstre));

end;

//Initialisation des monstres
procedure initialisationMonstres();
begin
  monstresAttributs('attributsMonstres/monstres.csv');    //Envoie le chemin du fichier csv a la procedure
end;


end.

