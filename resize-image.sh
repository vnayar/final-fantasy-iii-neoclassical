#!/bin/bash

file=$1
fileBase=${1%.*}
fileSuffix=${1##*.}

outFile=${fileBase}-out.${fileSuffix}

# Scale the image to match the desired vertical dimension.
convert $file -resize x224 $outFile

# We may have extra horizontal padding to crop.
width=$(file $outFile | cut -d' ' -f5)
offset=$(( ($width - 256) / 2 ))

# Crop the image from the horizontal center.
convert $outFile -crop 256x224+${offset}+0 $outFile
