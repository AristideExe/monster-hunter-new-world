unit monsterHunterChambreIHM;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface

uses
  Classes, SysUtils, GestionEcran, monsterHunterJoueur;

// =========================================================================== IMPLEMENTATION ===================================================================================
implementation

{Chambre : 3 choix :
- 1 : retourner à la ville
- 2 : ouvrir l'armoire des armures
- 3 : ouvrir le coffre des armes}
//function chambreIHM() : string;
//var
//  i : integer;
//begin
//     effacerEcran();
//     // Titre du menu
//     deplacerCurseurXY(5,1);write('Chambre');
//     // Affichage des armures
//     for i:=0 to 4 do
//     begin
//          deplacerCurseurXY(10,i*5+3);
//          // Si le joueur porte une pièce d'armure
//          if (getJoueur.armurePortee[i].nom <> 'NULL') then
//          begin
//               write(typePieceArmure(i),' : ',getJoueur.armurePortee[i].nom);
//               deplacerCurseurXY(10,i*5+4);
//               write('Valeur de defense :',getJoueur.armurePortee[i].valeurDefense:6:2, ' , Taux d''esquive :', getJoueur.armurePortee[i].tauxEsquive:6:2);
//          end
//          // Si le joueur ne porte pas de piece d'armure
//          else
//          begin
//               write('Pas de ', typePieceArmure(i) , ' equipe(es).');
//          end;
//     end;
//
//     // Affichage des stats de l'arme
//     deplacerCurseurXY(70,14); write(getJoueur.armePortee.arme,' : ',getJoueur.armePortee.nom);
//     deplacerCurseurXY(70,15); write('Valeur d''attaque : ', getJoueur.armePortee.valeurAttaque:6:2);
//
//     // Affichage des choix
//     deplacerCurseurXY(5,27); write('1/ Retourner a la ville,    2/ Ouvrir l''armoire a armures,    3/ Ouvrir la malle a armes');
//     deplacerCurseurXY(5,28); write('Votre choix : ');
//     readln(chambreIHM);
//end;
//
end.

