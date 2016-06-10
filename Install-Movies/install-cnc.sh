if [ ! -e cnc1_movies_full.rar ]; then
    wget "http://download.digiex.net/Games/C&C Gold/cnc1_movies_full.rar"
fi
CnCMoviesPath=$HOME/.openra/Content/cnc
mkdir -p $CnCMoviesPath
unrar e cnc1_movies_full.rar $CnCMoviesPath
mv $CnCMoviesPath/MOVIES.MIX $CnCMoviesPath/movies.mix
