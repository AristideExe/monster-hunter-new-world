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

    //--------------------------------------------- Test 5 ---------------------------------------------

    newTest('Initialisation des monstres', 'Loots des Monstres');
    TestAtribut := True;

    //On parcours les monstres et on test
    for i := 0 to length(getMonstres())-1 do
    begin
        //On test que les monstres ont de l'esquive
        if ((getMonstres[i].loot[0].quantiteMinimum) <= 0) and ((getMonstres[i].loot[1].quantiteMinimum) <= 0) and ((getMonstres[i].loot[2].quantiteMinimum) <= 0) then TestAtribut:= False;
        if ((getMonstres[i].loot[0].quantiteMaximum) <= 0) and ((getMonstres[i].loot[0].quantiteMaximum) <= 0) and ((getMonstres[i].loot[0].quantiteMaximum) <= 0) then TestAtribut:= False;
    end;

    testIsEqual(TestAtribut);
end;

//Tets unitaires de l'initialisation des monstres dans le combat en fonction de la difficulte
procedure initialisationMonstreCombat_test();
var
  TestAtribut : boolean;  //Variable de renvoi pour chaque test unitaire
  i : integer; //Variable de boucle

begin
    newTestsSeries('Initialisation des monstres en combat');

    //On initialise les monstres
    initialisationMonstres('attributsMonstres/monstresAttributs.csv');

    //On test pour chaque difficulté
    for i := 0 to 3 do
    begin
        initialisationCombatMonstre(i+1);

        //--------------------------------------------- Test 1 - 2 - 3 - 4 ---------------------------------------------

        newTest('Initialisation des monstres en combat', 'Génération des monstres niveau ' + IntToStr(i+1));
        TestAtribut := True;

        //On check si il est bien de la bonne difficulté
        if (getMonstreCombat.nom <> getMonstres[0 + 2*i].nom) and (getMonstreCombat.nom <> getMonstres[1 + i*2].nom) then TestAtribut := False;

        testIsEqual(TestAtribut);

    end;

end;

//Test perte de vie des monstres
procedure perteVieMonstres_test();
var
  TestVie : boolean;  //Variable de renvoi pour chaque test unitaire
  i : integer; //Variable de boucle
  vieMaxMonstre : integer;  //Permet de savoir la sentée max du monstre

begin
    newTestsSeries('Perte de vie des monstres');

    //On initialise les monstres
    initialisationMonstres('attributsMonstres/monstresAttributs.csv');

    //On test pour chaque monstre de chaque difficulté
    for i := 0 to 3 do
    begin
        initialisationCombatMonstre(i+1);

        //--------------------------------------------- Test 1 - 2 - 3 - 4 ---------------------------------------------

        newTest('Perte de vie des monstres', 'Perte de vie des monstres niveau ' + IntToStr(i+1));
        TestVie := True;

        vieMaxMonstre:= getMonstreCombat.vie;
        degatsCombatMonstre(20);

        //On check si il prends bien le bon nombre de dégats
        if (getMonstreCombat.vie <> (vieMaxMonstre - 20)) and (getMonstreCombat.vie <> vieMaxMonstre) then TestVie := False;

        testIsEqual(TestVie);

    end;

end;

//Test les dégats que prends le joueur sans stuff
procedure perteVieJoueur_test();
var
  TestVie : boolean;  //Variable de renvoi pour chaque test unitaire

begin
    newTestsSeries('Perte de vie du Joueur');

    //On initialise le personnage
    initialisationPersonnage();

    //--------------------------------------------- Test 1 ---------------------------------------------

    newTest('Perte de vie du Joueur', 'Perte de 50 pv');

    //On fait des dégats
    degatsCombatJoueur(50);

    TestVie := True;

    if (getJoueur.vie <> 50) then TestVie := False;

    testIsEqual(TestVie);

    //--------------------------------------------- Test 2 ---------------------------------------------

    newTest('Perte de vie du Joueur', 'Perte de 100 pv');

    //On réinitialise la vie du joueur
    reinitialiserVieJoueur();

    //On fait des dégats
    degatsCombatJoueur(100);

    TestVie := True;

    if (getJoueur.vie <> 0) then TestVie := False;

    testIsEqual(TestVie);

    //--------------------------------------------- Test 3 ---------------------------------------------

    newTest('Perte de vie du Joueur', 'Perte de 3000 pv');

    //On réinitialise la vie du joueur
    reinitialiserVieJoueur();

    //On fait des dégats
    degatsCombatJoueur(3000);

    TestVie := True;

    if (getJoueur.vie <> 0) then TestVie := False;

    testIsEqual(TestVie);
end;

//Test utilisation objets
procedure utilisationObjets_test();
var
  TestItem : boolean;  //Variable de renvoi pour chaque test unitaire
  VieMaxMonstre : integer;

begin
    newTestsSeries('Utilisation d''items');

    //On initialise le personnage
    initialisationPersonnage();

    //On initialise les monbstres
    initialisationMonstres('attributsMonstres/monstresAttributs.csv');

    //Innitialisation d'un monstre pour combattre
    initialisationCombatMonstre(1);

    //On initialise les armes
    remplirArmesDisponibles('nomsStatsObjets/armes.csv');

    //On donne une arme au joueur
    donnerArmeJoueur(4,armesDisponibles[4]);

    VieMaxMonstre:= getMonstreCombat().vie;

    //--------------------------------------------- Test 1 ---------------------------------------------

    newTest('Utilisation d''items', 'Potion de soin');

    //On fait des dégats au joueur
    degatsCombatJoueur(75);

    //On utilise la potion de soin
    utilisationPotionSoin();

    TestItem := True;

    //On regarde que la vie est bien remontée de 50
    if (getJoueur.vie <> (100 - 75 + 50)) then TestItem := False;

    testIsEqual(TestItem);

    //--------------------------------------------- Test 2 ---------------------------------------------

    newTest('Utilisation d''items', 'Bombe');

    //On utilise la bombe
    utilisationBombeJoueur();

    TestItem := True;

    //On regarde si le monstre prends bien les dégts ou les esquive
    if (getMonstreCombat().vie <> VieMaxMonstre - 60) and (getMonstreCombat().vie <> VieMaxMonstre) then TestItem := False;

    testIsEqual(TestItem);

    //--------------------------------------------- Test 3 ---------------------------------------------

    newTest('Utilisation d''items', 'Pierre Ponce');

    //On réduit l'émoussement de l'arme
    baisserEmoussementArme(30);

    //On utilise la pierre ponce
    utilisationPierrePonce();

    TestItem := True;

    //On regarde si l'émoussement est bien réinitialisé
    if ((getJoueur.armePortee.emoussement) <> (getJoueur.armePortee.emoussementDepart)) then TestItem := False;

    testIsEqual(TestItem);

end;

procedure test();
begin
  //Tets unitaires de l'initialisation du joueur
  initialisationPersonnage_test();

  //Tests unitaires de l'initialisation des monstres
  initialisationMonstre_test();

  //Tets unitaires de l'initialisation des monstres dans le combat en fonction de la difficulte
  initialisationMonstreCombat_test();

  //Test perte de vie des monstres
  perteVieMonstres_test();

  //Test les dégats que prends le joueur sans stuff
  perteVieJoueur_test();

  //Test utilisation objets
  utilisationObjets_test();

  Summary();
  readln;
end;

end.

