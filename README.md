## OpenRA Install Guide
A complete installation guide without installing from discs including
the music missing from the OpenRA Dune mod

## Downloading available assets
- Most of the game files (other than movies) can be downloaded
straight from within OpenRA itself, so you'd want to install OpenRA first:
- http://www.openra.net/download
- Once that has installed, install all 3 mods by choosing them from the mod installation menu
(click <kbd>Install Assets</kbd>) then choosing <kbd>Download</kbd>.
- After installing all 3 mods, you can install the music for the RA and TD mods automatically:
  - Load up the mod, go to the menu `Extras` then `Music`
  - Click the <kbd>Install music</kbd> button, then <kbd>Download</kbd>

### Dune 2000 Music
The music for the Dune2K mod was removed from the download mirrors
because of licensing concerns (see [this PR](https://github.com/OpenRA/OpenRAWeb/pull/268)).

You can still get the zip containing the music from their servers at
`81.169.246.181/d2k-music.zip` or from this repo.

This archive needs to be extracted to the `d2k` mod folder
(see [folder paths](#folder-paths) section), so that the `*.AUD` files end up in the `Music` folder.

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
this has a folder for each mod (`cnc`, `d2k`, `ra`) with the mod assets contained.
In a portable installation (Windows), the folder path will be
`%ProgramFiles%\OpenRA` with a `Support` subfolder instead of `Content`.

## Game Movies/Cinematics
See [#1](https://github.com/Walkman100/OpenRA-Install-Guide/issues/1) for progress.
