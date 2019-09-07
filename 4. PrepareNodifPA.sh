#!/bin/env bash

# This script selects nodif images from PA direction - and merges them with the AP ones

echo "PREPARING NODIF IMAGES"

# definitions
dataDir=/vols/Data/disease/alazari/longitudinal_paTMS/DWI

# list the subjects
subjectList="P1 P2 P3"


  # Loop over subjects for AP b0
  for subj in $subjectList; do

    echo "FINDING PA NODIFS"
    # establish the subject-specific directory
    rawDir=$dataDir/$subj/dMRI/raw

    # delete previous lists of b0s to not get confused
    rm $rawDir/list_b0_Rev.txt

    # extract the b0 from AP images
        #create a new version of bval
        cp $rawDir/bvalRev $rawDir/bval_Rev_b0

        #add blank spaces at the beginning and end of bval_b0
        sed -i -e 's/^/ /' $rawDir/bval_Rev_b0
        sed -i -e 's/$/ /' $rawDir/bval_Rev_b0

        #extract the location of the b0 and crete a .txt file with it
        sed -i "s/5/6/g" $rawDir/bval_Rev_b0
        sed -i "s/ /\n/g" $rawDir/bval_Rev_b0
        grep -o '6' $rawDir/bval_Rev_b0 -n >> $rawDir/list_b0_Rev.txt

        #polish the .txt file
        sed -i "s/ /\n/g" $rawDir/list_b0_Rev.txt
        sed -i 's/..$//' $rawDir/list_b0_Rev.txt

        #how many b0 are there in the volume?
        lengthlist=$(cat $rawDir/list_b0_Rev.txt | wc -l)

    # loop over all the b0 indices and extract the corresponding volume
    for volume in `seq 1 1 $lengthlist`; do

    # find out the number of the volume
    a=$(awk 'NR == '$volume' {print; exit}' $rawDir/list_b0_Rev.txt)
    let "a = $a - 2"
    echo "  extracting volume: $a"

    # extract that volume with fslroi
    fslroi $rawDir/data_PA.nii.gz $rawDir/datab0_Rev_$a $a 1

    done

    done

    # for the PA images, merge them (if the scanner has not merged them automatically)
    fslmerge -t $rawDir/all_b0_Rev $rawDir/datab0_Rev_*
    fslmaths $rawDir/all_b0_Rev -Tmean $rawDir/nodif_PA


  # and finally, the most exciting step! Merge the nodif/b0 images from AP and PA. All is ready for some fun topup!
  fslmerge -t $rawDir/nodif.nii.gz $rawDir/nodif_AP $rawDir/nodif_PA

echo "NODIFS DONE"
