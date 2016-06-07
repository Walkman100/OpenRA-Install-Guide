if [ ! -e cnc1_movies_full.rar ]; then
    wget "http://download.digiex.net/Games/C&C Gold/cnc1_movies_full.rar"
fi
mkdir -p "$HOME/.openra/Content/cnc"
unrar e cnc1_movies_full.rar "$HOME/.openra/Content/cnc"
