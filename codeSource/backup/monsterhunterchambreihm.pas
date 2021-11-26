unit monsterHunterChambreIHM;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface

uses
  Classes, SysUtils, GestionEcran, monsterHunterJoueur, monsterHunterArmesEtArmures;

// IHM de la chambre
procedure chambreIHM();
// Affiche l'arme portée dans la chambre
procedure afficherArmeChambreIHM(arme : typeArme);
// IHM de l'armoire à armures
procedure armoireIHM();
// Affichage d'une seule armure dans l'armoire
procedure afficherArmureIHM(armure : typeArmure; numeroArmure : integer; derniereLigne : boolean);
// Affichage d'une seule arme dans la malle
procedure afficherArmeIHM(arme : typeArme; numeroArme : integer; derniereLigne : boolean);
// IHM de la malle des armes
procedure malleIHM();
// Menu de sélection pour savoir quelle armure on veut afficher
function selectionArmureArmoireIHM() : string;

// =========================================================================== IMPLEMENTATION ===================================================================================
implementation

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
  deplacerCurseurXY(5,1); write('Malle à armes : sélectionnez un numéro pour porter l''arme');
  deplacerCurseurXY(5,28); write('0/ Retourner à la chambre');
  deplacerCurseurXY(5,29); write('Votre choix : ');
end;

// Affichage d'une seule arme dans la malle
procedure afficherArmeIHM(arme : typeArme; numeroArme : integer; derniereLigne : boolean);
begin
  // Affichage du numéro
  deplacerCurseurXY(5,numeroArme+5);
  write(numeroArme);
  // Affichage du nom
  deplacerCurseurXY(15,numeroArme+5);
  write(arme.nom);
  // Affichage du type d'arme
  deplacerCurseurXY(55,numeroArme +5); write(arme.arme);
  // Affichage de l'élément de l'arme
  deplacerCurseurXY(70,numeroArme +5); write(arme.element);
  // Affichage du taux d'attaque de l'arme en vert si c'est supérieur à l'arme que l'on porte et en rouge sinon
  deplacerCurseurXY(85,numeroArme +5);
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
  if derniereLigne then deplacerCurseurXY(18,29);
end;

// ----------------------------------------------------- CHAMBRE ------------------------------------------------------
// IHM de la chambre
procedure chambreIHM();
begin
  effacerEcran();
  deplacerCurseurXY(5,1); write('Chambre');

  // On affiche un personnage au milieu qui porte chaque partie d'armure ou non
  // Torse
  if getJoueur.armurePortee[1]. nom = 'NULL' then
  begin
       // Torse dépend du sexe
       if getJoueur.sexe = 'M' then dessinerSansEspace('dessins/personnagesEnGrand/homme/torseHomme.txt',49,8)
       else dessinerSansEspace('dessins/personnagesEnGrand/femme/torseFemme.txt',49,8);
       // Si le joueur ne porte pas le type d'armure on affiche un message
       deplacerCurseurXY(80,11); write('Vous ne portez pas de plastron');
  end
  // Si le joueur porte un plastron
  else
  begin
       dessinerSansEspace('dessins/personnagesEnGrand/chevalier/plastronChevalier.txt',49,8);
       deplacerCurseurXY(80,11); write('Torse : ', getJoueur.armurePortee[1].nom);
  end;


  // Tête
  if getJoueur.armurePortee[0]. nom = 'NULL' then
  begin
       // Tête dépend du sexe
       if getJoueur.sexe = 'M' then dessinerSansEspace('dessins/personnagesEnGrand/homme/teteHomme.txt',55,3)
       else dessinerSansEspace('dessins/personnagesEnGrand/femme/teteFemme.txt',55,3);
       deplacerCurseurXY(80,5); write('Vous ne portez pas de casque');
  end
  // Si le joueur porte un casque
  else
  begin
       dessinerSansEspace('dessins/personnagesEnGrand/chevalier/casqueChevalier.txt',55,3);
       deplacerCurseurXY(80,5); write('Casque : ', getJoueur.armurePortee[0].nom);
  end;


  // Jambières
  if getJoueur.armurePortee[2]. nom = 'NULL' then
  begin
       dessinerSansEspace('dessins/personnagesEnGrand/homme/jambesHomme.txt',56,14);
       deplacerCurseurXY(80,16); write('Vous ne portez pas de jambières');
  end
  else
  begin
       dessinerSansEspace('dessins/personnagesEnGrand/chevalier/jambieresChevalier.txt',56,14);
  end;


  // Bottes
  if getJoueur.armurePortee[3]. nom = 'NULL' then
  begin
       dessinerSansEspace('dessins/personnagesEnGrand/homme/piedsHomme.txt',55,21);
       deplacerCurseurXY(80,22); write('Vous ne portez pas de bottes');
  end
  else
  begin
    dessinerSansEspace('dessins/personnagesEnGrand/chevalier/bottesChevalier.txt',55,21);
  end;


  // Gants
  if getJoueur.armurePortee[4]. nom = 'NULL' then
  begin
       dessinerSansEspace('dessins/personnagesEnGrand/homme/mainsHomme.txt',47,10);
       deplacerCurseurXY(10,14); write('Vous ne portez pas de gants');
  end
  else
  begin
    dessinerSansEspace('dessins/personnagesEnGrand/chevalier/gantsChevalier.txt',47,10);
  end;


  deplacerCurseurXY(5,28); write('0/ Retourner à la ville       1/ Ouvrir la malle à armes       2/ Ouvrir l''armoire à armures');
  deplacerCurseurXY(5,29); write('Votre choix : ');
end;


// Affiche l'arme portée dans la chambre
procedure afficherArmeChambreIHM(arme : typeArme);
begin
  //deplacerCurseurXY(80,15); write(arme.nom);
  deplacerCurseurXY(19,29);
end;



end.

