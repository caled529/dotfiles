#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash

set -euo pipefail

# Basically makes autoplay work like you'd expect in official Spotify apps
case "$1" in
    "Changed") if [ $2 = $3 ]
    then 
        spotify_player playback start radio --id ${2:14} track 
    fi ;;
esac
