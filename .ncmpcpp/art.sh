#!/usr/bin/env bash

#-------------------------------#
# Generate current song cover   #
# ffmpeg version                #
#-------------------------------#

MUSIC_DIR="$HOME/Music"
COVER="/tmp/cover.png"
COVER_SIZE=300
# COVER_SIZE=10

BORDERS=false
BORDER_WIDTH=5
BORDER_COLOR="white"

function ffmpeg_cover {
    if $BORDERS; then
        ffmpeg -loglevel 0 -y -i "$1" -vf "scale=$COVER_SIZE:-1,pad=$COVER_SIZE+$BORDER_WIDTH:ow:(ow-iw)/2:(oh-ih)/2:$BORDER_COLOR" "$COVER"
    else
        ffmpeg -loglevel 0 -y -i "$1" -vf "scale=$COVER_SIZE:-1" "$COVER"
	# ffmpeg -loglevel 0 -y -i "Thrice.mp3" -vf "scale=$COVER_SIZE:-1" "$COVER"
    fi
}

function fallback_find_cover {
    album="${file%/*}"
    album_cover="$(find "$album" -type d -exec find {} -maxdepth 1 -type f -iregex ".*/.*\(cover\|folder\|artwork\|front\|scans\).*[.]\(jpe?g\|png\|gif\|bmp\)" \;)"
    if [ "$album_cover" == "" ]; then
        album_cover="$(find "$album" -type d -exec find {} -maxdepth 1 -type f -iregex ".*[.]\(jpe?g\|png\|gif\|bmp\)" \;)"
    fi
    album_cover="$(echo -n "$album_cover" | head -n1)"
}

{
    file="$MUSIC_DIR/$(mpc --format %file% current)"

    if [[ -n "$file" ]] ; then
        if ffmpeg_cover "$file"; then
            exit
        else
            fallback_find_cover
            ffmpeg_cover "$album_cover"
        fi
    fi
} &
