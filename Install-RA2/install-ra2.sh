#!/bin/bash

# download & build OpenRA
    git clone https://github.com/OpenRA/OpenRA
    cd OpenRA
    
    #  git checkout master
    # master branch crashes as the mod is loading
    git checkout 9f8261514a9717b0c26ca474d6acce0e20a01e9a
    # checkout latest commit at time of writing so future builds use the same version
    
    make dependencies
    make all
    #  make version
    # since the mod doesn't have a make version command
    cd ..

# download & build RA2
    git clone https://github.com/OpenRA/ra2
    cd ra2
    
    git checkout 549eec75f9a6d862fe150431c98abfc78f73c265
    # checkout latest commit at time of writing so future builds use the same version

    

# rm -r "../OpenRA/mods/cnc"

# echo "To play with the RA2 mod, use: $(dirname $(pwd))/OpenRA/OpenRA.exe"
# xdg-open $(dirname $(pwd))/OpenRA
