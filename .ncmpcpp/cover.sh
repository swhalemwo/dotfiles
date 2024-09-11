#!/usr/bin/env bash

#-------------------------------#
# Display current cover         #
# ueberzug version              #
#-------------------------------#

while true
      do

	  echo 1

	  function ImageLayer {
	      # ImageLayer() {
	      ueberzug layer -sp json
	  }

	  COVER="/tmp/cover.png"
	  X_PADDING=0
	  Y_PADDING=1
	  WIDTH=30

	  function add_cover {
	      # add_cover() {
	      if [ -e $COVER ]; then
		  echo "{\"action\": \"add\", \"identifier\": \"cover\", \"x\": $X_PADDING, \"y\": $Y_PADDING, \"max_width\": $WIDTH, \"path\": \"$COVER\"}";	
	      fi
	  }

	  clear
	  ImageLayer -< <(
	      add_cover
	      # while inotifywait -q -q -e close_write "$COVER"; do
	      while inotifywait -e close_write "$COVER"; do
		  add_cover
		  echo 2
	      done
	  )
done	  

