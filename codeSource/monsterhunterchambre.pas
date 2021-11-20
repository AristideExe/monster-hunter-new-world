unit monsterHunterChambre;

{$mode objfpc}{$H+}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils, monsterHunterIHM, monsterHunterArmesEtArmures;

procedure chambre();



// =========================================================================== IMPLEMENTATION ===================================================================================
implementation
uses monsterHunterVille, monsterHunterJoueur;




// ------------------------------------------------- MALLE -----------------------------------------------
procedure malle();
var
  choix : string;
  choixIsInt : boolean;
  choixInt, i, compteurArmes : integer;
begin
  choix := malleIHM();
  choixInt := 0;
  choixIsInt := TryStrToInt(choix,choixInt);

  // Si on veut retourner à la chambre
  if choix = '0' then chambre()

  // Si le joueur a choisi une nouvelle arme
  else if choixIsInt and (choixInt>0) and (choixInt < length(getJoueur.armesPossedees)) then
  begin
       compteurArmes := 0;
       for i:=0 to length(getJoueur.armesPossedees) do
       begin
            if (compteurArmes = choixInt - 1) then echangerArmes(joueur.armePortee,joueur.armesPossedees[i]);
               compteurArmes := compteurArmes +1;
       end;
       chambre();
  end


  else malle();
end;




// ------------------------------------------------- ARMOIRE -----------------------------------------------
procedure armoire(armureAAfficher : integer;titre:string);
var
  choix : string;
  choixIsInt : boolean;
  choixInt : integer;
  pieceArmureChoisie : typePieceArmure;
  i, compteurArmure : integer;
begin
  choix := armoireIHM(armureAAfficher,titre);
  choixInt := 0;
  choixIsInt := TryStrToInt(choix,choixInt);
  // Si on veut retourner à la chambre
  if choix = '0' then chambre()
  // Si on veut afficher un autre type d'armure
  else if choix = '-1' then armoire(0,'Casques')
  else if choix = '-2' then armoire(1,'Plastrons')
  else if choix = '-3' then armoire(2,'Jambieres')
  else if choix = '-4' then armoire(3,'Bottes')
  else if choix = '-5' then armoire(4,'Gants')



  // Si on a choisit une armure
  else if choixIsInt and (choixInt>0) and (choixInt < length(getJoueur.armuresPossedees)) then
  begin
       pieceArmureChoisie := typePieceArmure(armureAAfficher);
       compteurArmure := 0;
       // On essaie de trouver à quelle armure le choix faisait référence
       for i:=0 to length(getJoueur.armuresPossedees) do
       begin
           if (joueur.armuresPossedees[i].pieceArmure = pieceArmureChoisie) and (getJoueur.armuresPossedees[i].nom <> 'NULL') then
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





// ------------------------------------------------- CHAMBRE -----------------------------------------------
procedure chambre();
var choix : string;
begin
  choix := chambreIHM();
  if choix = '1' then ville()
  else if choix = '2' then armoire(0,'Casques')
  else if choix = '3' then malle()
  else chambre();
end;


end.

