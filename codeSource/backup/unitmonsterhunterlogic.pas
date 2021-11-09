unit unitMonsterHunterLogic;

{$mode objfpc}{$H+}

interface

// Menu principal
procedure menu();







implementation
uses
  Classes, SysUtils,unitmonsterhunterhim;


procedure creationPersonnage();
begin
end;


procedure choixSauvegarde();
begin
end;

procedure credits();
begin
end;

procedure quitter();
begin
end;



// Menu principal
procedure menu();
var
     choix : string;
begin
     choix := menuIHM();
     if (choix = '1') then creationPersonnage()
     else if (choix = '2') then choixSauvegarde()
     else if (choix = '3') then credits()
     else quitter();
end;
end.

