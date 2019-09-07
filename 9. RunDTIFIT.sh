#!/bin/env bash

echo "RUNNING DTIFIT"

# definitions
studyDir=/vols/Scratch/alazari/paTMS/diffusion_Jul2018
dataDir=$studyDir/data

# list the subjects
subjectList="P1 P2 P3"

for subj in $subjectList; do
echo "  subj: $subj"
  # make directories
  mkdir -p $dataDir/$subj/dMRI/dtifit
  dtiDir=$dataDir/$subj/dMRI/dtifit
  rawDir=$dataDir/$subj/dMRI/raw
  maskDir=$dataDir/$subj/dMRI/brainextraction

  # run DTIFIT
dtifit --data=$rawDir/eddy_unwarped_images.nii.gz --mask=$maskDir/nodif_brain_${subj}_mask.nii.gz --bvecs=$rawDir/bvec --bvals=$rawDir/bval --out=$dtiDir/dti
done

echo "DTIFIT DONE"
