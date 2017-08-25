## OpenRA Install Guide
A complete installation guide without installing from discs including
the music missing from the OpenRA Dune mod

If you have any of the original discs or have disc images, there is
a guide [here](https://github.com/OpenRA/OpenRA/wiki/Game-Content) on how to install
the assets manually, although selecting `Use CD` when you install
the mods should automatically use the disc contents.

## Downloading available assets
- Most of the game files (other than movies) can be downloaded
straight from within OpenRA itself, so you'd want to install OpenRA first:
- http://www.openra.net/download
- Once that has installed, go to the content manager for all 3 mods and click all the download buttons
(click <kbd>Manage Content</kbd> then choose <kbd>Download</kbd>).

### Dune 2000 Music
The music for the Dune2K mod was removed from the download mirrors
because of licensing concerns (see [this PR](https://github.com/OpenRA/OpenRAWeb/pull/268)).

You can still get the zip containing the music from their servers at
`81.169.246.181/d2k-music.zip` or from this repo.

This archive needs to be extracted to the `d2k` mod folder
(see [folder paths](#folder-paths) section), so that the `*.AUD` files end up in the `Music` folder.

If you download this repo, you can use the scripts in [Install-D2K-Music](Install-D2K-Music) to extract `d2k-music.zip` to the right place:
- Windows: run `install.bat` from the Install-D2K-Music folder
- Linux: run `bash install.sh` from the Install-D2K-Music folder
- Mac: Double-click on `d2k-music.zip` in Finder, then drag the resulting `Music` folder to the `Mac-Drag-Here` alias

## Folder Paths
The path for the OpenRA folder differs per operating system,
but they are always (unless a portable installation is used)
contained in a user data folder, not system-wide.

Windows:
- `%USERPROFILE%\My Documents\OpenRA`

Linux:
- `~/.openra`

Mac OSX:
- `~/Library/Application Support/OpenRA`

The folder you will want when installing assets is the `Content` subfolder,
this has a folder for each mod (`cnc`, `d2k`, `ra`) with the mod assets contained (`ra` and `d2k` folders additionally have a `v2` folder within).

In a portable installation (Windows), the folder path will be
`%ProgramFiles%\OpenRA` with a `Support` subfolder instead of `Content`.

## Game Movies/Cinematics
See [Install-Movies/ReadMe.md](Install-Movies#tiberium-dawn)
