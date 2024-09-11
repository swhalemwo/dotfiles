#!/bin/sh

## preview flextables (written from R as .html files) with surf
## html_diverter needs to be set as browser
## $1 is the dir/name of the index.html, R automatically writes index.html and lib (CSS to that path)

## works by copying the html to some pre-defined location, which is already open in surf (so far manually)

# echo $1 > /tmp/html_preview.html

## want to copy that file to tmp/index.html
mkdir /tmp/pvht/

## copy html file 
cp $1 /tmp/pvht/index.html

## also copy CSS files
cp -r ${1%/*}/lib /tmp/pvht/lib

## maybe can be updated to just copy entire directory

## need to update surf process

pid=$(pidof surf)

kill -1 $pid
