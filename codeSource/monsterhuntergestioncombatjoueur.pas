unit monsterHunterGestionCombatJoueur;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface

uses
  Classes, SysUtils, monsterHunterJoueur, monsterHunterMonstre, monsterHunterCombatIHM, monsterHunterGestionCombatMonstre, monsterHunterArmesEtArmures, monsterHunterVille;

  // ------------------------------------------------- Types ---------------------------------------------


  // ------------------------------------------------- VARIABLES ---------------------------------------------


  // ------------------------------------------ FONCTIONS ET PROCEDURES --------------------------------------

   //Fonction qui gère la précision en fonction de l'arme
   function precisionArme(esquive:integer):integer;

   //procedure qui calcule le nombre de dégats que vas prendre le joueur en fonction de l'esquive, la tankiness, les dégats du monstre
   function calculDmgJoueur ():integer;

   //procedure qui inflige des dégats au joueur
   procedure degatsCombatJoueur(dmg : integer);

   //procedure qui vérifie la mort du monstre
   procedure estMortJoueur ();

   //Procedure qui fait fuir le joueur
   procedure fuiteJoueur ();

   //Fonction qui calcule les buffs/debuffs liés a l'émoussement de l'arme
   function calculEmoussementArmeJoueur ():real;

   //Procedure d'utilisation d'une potion de soin
   procedure utilisationPotionSoin ();

   //Procedure d'utilisation de pierre ponce
   procedure utilisationPierrePonce ();

   //Procedurre d'utilisation de bombe
   procedure utilisationBombeJoueur ();

// =========================================================================== IMPLEMENTATION ===================================================================================

implementation

//Constantes
const
  maxDef = 1650;
  dmgBombe =  60;


//Fonction qui gère la précision en fonction de l'arme
function precisionArme(esquive:integer):integer;
begin
  case getJoueur.armePortee.arme of
  epee : precisionArme := round(esquive * 0.1);
  hache : precisionArme := round(esquive * 0.05);
  marteau : precisionArme := round(esquive * 0);
  couteau : precisionArme := round(esquive * 0.2);
  end;

end;

//Fonction qui renvoie un montant de réduction en fonction de la défense
function reductionDmgArmure ():Real;
var
  totalDefense : real;

begin

  //On cumule la défense  de chaque pièce d'armure
  totalDefense := getJoueur.armurePortee[0].valeurDefense;
  totalDefense := totalDefense + getJoueur.armurePortee[1].valeurDefense;
  totalDefense := totalDefense + getJoueur.armurePortee[2].valeurDefense;
  totalDefense := totalDefense + getJoueur.armurePortee[3].valeurDefense;
  totalDefense := totalDefense + getJoueur.armurePortee[4].valeurDefense;

  //On renvoie un pourcentage de réduction
  reductionDmgArmure := 0.6*(totalDefense / maxDef);
end;

//Fonction qui renvoie le taux d'esquive d'un joueur en fonction de son armure
function tauxEsquive(): integer;
begin

    //On cumule les valeurs d'esquive à renvoyer
    tauxEsquive := round(getJoueur.armurePortee[0].tauxEsquive);
    tauxEsquive := tauxEsquive +  round(getJoueur.armurePortee[1].tauxEsquive);
    tauxEsquive := tauxEsquive +  round(getJoueur.armurePortee[2].tauxEsquive);
    tauxEsquive := tauxEsquive +  round(getJoueur.armurePortee[3].tauxEsquive);
    tauxEsquive := tauxEsquive +  round(getJoueur.armurePortee[4].tauxEsquive);

end;

//procedure qui inflige des dégats au joueur
procedure degatsCombatJoueur(dmg : integer);
var
  buffPV : integer;
  dmgVie : integer;
  //dmgBuff : integer;

begin
  buffPV := getJoueur().buffVie;
  dmgVie := dmg - buffPV;

  if dmgVie < 0 then dmgVie:= 0;

  //On soustrait la vie au buff si il en à un
  soustraireBuffJoueur(dmg,0);

  //On inflige le reste des dégats aux pv du joueur
  if dmg > getJoueur().vie then modifierVieJoueur(0)
  else modifierVieJoueur(getJoueur().vie - dmgVie);

end;

//procedure qui calcule le nombre de dégats que vas prendre le joueur en fonction de l'esquive, la tankiness, les dégats du monstre
function calculDmgJoueur ():integer;
var
  dmg : integer;
  ajoutReduction : real;

begin
  Randomize;

  //On regarde si le joueur esquive ici il n'esquive pas
  if random(101) > tauxEsquive() then
  begin
    ajoutReduction:= 1 - reductionDmgArmure;
    //On mesure les dégats en fonction de la réduction de dégats
    dmg := round(aleaTypeAttaqueMonstre() * ajoutReduction);

    if dmg = 0 then
       dmg := 1;

  end

  //Sinon il esquive
  else dmg := 0;

  calculDmgJoueur := dmg

end;

//Fonction qui calcule les buffs/debuffs liés a l'émoussement de l'arme
function calculEmoussementArmeJoueur ():real;
var
  emoussementCourant : integer;
  emoussementMax : integer;

begin
  //On lis l'émoussement max et actuel
  emoussementCourant := getJoueur().armePortee.emoussement;
  emoussementMax:= getJoueur().armePortee.emoussementDepart;

  //On check l'état de l'émoussement et on applique le buff/debuff
  if ((emoussementCourant/emoussementMax) > 0.90) then calculEmoussementArmeJoueur := 1.1
  else if ((emoussementCourant/emoussementMax) > 0.75) then calculEmoussementArmeJoueur := 1.05
  else if ((emoussementCourant/emoussementMax) > 0.25) then calculEmoussementArmeJoueur := 1
  else if (emoussementCourant > 1) then calculEmoussementArmeJoueur := 0.7
  else calculEmoussementArmeJoueur := 0.10;

end;

//Procedure qui fait fuir le joueur
procedure fuiteJoueur ();
begin
    retirerArgentJoueur(100);
end;

//Procedurre d'utilisation de bombe
procedure utilisationBombeJoueur ();
begin
  degatsCombatMonstre(dmgBombe);
  retirerObjetJoueur(0,1);
end;

//Procedure d'utilisation de pierre ponce
procedure utilisationPierrePonce ();
begin
  reinitialiserEmoussementArmeJoueur();
  retirerObjetJoueur(2,1);
end;

//Procedure d'utilisation d'une potion de soin
procedure utilisationPotionSoin ();
begin
    if (getJoueur().vie + 50) > 100 then reinitialiserVieJoueur()
    else modifierVieJoueur(getJoueur().vie + 50);

    retirerObjetJoueur(1,1);
end;

//procedure qui vérifie la mort du monstre
procedure estMortJoueur ();
begin

    //Si il est mort
    if getJoueur().vie = 0 then
      begin

        //On fait perdre l'inventaire du joueur
        viderInventaireObjetsJoueur();

        //On remet les pv du joueur au max
        modifierVieJoueur(100);

        //Le joueur perd ses buffs
        reinitialiseBuffJoueur();

        //On affiche le game over
        messageMortJoueurIHM();

        //On retourne en ville
        ville();

      end;
end;

end.

