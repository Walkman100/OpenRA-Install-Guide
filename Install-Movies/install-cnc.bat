IF NOT EXIST cnc1_movies_full.rar (
..\utilities\wget "http://download.digiex.net/Games/C&C Gold/cnc1_movies_full.rar"
)
mkdir "%UserProfile%\Documents\OpenRA\Content\cnc"
..\utilities\7z e cnc1_movies_full.rar -o"%UserProfile%\Documents\OpenRA\Content\cnc"
