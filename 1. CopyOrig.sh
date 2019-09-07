#!/bin/env bash

# copy the original data from the MRdata (or another staging area) to the final study directory

# definitions - list of subjects
subjList="P1@W3T_2017"

# definitions - directories
mrdataDir=/vols/Data/MRdata/alazari
studyDir=/vols/Data/disease/alazari/qMRI_cross/DWI

for subjScan in $subjList ; do

  # separate the subject and the scannumber
  subj=${subjScan%@*}
  scan=${subjScan#*@}

  # what it says on the tin
  echo "COPY THE ORIG DATA FROM MRDATA"
  echo "  MRData:  $mrdataDir"
  echo "  disease: $studyDir"

  # create directories
  mkdir -p $studyDir/$subj
  mkdir -p $studyDir/$subj/dMRI
  mkdir -p $studyDir/$subj/dMRI/raw
  mkdir -p $studyDir/$subj/T1w


# copy to destination folder
  cp -r $mrdataDir/$scan/images_*_diff_mbep2d_1.5mm_AP_MB4_256DIR_B1000B2000.json $studyDir/$subj/dMRI/raw/
  cp -r $mrdataDir/$scan/images_*_diff_mbep2d_1.5mm_AP_MB4_256DIR_B1000B2000.nii $studyDir/$subj/dMRI/raw/
  cp -r $mrdataDir/$scan/images_*_diff_mbep2d_1.5mm_AP_MB4_256DIR_B1000B2000.nii $studyDir/$subj/dMRI/raw/
  cp -r $mrdataDir/$scan/images_*_diff_mbep2d_1.5mm_AP_MB4_256DIR_B1000B2000.bval $studyDir/$subj/dMRI/raw/
  cp -r $mrdataDir/$scan/images_*_diff_mbep2d_1.5mm_AP_MB4_256DIR_B1000B2000.bvec $studyDir/$subj/dMRI/raw/
  cp -r $mrdataDir/$scan/images_*_diff_mbep2d_1.5mm_AP_MB4_256DIR_B1000B2000.json $studyDir/$subj/dMRI/raw/
  cp -r $mrdataDir/$scan/images_*_diff_mbep2d_1.5mm_AP_MB4_256DIR_B1000B2000.nii $studyDir/$subj/dMRI/raw/
  cp -r $mrdataDir/$scan/images_*_diff_mbep2d_1.5mm_APrev_MB4_256DIR_B1000B2000.json $studyDir/$subj/dMRI/raw/
  cp -r $mrdataDir/$scan/images_*_diff_mbep2d_1.5mm_APrev_MB4_256DIR_B1000B2000.nii $studyDir/$subj/dMRI/raw/
  cp -r $mrdataDir/$scan/images_*_diff_mbep2d_1.5mm_APrev_MB4_256DIR_B1000B2000.json $studyDir/$subj/dMRI/raw/
  cp -r $mrdataDir/$scan/images_*_diff_mbep2d_1.5mm_APrev_MB4_256DIR_B1000B2000.nii $studyDir/$subj/dMRI/raw/
  cp -r $mrdataDir/$scan/images_*_t1_mpr_ax_1mm_iso_withNose_32ch_v2.nii $studyDir/$subj/T1w/

  # report
  echo "done with $subj"
  echo "  "


done

echo "done"
