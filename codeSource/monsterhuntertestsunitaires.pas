unit monsterHunterTestsUnitaires;

{$mode objfpc}{$H+}
{$codepage utf8}

interface
uses
  Classes, SysUtils, TestUnitaire, monsterHunterJoueur, monsterHunterArmesEtArmures, monsterHunterGestionCombatJoueur, monsterHunterGestionCombatMonstre, monsterHunterMonstre;

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

//Tests unitaires de l'initialisation des monstres
procedure initialisationMonstre_test();
var
  TestAtribut : boolean;  //Variable de renvoi pour chaque test unitaire
  i : integer; //Variable de boucle

begin
    newTestsSeries('Initialisation des monstres');

    //On initialise les monstres
    initialisationMonstres('attributsMonstres/monstresAttributs.csv');

    //--------------------------------------------- Test 1 ---------------------------------------------

    newTest('Initialisation des monstres', 'Points de vie des Monstres');
    TestAtribut := True;

    //On parcours les monstres et on test
    for i := 0 to length(getMonstres())-1 do
    begin
        //On test que les monstres ont des points de vie
        if (getMonstres[i].vie) <= 0 then TestAtribut:= False;
    end;

    testIsEqual(TestAtribut);

    //--------------------------------------------- Test 2 ---------------------------------------------

    newTest('Initialisation des monstres', 'Degats des Monstres');
    TestAtribut := True;

    //On parcours les monstres et on test
    for i := 0 to length(getMonstres())-1 do
    begin
        //On test que les monstres font des dégats
        if ((getMonstres[i].dmgAttaque) <= 0) and ((getMonstres[i].dmgAttaqueSpe) <= 0) then TestAtribut:= False;
    end;
    testIsEqual(TestAtribut);

    //--------------------------------------------- Test 3 ---------------------------------------------

    newTest('Initialisation des monstres', 'Vitesse des Monstres');
    TestAtribut := True;

    //On parcours les monstres et on test
    for i := 0 to length(getMonstres())-1 do
    begin
        //On test que les monstres ont une vitesse
        if ((getMonstres[i].vitesse) <= 0) then TestAtribut:= False;
    end;

    testIsEqual(TestAtribut);

    //--------------------------------------------- Test 4 ---------------------------------------------

    newTest('Initialisation des monstres', 'Esquive des Monstres');
    TestAtribut := True;

    //On parcours les monstres et on test
    for i := 0 to length(getMonstres())-1 do
    begin
        //On test que les monstres ont de l'esquive
        if ((getMonstres[i].esquive) <= 0) then TestAtribut:= False;
    end;

    testIsEqual(TestAtribut);
end;

//Tets unitaires de l'initialisation des monstres dans le combat en fonction de la difficulte
procedure initialisationMonstreCombat_test();
begin

end;

procedure test();
begin
  //Tets unitaires de l'initialisation du joueur
  initialisationPersonnage_test();

  //Tests unitaires de l'initialisation des monstres
  initialisationMonstre_test();

  Summary();
  readln;
end;

end.

