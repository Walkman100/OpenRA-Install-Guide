@echo off
set D2kMoviesPath=%UserProfile%\Documents\OpenRA\Content\d2k\v2\Movies
mkdir "%D2kMoviesPath%"
..\utilities\7z e Dune_2000_Gruntmods_Edition_Cutscenes.exe -o"%D2kMoviesPath%"
del "%D2kMoviesPath%\*.dll" "%D2kMoviesPath%\*.ini" "%D2kMoviesPath%\*.bmp"
