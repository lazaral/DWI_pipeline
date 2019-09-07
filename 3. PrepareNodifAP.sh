#!/bin/env bash

# This script selects nodif images from AP direction
echo "PREPARING NODIF IMAGES"

# definitions
dataDir=/vols/Data/disease/alazari/longitudinal_paTMS/DWI

# list the subjects
subjectList="P1 P2 P3"

# Loop over subjects for AP b0
for subj in $subjectList; do

  echo "FINDING AP NODIFS"
  # establish the subject-specific directory
  rawDir=$dataDir/$subj/dMRI/raw

  # delete previous lists of b0s to not get confused
  rm $rawDir/list_b0.txt

  # extract the b0 from AP images
      #create a new version of bval
      cp $rawDir/bval $rawDir/bval_b0

      #add blank spaces at the beginning and end of bval_b0
      sed -i -e 's/^/ /' $rawDir/bval_b0
      sed -i -e 's/$/ /' $rawDir/bval_b0

      #extract the location of the b0 and crete a .txt file with it
      sed -i "s/ 5 / 6 /g" $rawDir/bval_b0
      sed -i "s/ /\n/g" $rawDir/bval_b0
      grep -o '6' $rawDir/bval_b0 -n >> $rawDir/list_b0.txt

      #polish the .txt file
      sed -i "s/ /\n/g" $rawDir/list_b0.txt
      sed -i 's/..$//' $rawDir/list_b0.txt

      #how many b0 are there in the volume?
      lengthlist=$(cat $rawDir/list_b0.txt | wc -l)

  # loop over all the b0 indices and extract the corresponding volume
  for volume in `seq 1 1 $lengthlist`; do

  # find out the number of the volume
  a=$(awk 'NR == '$volume' {print; exit}' $rawDir/list_b0.txt)
  let "a = $a - 2"
  echo "  extracting volume: $a"

  # extract that volume with fslroi
  fslroi $rawDir/data_AP.nii.gz $rawDir/datab0_$a $a 1

  done

done

  # for the AP images, merge them (if the scanner has not merged them automatically)
  fslmerge -t $rawDir/all_b0 $rawDir/datab0_*
  fslmaths $rawDir/all_b0 -Tmean $rawDir/nodif_AP

echo "NODIFS DONE"
