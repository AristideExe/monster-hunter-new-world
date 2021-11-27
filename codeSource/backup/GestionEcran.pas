unit GestionEcran;

interface
    uses SysUtils, Windows;

    // représente une coordonnée à l'écran (0,0 = coin haut-gauche)
    type coordonnees = record
      x : integer;
      y : integer;
    end;

    // permet d'indiquer si l'on souhaite une bordure simple ou double
    // pour les cadres
    type typeBordure = (simple, double);

    // supprime tous les caractères de l'écran mais ne change pas les couleurs
    // de fond
    procedure effacerEcran;

//----------------------------------Ajouts----------------------------------

    // Procédure que l'on a rajouté pour dessiner avec un fichier texte avec les espaces
    procedure dessiner(cheminFichier : string; decalageX, decalageY : integer);

    //Dessine à partir d'un fichier texte en ignorant les espaces
     procedure dessinerSansEspace(cheminFichier : string; decalageX, decalageY : integer);

     //Dessine à partir d'un fichier texte en ignorant les espaces et en gérant la couleur
     procedure dessinCouleurSansEspaces(cheminFichier : string; decalageX, decalageY : integer);

//--------------------------------------------------------------------------

    // Change la taille de la fenetre
    procedure changerTailleConsole(largeur,hauteur : Integer);

    // supprime tous les caractères de l'écran et colorie le fond dans la couleur
    // désirée (cette couleur est gardée comme couleur de fond par défaut et la
    // couleur du texte est conservée)
    procedure effacerEtColorierEcran(couleur : Byte);

    // déplace le curseur à la position donnée
    procedure deplacerCurseur(position : coordonnees);

    // déplace le curseur aux coordonnées X, Y
    procedure deplacerCurseurXY(x, y : integer);

    // retourne la position actuelle du curseur
    function  positionCurseur() : coordonnees;

    // change la ligne du curseur sans changer la colonne
    procedure changerLigneCurseur(position : integer);

    // change la colonne du curseur sans changer la ligne
    procedure changerColonneCurseur(position : integer);

    // affiche le texte à la position donnée
    procedure ecrireEnPosition(position : coordonnees; texte: string);

    // dessine un cadre à partir des coordonnées des points haut-gauche
    // et bas-droite, du type de bordure, de la couleur de trait et de
    // la couleur de fond
    procedure dessinerCadreXY(x,y,x2,y2 : integer; t : typeBordure; coulTrait, coulFond : byte);
    procedure dessinerCadre(c1, c2 : coordonnees; t : typeBordure; ct, cf : byte);

    // attends le nombre de ms indiqué
    procedure attendre(millisecondes : integer);

    // change la couleur de fond actuelle
    procedure couleurFond(couleur : Byte);

    // change la couleur de texte actuelle
    procedure couleurTexte(couleur : Byte);

	// change la couleur de texte et de fond
	procedure couleurs(ct, cf : byte);

	// Change la couleur de la zone
    procedure ColorierZone(couleur : Byte ;couleurT : Byte; xStart,xEnd,y:Integer);

    //Affiche un cadre avec une zone de text
    procedure CadrePrincipal(titre :String);

    const
      // Codes des couleurs
      Black        = 0;
      Blue         = 1;
      Green        = 2;
      Cyan         = 3;
      Red          = 4;
      Magenta      = 5;
      Brown        = 6;
      LightGray    = 7;
      DarkGray     = 8;
      LightBlue    = 9;
      LightGreen   = 10;
      LightCyan    = 11;
      LightRed     = 12;
      LightMagenta = 13;
      Yellow       = 14;
      White        = 15;

implementation

    procedure effacerEcran;
    var
      stdOutputHandle : Cardinal;
      cursorPos       : TCoord;
      width, height   : Cardinal;
      nbChars         : Cardinal;
	  TextAttr		  : Byte;
    begin
      stdOutputHandle := GetStdHandle(STD_OUTPUT_HANDLE);
      cursorPos := GetLargestConsoleWindowSize(stdOutputHandle);
      width := cursorPos.X;
      height := cursorPos.Y;
      cursorPos.X := 0;
      cursorPos.Y := 0;
      TextAttr := $0;
      FillConsoleOutputCharacter(stdOutputHandle, ' ', width*height, cursorPos, nbChars);
      FillConsoleOutputAttribute(stdOutputHandle, TextAttr, width*height, cursorPos, nbChars);
      cursorPos.X := 0;
      cursorPos.Y := 0;
      SetConsoleCursorPosition(stdOutputHandle, cursorPos);
      couleurFond(0);
    end;

    procedure changerTailleConsole(largeur,hauteur : Integer);
    var
       Con: THandle;
       Size: TCoord;
       Rect: TSmallRect;
       Wnd: HWND;
    begin
        effacerEcran();
        Con := GetStdHandle(STD_OUTPUT_HANDLE);
        Size := GetLargestConsoleWindowSize(Con);
        Size.X := largeur;
        Size.Y := hauteur;

        SetConsoleScreenBufferSize(Con, Size);

        Rect.Left := -10;
        Rect.Top := -10;
        Rect.Right := Size.X-11;
        Rect.Bottom := Size.Y-11;
        SetConsoleWindowInfo(Con, True, Rect);

        Wnd := GetConsoleWindow;

        SetWindowPos(Wnd, 0, 0, 0, 0, 0, SWP_NOSIZE);
    end;

    procedure ColorierZone(couleur : Byte ;couleurT : Byte; xStart,xEnd,y:Integer);
    var
      LastMode: Word;
      Buffer : CONSOLE_SCREEN_BUFFER_INFO;
      stdOutputHandle : Cardinal;
      cursorPos       : TCoord;
      width, height   : Cardinal;
      nbChars         : Cardinal;
	    TextAttr		  : Byte;
    begin
      couleurTexte(couleurT);
      stdOutputHandle := GetStdHandle(STD_OUTPUT_HANDLE);
      cursorPos := GetLargestConsoleWindowSize(stdOutputHandle);
      GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE),Buffer);
      width := cursorPos.X;
      height := cursorPos.Y;
      cursorPos.X := xStart;
      cursorPos.Y := y;
      LastMode :=  Buffer.wAttributes;
      TextAttr := (LastMode and $0F) or ((couleur shl 4) and $F0);
      FillConsoleOutputAttribute(stdOutputHandle, TextAttr, xEnd-xStart+1, cursorPos, nbChars);
      cursorPos.X := 0;
      cursorPos.Y := 0;
      SetConsoleCursorPosition(stdOutputHandle, cursorPos);
      couleurTexte(white);
    end;

    procedure effacerEtColorierEcran(couleur : Byte);
    var
      LastMode: Word;
      Buffer : CONSOLE_SCREEN_BUFFER_INFO;
      stdOutputHandle : Cardinal;
      cursorPos       : TCoord;
      width, height   : Cardinal;
      nbChars         : Cardinal;
	    TextAttr		  : Byte;
    begin
      stdOutputHandle := GetStdHandle(STD_OUTPUT_HANDLE);
      cursorPos := GetLargestConsoleWindowSize(stdOutputHandle);
      GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE),Buffer);
      width := cursorPos.X;
      height := cursorPos.Y;
      cursorPos.X := 0;
      cursorPos.Y := 0;
      LastMode :=  Buffer.wAttributes;
      TextAttr := (LastMode and $0F) or ((couleur shl 4) and $F0);
      FillConsoleOutputCharacter(stdOutputHandle, ' ', width*height, cursorPos, nbChars);
	    FillConsoleOutputAttribute(stdOutputHandle, TextAttr, width*height, cursorPos, nbChars);
      couleurFond(couleur);
      cursorPos.X := 0;
      cursorPos.Y := 0;
      SetConsoleCursorPosition(stdOutputHandle, cursorPos);
    end;

        procedure deplacerCurseur(position : coordonnees);
    var
      stdOutputHandle : Cardinal;
      cursorPos       : TCoord;
    begin
      stdOutputHandle := GetStdHandle(STD_OUTPUT_HANDLE);
      cursorPos.X := position.x;
      cursorPos.Y := position.y;
      SetConsoleCursorPosition(stdOutputHandle, cursorPos);
    end;

    procedure deplacerCurseurXY(x, y : integer);
    var c : coordonnees;
    begin
      c.x := x;
      c.y := y;
      deplacerCurseur(c);
    end;

//---------------------------------------Ajouts---------------------------------------

    //Convertie de hexadécimal à byte
    function hexToByte(hexa:Char):Byte;
    var
      hexadecimal : string;
      i : integer;
    begin
      hexadecimal:='0123456789ABCDEF';

      for i := 1 to 16 do
      begin

        if hexadecimal[i] = hexa then hexToByte := i -1;

      end;

    end;

    //Dessine à partir d'un fichier texte avec les espaces
    procedure dessiner(cheminFichier : string; decalageX, decalageY : integer);
    var
       fichier : textFile;
       ligne : string;
       compteurLigne : integer;
    begin
      assignFile(fichier, cheminFichier);
      reset(fichier);
      compteurLigne := 0;
      repeat
        readln(fichier,ligne);
        deplacerCurseurXY(decalageX,decalageY+compteurLigne);
        write(ligne);
        compteurLigne := compteurLigne +1
      until(EOF(fichier));
      closeFile(fichier);
    end;

    //Dessine à partir d'un fichier texte en ignorant les espaces
     procedure dessinerSansEspace(cheminFichier : string; decalageX, decalageY : integer);
    var
       fichier : textFile;
       ligne : string;
       compteurLigne : integer;
       caractere : integer;

    begin
      assignFile(fichier, cheminFichier);
      reset(fichier);
      compteurLigne := 0;
      repeat
        readln(fichier,ligne);
        deplacerCurseurXY(decalageX,decalageY+compteurLigne);

        //Pour chaque caractère de la ligne
        for caractere:=1 to length(ligne) do
        begin

          if ligne[caractere] = '#' then          //On regarde si le caractère doit etre considéré comme invisible
            write(' ')

          else if ligne[caractere] <> ' ' then
            write(ligne[caractere]);

          deplacerCurseurXY(decalageX+caractere,decalageY+compteurLigne);

        end;

        compteurLigne := compteurLigne +1

      until(EOF(fichier));
      closeFile(fichier);
    end;

     //Dessine à partir d'un fichier texte en ignorant les espaces et en gérant la couleur
     procedure dessinCouleurSansEspaces(cheminFichier : string; decalageX, decalageY : integer);
     var
        fichier : textFile;
        ligne : string;
        compteurLigne : integer;
        caractere : integer;
        compteurDecalage : integer;

     begin
       assignFile(fichier, cheminFichier);
       reset(fichier);
       compteurLigne := 0;

       repeat
         readln(fichier,ligne);
         deplacerCurseurXY(decalageX,decalageY+compteurLigne);
         compteurDecalage:=0;   //On initialise le décalage de caractère a 0 (causé par les changemments de couleurs)

         //Pour chaque caractère de la ligne
         for caractere:=1 to length(ligne) do
         begin
           //Si le caractère est un changement de couleur
           if  (ligne[caractere] = '&') then
           begin
             couleurTexte(hexToByte(ligne[caractere+1]));    //On convertie la couleur hexadécimal en byte et on change la couleur
             //deplacerCurseurXY(decalageX-1,decalageY+compteurLigne); //On retouche le décalage
             compteurDecalage:= compteurDecalage + 2;
           end;

           ////Sinon si le caractère d'avant était un indicateur de couleur
           //else if (ligne[caractere - 1] = '&') then   deplacerCurseurXY(decalageX-1,decalageY+compteurLigne); //On retouche le décalage

           if ligne[caractere] = '#' then          //On regarde si le caractère doit etre considéré comme invisible
             write(' ')

           else if (ligne[caractere-1]<>'&') and (ligne[caractere]<>'&') then  //Si le caractère n'est pas un caractère de changement de couleur
           begin

             if (ligne[caractere] <> ' ') then      //Si ce n'est pas un espace
             begin
                write(ligne[caractere]);            //On écrit le caractère
             end;

             deplacerCurseurXY(decalageX + caractere - compteurDecalage,decalageY+compteurLigne); //On regarde si il y a une décalage a faire
           end

         end;

         compteurLigne := compteurLigne +1

       until(EOF(fichier));
       closeFile(fichier);

       couleurTexte(15);    //On remet le texte en blanc
     end;

//------------------------------------------------------------------------------------

    function positionCurseur() : coordonnees;
    var
      stdOutputHandle : Cardinal;
      CSBI: TConsoleScreenBufferInfo;
      pos : TCoord;
      res : coordonnees;
    begin
      stdOutputHandle := GetStdHandle(STD_OUTPUT_HANDLE);
      GetConsoleScreenBufferInfo(stdOutputHandle, CSBI);
      pos := CSBI.dwCursorPosition;
      res.x := pos.X;
      res.y := pos.Y;
      positionCurseur := res;
    end;

    procedure changerLigneCurseur(position : integer);
    var c : coordonnees;
    begin
      c := positionCurseur();
      c.y := position;
      deplacerCurseur(c);
    end;

    procedure changerColonneCurseur(position : integer);
    var c : coordonnees;
    begin
      c := positionCurseur();
      c.x := position;
      deplacerCurseur(c);
    end;

    procedure ecrireEnPosition(position : coordonnees; texte: string);
    begin
      deplacerCurseur(position);
      write(texte);
    end;

    procedure dessinerCadre(c1, c2 : coordonnees; t : typeBordure; ct, cf : byte);
    type typeBords = (CHG, H, CHD, V, CBG, CBD);
    type tabBordures = array[typeBords] of char;
    const bordsSimples : tabBordures = (#218, #196, #191, #179, #192, #217);
          bordsDoubles : tabBordures = (#201, #205, #187, #186, #200, #188);
    var bords : tabBordures;
        i, j : integer;
    begin
      // changement de couleur
	  couleurs(ct, cf);

      // on choisit la bordure
      if t = simple then
        bords := bordsSimples
      else
        bords := bordsDoubles;

      // on dessine la ligne du haut
      deplacerCurseur(c1);
      write(bords[CHG]);
      for i := c1.x+1 to c2.x-1 do
        write(bords[H]);
      write(bords[CHD]);

      // on dessine les lignes intermédiaires
      for i := c1.y+1 to c2.y-1 do
      begin
        deplacerCurseurXY(c1.x, i);
        write(bords[V]);
        for j := c1.x+1 to c2.x-1 do
          write(' ');
        write(bords[V]);
      end;

      // on dessine la ligne du bas
      deplacerCurseurXY(c1.x, c2.y);
      write(bords[CBG]);
      for i := c1.x+1 to c2.x-1 do
        write(bords[H]);
      write(bords[CBD]);

    end;

    procedure dessinerCadreXY(x,y,x2,y2 : integer; t : typeBordure; coulTrait, coulFond : byte);
    var c1, c2 : coordonnees;
    begin
      c1.x := x;
      c1.y := y;
      c2.x := x2;
      c2.y := y2;
      dessinerCadre(c1, c2, t, coulTrait, coulFond);
    end;

    procedure attendre(millisecondes : integer);
    begin
      sleep(millisecondes);
    end;

	procedure couleurs(ct, cf : byte);
    begin
      couleurTexte(ct);
	  couleurFond(cf);
    end;

  procedure couleurTexte(couleur : Byte);
    var LastMode: Word;
        Buffer : CONSOLE_SCREEN_BUFFER_INFO;
        TextAttr: Byte;
    begin
      GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE),Buffer);
      LastMode :=  Buffer.wAttributes;
      TextAttr := (LastMode and $F0) or (couleur and $0F);
      SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), TextAttr);
    end;

    procedure couleurFond(couleur : Byte);
    var LastMode: Word;
        Buffer : CONSOLE_SCREEN_BUFFER_INFO;
        TextAttr: Byte;
    begin
      GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE),Buffer);
      LastMode :=  Buffer.wAttributes;
      TextAttr := (LastMode and $0F) or ((couleur shl 4) and $F0);
      SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), TextAttr);
    end;

    procedure CadrePrincipal(titre :String);
    var
        decalage,i:integer;
    begin
         decalage:=40;
         dessinerCadreXY(4,2,116,28,double,White,Black);
         deplacerCurseurXY(38,2);write('{ ',titre,' }');
         deplacerCurseurXY(39,1);write('/');
         deplacerCurseurXY(39,3);write('\');
         for i:=0 to length(titre)-1 do
         begin
              deplacerCurseurXY(decalage+i,0);write('_');
              deplacerCurseurXY(decalage+i,3);write('_');
         end;
         deplacerCurseurXY(decalage+length(titre),1);write('\');
         deplacerCurseurXY(decalage+length(titre),3);write('/');
    end;

end.
