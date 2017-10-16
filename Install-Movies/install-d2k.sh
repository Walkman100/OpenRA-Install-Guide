#!/usr/bin/env bash
D2kMoviesPath=$HOME/.openra/Content/d2k/v2/Movies
mkdir -p $D2kMoviesPath
7z e Dune_2000_Gruntmods_Edition_Cutscenes.exe -o$D2kMoviesPath
pushd $D2kMoviesPath
    rm *.dll *.ini *.bmp
popd
