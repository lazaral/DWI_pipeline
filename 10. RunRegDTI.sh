#!/bin/env bash

echo "RUNNING REGISTRTION"

# definitions
studyDir=/vols/Scratch/alazari/paTMS/diffusion_Jul2018
dataDir=$studyDir/data

# list the subjects
subjectList="P1 P2 P3"

for subj in $subjectList; do
echo "  subj: $subj"
# make directories
mkdir -p $dataDir/$subj/dMRI/dtifit
mkdir -p $dataDir/$subj/dMRI/reg
dtiDir=$dataDir/$subj/dMRI/dtifit
regDir=$dataDir/$subj/dMRI/reg
strucDir=$dataDir/$subj/T1w/
maskDir=$dataDir/$subj/dMRI/brainextraction
eddyDir=$dataDir/$subj/dMRI/eddy

# do BBR registration of volumes to structural
# specify input (average eddy-corrected b0) and wm segmetnation
# select_dwi_vols $eddyDir/eddy_unwarped_images.nii.gz $dataDir/$subj/dMRI/raw/bval $eddyDir/eddy_nodif -b 0 -m
# bet $eddyDir/eddy_nodif $eddyDir/eddy_nodif_brain

echo "registration"
 epi_reg --nofmapreg \
 --epi=$maskDir/nodif_brain_$subj.nii \
 --wmseg=$studyDir/T1w/$subj/T1w/$subj/mri/white.nii.gz \
 --t1=$studyDir/T1w/$subj/T1w/T1w_acpc_dc_restore.nii.gz \
 --t1brain=$studyDir/T1w/$subj/T1w/T1w_acpc_dc_restore_brain.nii.gz \
 --out=$regDir/dti2struct --noclean

 # invert_mat
  convert_xfm -omat $regDir/struct2dwi.mat \
  -inverse $regDir/dti2struct.mat

  # combine flirt and fnirt
  convertwarp --ref=/opt/fmrib/fsl/data/standard/MNI152_T1_2mm.nii.gz \
  --premat=$regDir/dti2struct.mat \
  --warp1=$studyDir/T1w/$subj/MNINonLinear/xfms/NonlinearReg.nii.gz \
  --out=$regDir/dti2MNI.nii.gz --relout

  # and get the inverse
  invwarp --ref=$studyDir/T1w/$subj/T1w/T1w_acpc_dc_restore.nii.gz \
  --warp=$regDir/dti2MNI.nii.gz \
  --out=$regDir/MNI2dti.nii.gz

  # # apply DWI_reg FA to MNI - name ${ii}
  applywarp --ref=/opt/fmrib/fsl/data/standard/MNI152_T1_2mm.nii.gz \
  --in=$dtiDir/"$subj"_FA.nii.gz \
  --warp=$regDir/dti2MNI.nii.gz \
  --out=$dtiDir/FA_2_MNI.nii.gz \
  --interp=spline

done

echo "REGISTRATION DONE"
