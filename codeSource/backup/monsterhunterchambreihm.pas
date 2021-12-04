unit monsterHunterChambreIHM;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface

uses
  Classes, SysUtils, GestionEcran, monsterHunterJoueur, monsterHunterArmesEtArmures,typInfo,strUtils;

// IHM de la chambre
function chambreIHM() : string;
// Affichage lorsque l'on dort
procedure dormirIHM();
// IHM de l'armoire à armures
procedure armoireIHM();
// Affichage d'une seule armure dans l'armoire
procedure afficherArmureIHM(armure : typeArmure; numeroArmure : integer; derniereLigne : boolean);
// Affiche les objets possédés
function objetsIHM() : string;
// Affichage d'une seule arme dans la malle
procedure afficherArmeIHM(arme : typeArme; numeroArme : integer; derniereLigne : boolean);
// IHM de la malle des armes
procedure malleIHM();
// Affiche l'entête des colonnes pour la malle
procedure enteteMalleIHM();
// Menu de sélection pour savoir quelle armure on veut afficher
function selectionArmureArmoireIHM() : string;

// =========================================================================== IMPLEMENTATION ===================================================================================
implementation

// ----------------------------------------------------- DORMIR ------------------------------------------------------
// Affichage lorsque l'on dort
procedure dormirIHM();
var
  i,j, k : integer;
begin
  effacerEcran();
  dessinCouleurSansEspaces('dessins/chambre.txt',0,0);
  dessinCouleurSansEspaces('dessins/fenetre.txt',5,2);
  // Remplissage du ciel
  dessinerCadreXY(18,4,36,16,simple,Cyan,Cyan);
  dessinerCadreXY(40,4,58,16,simple,Cyan,Cyan);
  attendre(3000);

  // Animation du soleil
  i := 60;
  j := 11;
  while i > 0 do
  begin
    // Remplissage du ciel
    dessinerCadreXY(18,4,36,16,simple,Cyan,Cyan);
    dessinerCadreXY(40,4,58,16,simple,Cyan,Cyan);
    // Affichage du soleil
    dessinCouleurSansEspaces('dessins/soleil.txt',i,j);
    couleurFond(Black);
    dessinCouleurSansEspaces('dessins/fenetre.txt',5,2);

    i:= i -9;
    j:= j-1;
    attendre(600);

  end;
  deplacerCurseurXY(77,6); write('Vous vous sentez revigoré');
  deplacerCurseurXY(74,9); write('Appuyez sur entrée pour continuer ');


end;


// ----------------------------------------------------- OBJETS ------------------------------------------------------
// Affiche les objets possédés
function objetsIHM() : string;
begin
  effacerEcran();
  cadrePrincipal('Vos objets');

  // Entête
  deplacerCurseurXY(10,5);write('Numéro');
  deplacerCurseurXY(20,5); write('Nom');
  deplacerCurseurXY(48,5); write('Action');
  deplacerCurseurXY(80,5); write('Quantité dans l''inventaire');

  // Affichage des bombes
  deplacerCurseurXY(10,7);write('1');
  deplacerCurseurXY(20,7); write('Bombes');
  deplacerCurseurXY(40,7); write('60 dégats au monstre');
  deplacerCurseurXY(80,7); write(getJoueur.objetsPossedes[0]);

  // Affichage des potions de soin
  deplacerCurseurXY(10,8);write('2');
  deplacerCurseurXY(20,8); write('Potion de soin');
  deplacerCurseurXY(48,8); write('Régénération de 50 points de vie');
  deplacerCurseurXY(80,8); write(getJoueur.objetsPossedes[1]);

  // Affichage des pierres ponces
  deplacerCurseurXY(10,9);write('3');
  deplacerCurseurXY(20,9); write('Pierre ponce');
  deplacerCurseurXY(48,9); write('Retire l''émoussement de l''arme');
  deplacerCurseurXY(80,9); write(getJoueur.objetsPossedes[2]);

  // Affichage des choix
  deplacerCurseurXY(10,28); write(' 0/ Retourner à la chambre ');
  deplacerCurseurXY(85,28); write(' Votre choix :   '); deplacerCurseurXY(100,28);

  readln(objetsIHM);
end;



// ----------------------------------------------------- ARMOIRE ------------------------------------------------------
// Menu de sélection pour savoir quelle armure on veut afficher
function selectionArmureArmoireIHM() : string;
begin
  effacerEcran();
  deplacerCurseurXY(20,1); write('Armoire : choix de l''objet à afficher');
  deplacerCurseurXY(50,11); write('1/ Afficher les casques');
  deplacerCurseurXY(50,12); write('2/ Afficher les plastrons');
  deplacerCurseurXY(50,13); write('3/ Afficher les jambières');
  deplacerCurseurXY(50,14); write('4/ Afficher les bottes');
  deplacerCurseurXY(50,15); write('5/ Afficher les gants');
  deplacerCurseurXY(50,16); write('6/ Afficher les objets');
  deplacerCurseurXY(20,28); write('0/ Retourner à la chambre');
  deplacerCurseurXY(20,29); write('Votre choix : ');
  readln(selectionArmureArmoireIHM);
end;

// IHM de l'armoire à armures
procedure armoireIHM();
begin
  effacerEcran();
  deplacerCurseurXY(5,1); write('Armoire à armure : sélectionnez un numéro pour porter l''armure');
  deplacerCurseurXY(5,28); write('0/ Retourner au menu de sélection des objets');
  deplacerCurseurXY(5,29); write('Votre choix : ');
end;

// Affichage d'une seule armure dans l'armoire
procedure afficherArmureIHM(armure : typeArmure; numeroArmure : integer; derniereLigne : boolean);
begin
  // Affichage du numéro
  deplacerCurseurXY(5,numeroArmure+5);
  write(numeroArmure);
  // Affichage du nom
  deplacerCurseurXY(15,numeroArmure+5);
  write(armure.nom);
  // Affichage de l'élément de l'arme
  deplacerCurseurXY(70,numeroArmure +5); write(armure.element);
  // Affichage du taux d'attaque de l'arme en vert si c'est supérieur à l'arme que l'on porte et en rouge sinon
  //deplacerCurseurXY(85,numeroArmure +5);
  //if (armure.valeurDefense > getJoueur.armuresPortees) then
  //begin
  //     couleurTexte(Green);
  //     write('+', (arme.valeurAttaque - getJoueur.armePortee.valeurAttaque):6:2);
  //end
  //else if (arme.valeurAttaque < getJoueur.armePortee.valeurAttaque) then
  //begin
  //     couleurTexte(Red);
  //     write('-',(getJoueur.armePortee.valeurAttaque - arme.valeurAttaque):6:2);
  //end
  //else
  //    write('+ 0');
  //couleurTexte(White);
  //if derniereLigne then deplacerCurseurXY(18,29);
end;

// ----------------------------------------------------- MALLE --------------------------------------------------------
// IHM de la malle des armes
procedure malleIHM();
begin
  effacerEcran();
  cadrePrincipal('Malle à armes');
  deplacerCurseurXY(10,28); write(' 0/ Retourner à la chambre ');
  deplacerCurseurXY(85,28); write(' Votre choix :   ');
end;

// Affiche l'entête des colonnes pour la malle
procedure enteteMalleIHM();
begin
  // Entête du numéro
  deplacerCurseurXY(13,6);write('Numéro');
  // Entête du nom
  deplacerCurseurXY(30,6); write('Nom');
  // Entête du type d'arme
  deplacerCurseurXY(62,6); write('Type');
  // Entête de l'élément de l'arme
  deplacerCurseurXY(78,6); write('Élément');
  // Entête de la valeur d'attaque
  deplacerCurseurXY(95,6); write('Bonus d''attaque');

  deplacerCurseurXY(100, 28);
end;

// Affichage d'une seule arme dans la malle
procedure afficherArmeIHM(arme : typeArme; numeroArme : integer; derniereLigne : boolean);
begin
  // Affichage du numéro
  deplacerCurseurXY(15,numeroArme+7);
  write(numeroArme);
  // Affichage du nom
  deplacerCurseurXY(30,numeroArme+7);
  write(arme.nom);
  // Affichage du type d'arme
  deplacerCurseurXY(62,numeroArme +7); write(arme.arme);
  // Affichage de l'élément de l'arme
  deplacerCurseurXY(78,numeroArme +7); write(arme.element);


  // Affichage du bonus d'attaque en vert ou en rouge
  deplacerCurseurXY(99,numeroArme +7);
  if (arme.valeurAttaque > getJoueur.armePortee.valeurAttaque) then
  begin
       couleurTexte(Green);
       write('+', (arme.valeurAttaque - getJoueur.armePortee.valeurAttaque):6:2);
  end
  else if (arme.valeurAttaque < getJoueur.armePortee.valeurAttaque) then
  begin
       couleurTexte(Red);
       write('-',(getJoueur.armePortee.valeurAttaque - arme.valeurAttaque):6:2);
  end
  else
      write('+ 0');
  couleurTexte(White);

  deplacerCurseurXY(100, 28);

end;

// ----------------------------------------------------- CHAMBRE ------------------------------------------------------
// IHM de la chambre
function chambreIHM() : string;
begin
  effacerEcran();
  cadrePrincipal('Chambre');

  // Affichage de l'arme
  dessinerSansEspace('dessins/personnagesEnGrand/armes/' + getEnumName(TypeInfo(typePieceArme),ord(getJoueur.armePortee.arme)) + '.txt',43,5);
  deplacerCurseurXY(10,8); write('Arme : ', getJoueur.armePortee.nom);
  deplacerCurseurXY(10,9); write('Valeur d''ataque : ', getJoueur.armePortee.valeurAttaque:6:2);


  // On affiche un personnage au milieu qui porte chaque partie d'armure ou non
  // Torse
  if getJoueur.armurePortee[1]. nom = 'NULL' then
  begin
       // Torse dépend du sexe
       if getJoueur.sexe = 'M' then dessinerSansEspace('dessins/personnagesEnGrand/homme/torseHomme.txt',49,11)
       else dessinerSansEspace('dessins/personnagesEnGrand/femme/torseFemme.txt',49,11);
       // Si le joueur ne porte pas le type d'armure on affiche un message
       deplacerCurseurXY(80,14); write('Vous ne portez pas de plastron');
  end
  // Si le joueur porte un plastron
  else
  begin
       dessinerSansEspace('dessins/personnagesEnGrand/chevalier/plastronChevalier.txt',49,11);
       deplacerCurseurXY(80,14); write('Torse : ', getJoueur.armurePortee[1].nom);
       deplacerCurseurXY(80,15); write('Valeur de défense : ', getJoueur.armurePortee[1].valeurDefense:6:2);
       deplacerCurseurXY(80,16); write('Taux d''equive : ', getJoueur.armurePortee[1].tauxEsquive:6:2);
  end;


  // Tête
  if getJoueur.armurePortee[0]. nom = 'NULL' then
  begin
       // Tête dépend du sexe
       if getJoueur.sexe = 'M' then dessinerSansEspace('dessins/personnagesEnGrand/homme/teteHomme.txt',55,6)
       else dessinerSansEspace('dessins/personnagesEnGrand/femme/teteFemme.txt',55,6);
       deplacerCurseurXY(80,8); write('Vous ne portez pas de casque');
  end
  // Si le joueur porte un casque
  else
  begin
       dessinerSansEspace('dessins/personnagesEnGrand/chevalier/casqueChevalier.txt',55,6);
       deplacerCurseurXY(80,8); write('Casque : ', getJoueur.armurePortee[0].nom);
       deplacerCurseurXY(80,9); write('Valeur de défense : ', getJoueur.armurePortee[0].valeurDefense:6:2);
       deplacerCurseurXY(80,10); write('Taux d''equive : ', getJoueur.armurePortee[0].tauxEsquive:6:2);
  end;


  // Jambières
  if getJoueur.armurePortee[2]. nom = 'NULL' then
  begin
       dessinerSansEspace('dessins/personnagesEnGrand/homme/jambesHomme.txt',56,17);
       deplacerCurseurXY(80,19); write('Vous ne portez pas de jambières');
  end
  else
  begin
       dessinerSansEspace('dessins/personnagesEnGrand/chevalier/jambieresChevalier.txt',56,17);
       deplacerCurseurXY(80,19); write('Jambières : ', getJoueur.armurePortee[2].nom);
       deplacerCurseurXY(80,18); write('Valeur de défense : ', getJoueur.armurePortee[2].valeurDefense:6:2);
       deplacerCurseurXY(80,20); write('Taux d''equive : ', getJoueur.armurePortee[2].tauxEsquive:6:2);
  end;


  // Bottes
  if getJoueur.armurePortee[3]. nom = 'NULL' then
  begin
       dessinerSansEspace('dessins/personnagesEnGrand/homme/piedsHomme.txt',55,24);
       deplacerCurseurXY(80,25); write('Vous ne portez pas de bottes');
  end
  else
  begin
    dessinerSansEspace('dessins/personnagesEnGrand/chevalier/bottesChevalier.txt',55,24);
    deplacerCurseurXY(80,25); write('Bottes : ', getJoueur.armurePortee[3].nom);
    deplacerCurseurXY(80,26); write('Valeur de défense : ', getJoueur.armurePortee[3].valeurDefense:6:2);
       deplacerCurseurXY(80,27); write('Taux d''equive : ', getJoueur.armurePortee[3].tauxEsquive:6:2);
  end;


  // Gants
  if getJoueur.armurePortee[4]. nom = 'NULL' then
  begin
       dessinerSansEspace('dessins/personnagesEnGrand/homme/mainsHomme.txt',47,12);
       deplacerCurseurXY(10,19); write('Vous ne portez pas de gants');
  end
  else
  begin
    dessinerSansEspace('dessins/personnagesEnGrand/chevalier/gantsChevalier.txt',47,12);
    deplacerCurseurXY(10,19); write('Gants : ', getJoueur.armurePortee[4].nom);
    deplacerCurseurXY(10,20); write('Valeur de défense : ', getJoueur.armurePortee[4].valeurDefense:6:2);
    deplacerCurseurXY(10,21); write('Taux d''equive : ', getJoueur.armurePortee[4].tauxEsquive:6:2);
  end;


  deplacerCurseurXY(7,28); write(' 0/ Retourner à la ville  1/ Malle  2/ Armoire  3/ Se reposer ');
  deplacerCurseurXY(91,28); write(' Votre choix :   '); deplacerCurseurXY(106,28);
  readln(chambreIHM);
end;


end.

