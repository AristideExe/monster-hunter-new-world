unit monsterHunterTestsUnitaires;

{$mode objfpc}{$H+}
{$codepage utf8}

interface
uses
  Classes, SysUtils, TestUnitaire, monsterHunterJoueur, monsterHunterArmesEtArmures;

// Procédure qui lance tous les tests
procedure test();

implementation

procedure initialisationPersonnage_test();
var
  i : integer;
  estVide : boolean;
begin
  newTestsSeries('Initialisation du joueur');
  initialisationPersonnage();

  newTest('Initialisation du joueur','Valeur de vie à 100');
  testIsEqual(getJoueur.vie, 100);

  newTest('Initialisation du joueur','Valeur de vitesse à 100');
  testIsEqual(getJoueur.vitesse, 100);

  newTest('Initialisation du joueur','Argent à 100');
  testIsEqual(getJoueur.argent, 100);

  newTest('Initialisation du joueur', 'Inventaire d''armures vides');
  estVide := true;
  for i:=0 to NOMBRE_ARMURES_JEU-1 do
  begin
    if getJoueur.armuresPossedees[i].nom <> 'NULL' then estVide := false;
    if getJoueur.armuresPossedees[i].element <> normal then estVide := false;
    if getJoueur.armuresPossedees[i].valeurDefense <> 0 then estVide := false;
    if getJoueur.armuresPossedees[i].tauxEsquive <> 0 then estVide := false;
  end;
  testIsEqual(estVide);

  newTest('Initialisation du joueur', 'Inventaire d''armures portées vide');
  estVide := true;
  for i:=0 to 4 do
  begin
    if getJoueur.armurePortee[i].nom <> 'NULL' then estVide := false;
    if getJoueur.armurePortee[i].element <> normal then estVide := false;
    if getJoueur.armurePortee[i].valeurDefense <> 0 then estVide := false;
    if getJoueur.armurePortee[i].tauxEsquive <> 0 then estVide := false;
  end;
  testIsEqual(estVide);

  newTest('Initialisation du joueur', 'Inventaire d''armes vides');
  estVide := true;
  for i:=0 to NOMBRE_ARMES_JEU-1 do
  begin
    if getJoueur.armesPossedees[i].nom <> 'NULL' then estVide := false;
    if getJoueur.armesPossedees[i].element <> normal then estVide := false;
    if getJoueur.armesPossedees[i].emoussementDepart <> -1 then estVide := false;
    if getJoueur.armesPossedees[i].emoussement <> -1 then estVide := false;
    if getJoueur.armesPossedees[i].valeurAttaque <> 0 then estVide := false;
  end;
  testIsEqual(estVide);
end;



procedure test();
begin
  initialisationPersonnage_test();

  Summary();
  readln;
end;

end.

