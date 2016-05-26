mkdir -p "~/.openra/Content/cnc"
if [ ! -e cnc1_movies_full.rar ]; then
    wget "http://download.digiex.net/Games/C&C Gold/cnc1_movies_full.rar"
fi
7z e cnc1_movies_full.rar -o"~/.openra/Content/cnc"
