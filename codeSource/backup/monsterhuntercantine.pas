unit monsterHunterCantine;

{$mode objfpc}{$H+}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils;

type
  typeNourriture = record
    nom : string;
    prixAchat : integer;
    bonusVie : integer;
    bonusVitesse : integer;
  end;

const
  NOMBRE_NOURRITURES_JEU = 4;

var
  nourrituresDisponibles : array [0..NOMBRE_NOURRITURES_JEU-1] of typeNourriture;

procedure cantine();
// Procédure qui remplie la variable des nourritures disponibles depuis le fichier csv
procedure remplirNourrituresDisponibles(fichier : string);




// =========================================================================== IMPLEMENTATION ===================================================================================
implementation

// ------------------------------------------------- CANTINE -----------------------------------------------
procedure cantine();
begin

end;

// Procédure qui remplie la variable des nourritures disponibles depuis le fichier csv
procedure remplirNourrituresDisponibles(fichier : string);
var
  fichierNourriture : TextFile;
  ligne : string;
  listeLigne : array of string;
  compteur : integer;
begin
  assignFile(fichierNourriture, fichier);
  reset(fichierNourriture);
  // Lecture de la première ligne du fichier qui sert d'entête
  readln(fichierNourriture);
  compteur := 0;
  // On lit chaque ligne jusqu'à la fin du fichier
  repeat
        readln(fichierNourriture,ligne);
        // On transforme la ligne en une liste
        listeLigne:= ligne.Split(';'); //ligne.Split(';'); //splitString(ligne,';');

        // On remplie la liste des crafts disponibles avec tous les champs du csv
        nourrituresDisponibles[compteur].nom := ligneLigne[0];
        nourrituresDisponibles[compteur].prixAchat := trToInt(slisteLigne[1]);
        nourrituresDisponibles[compteur].bonusVie := trToInt(slisteLigne[2]);
        nourrituresDisponibles[compteur].bonusVitesse := trToInt(slisteLigne[3]);
        compteur := compteur +1;
  until EOF(fichierNourriture);
end;

end.

