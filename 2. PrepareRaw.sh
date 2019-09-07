#!/bin/env bash

# this script turns the original data into a structure that makes sense and is easier to analyse
echo "PREPARING RAW DATA"

# definitions
studyDir=/vols/Data/disease/alazari/qMRI_cross
dataDir=$studyDir/DWI
mkdir -p $dataDir

# list the subjects
subjectList="P1 P2 P3"

# loop over subjects
for subj in $subjectList; do
  echo "  subj: $subj"

  # take the last of the images, if multiple exist
  t1w=$(find $dataDir/$subj/T1w/images_*_t1_mpr_ax_1mm_iso_withNose_32ch_v2.nii | sort | tail -1)
  diff=$(find $dataDir/$subj/dMRI/raw/images_*_diff_mbep2d_1.5mm_AP_MB4_256DIR_B1000B2000.nii | sort | tail -1)
  diffRev=$(find $dataDir/$subj/dMRI/raw/images_*_diff_mbep2d_1.5mm_APrev_MB4_256DIR_B1000B2000.nii | sort | tail -1)
  bvec=$(find $dataDir/$subj/dMRI/raw/images_*_diff_mbep2d_1.5mm_AP_MB4_256DIR_B1000B2000.bvec | sort | tail -1)
  bval=$(find $dataDir/$subj/dMRI/raw/images_*_diff_mbep2d_1.5mm_AP_MB4_256DIR_B1000B2000.bval | sort | tail -1)

  # check if these files exist and give a warning if they don't
  for file in $t1w $diff $diffRev $bvec $bval ; do
    [[ ! -r $file ]] && >&2 echo "file not found: $file" && exit
  done


  # copy and rename data
  echo " renaming data, wait for it"
  fslchfiletype NIFTI_GZ $t1w $dataDir/$subj/T1w/struct
  fslchfiletype NIFTI_GZ $diff $dataDir/$subj/dMRI/raw/data_AP
  fslchfiletype NIFTI_GZ $diffRev $dataDir/$subj/dMRI/raw/data_PA
  mv $bvec $dataDir/$subj/dMRI/raw/bvec
  mv $bval $dataDir/$subj/dMRI/raw/bval
  mv $bvalRev $dataDir/$subj/dMRI/raw/bvalRev

done

# report
echo "DONE"
echo ""
