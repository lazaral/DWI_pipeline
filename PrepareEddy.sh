#!/bin/env bash

# Prepare EDDY

echo "PREPARING FOR EDDY"

# definitions
studyDir=/vols/Scratch/alazari/paTMS/diffusion_Jul2018
dataDir=$studyDir/data

# list the subjects
subjectList="PLM03pre"
#subjectList="PP05"

# Loop over subjects
for subj in $subjectList; do
  echo "  subj: $subj"
  # make and specify directories
  mkdir -p $dataDir/$subj/dMRI/brainextraction
  mkdir -p $dataDir/$subj/dMRI/eddy
  eddyDir=$dataDir/$subj/dMRI/eddy
  outputDir=$dataDir/$subj/dMRI/brainextraction
  topupDir=$dataDir/$subj/dMRI/topup
  rawDir=$dataDir/$subj/dMRI/raw

  echo "    calculating brain mask"
  # make a brain mask
  fslmaths $topupDir/topup_iout_$subj -Tmean $outputDir/hifib0_$subj

  echo "    brain extraction"
  # extract brain with BET using the brain mask
  bet $outputDir/hifib0_$subj $outputDir/nodif_brain_$subj -m -f 0.2

  # calculate number of volumes
  echo "    calculating number of volumes"
  numVols=$(fslval $rawDir/data_AP dim4)
  echo "    nr of volumes: $numVols"

  # make an 'index.txt' file with a row of 1's for the number of volumes
  echo "    making index file with volumes"
  indx=" "
  for ((i=1; i<=$numVols; i+=1)); do indx="$indx 1"; done
  echo $indx > $eddyDir/index.txt
done

echo "EDDY PREPARATION DONE"
