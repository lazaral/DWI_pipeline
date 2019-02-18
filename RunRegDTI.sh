#!/bin/env bash

echo "RUNNING REGISTRTION"

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
  mkdir -p $dataDir/$subj/dMRI/reg
  dtiDir=$dataDir/$subj/dMRI/dtifit
  regDir=$dataDir/$subj/dMRI/reg
  strucDir=$dataDir/$subj/T1w/
  maskDir=$dataDir/$subj/dMRI/brainextraction

  # do affine registration of DTI to structural
  flirt -in $dtiDir/dti_FA.nii.gz -ref /vols/Scratch/alazari/paTMS/PLM03pre/T1w/T1w_acpc_dc_restore_brain -out $regDir/dti2struct -omat $regDir/dti2struct -dof 12
done

echo "REGISTRATION DONE"
