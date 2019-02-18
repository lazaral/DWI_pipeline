#!/bin/env bash

echo "RUNNING DTIFIT"

# definitions
studyDir=/vols/Scratch/alazari/paTMS/diffusion_Jul2018
dataDir=$studyDir/data

# list the subjects
#subjectList="PP05 PP06 PP10 PP11 PP12 PP15 PP16 PP18 PP19 PP20 PP21 PP22"
#subjectList="PP05"
subjectList="PLM03pre"

# running TOPUP - this should take a while
for subj in $subjectList; do
echo "  subj: $subj"
  # make directories
  mkdir -p $dataDir/$subj/dMRI/dtifit
  dtiDir=$dataDir/$subj/dMRI/dtifit
  rawDir=$dataDir/$subj/dMRI/raw
  maskDir=$dataDir/$subj/dMRI/brainextraction

  # run DTIFIT
dtifit --data=$rawDir/data_AP.nii.gz --mask=$maskDir/nodif_brain_${subj}_mask.nii.gz --bvecs=$rawDir/bvec --bvals=$rawDir/bval --out=$dtiDir/dti
done

echo "DTIFIT DONE"
