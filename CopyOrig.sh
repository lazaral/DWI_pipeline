#!/bin/env bash

# copy the original data from the MRdata folder to my scratch

# definitions - list of subjects
subjList="
PP17@W3T_2017_110_019
PP18@W3T_2017_110_020"

#
  # PP3   W3T_2017_110_005
  # PP5   W3T_2017_110_006
  # PP6   W3T_2017_110_007
  # PP8   W3T_2017_110_009
  # PP9    W3T_2017_110_010
  # PP10   W3T_2017_110_011
  # PP11   W3T_2017_110_012
  # PP12   W3T_2017_110_013
  # PP15   W3T_2017_110_016
  # PP16   W3T_2017_110_018
  # PP17   W3T_2017_110_019
  # PP18   W3T_2017_110_020
  # PP19   W3T_2017_110_021
  # PP20   W3T_2017_110_022
  # PP21   W3T_2017_110_024
  # PP22   W3T_2017_110_023
#
#   PLM01   W3T_2018_106_002    W3T_2018_106_003
#   PLM03   W3T_2018_106_006    W3T_2018_106_008
#   PLM04   W3T_2018_106_007    W3T_2018_106_009
#   PLM06   W3T_2018_106_012    W3T_2018_106_014
#   PLM07   W3T_2018_106_013    W3T_2018_106_015
#   PLM08   W3T_2018_106_016    W3T_2018_106_018
#   PLM09   W3T_2018_106_017    W3T_2018_106_019
#   PLM11   W3T_2018_106_020    W3T_2018_106_021
#   PLM14   W3T_2018_106_023    W3T_2018_106_024
#   PLM15   W3T_2018_106_025    W3T_2018_106_026
#

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


# copy to disease

###########
# USE THIS FOR TMS PLASTICITY 2
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

##########
# USE THIS FOR TMS PLASTICITY 3
  # cp -r $mrdataDir/$scan/images_023_diff_mbep2d_1.5mm_AP_MB4_256DIR_B1000B2000.json $studyDir/$subj/dMRI/raw/
  # cp -r $mrdataDir/$scan/images_023_diff_mbep2d_1.5mm_AP_MB4_256DIR_B1000B2000.nii $studyDir/$subj/dMRI/raw/
  # cp -r $mrdataDir/$scan/images_023_diff_mbep2d_1.5mm_AP_MB4_256DIR_B1000B2000.nii $studyDir/$subj/dMRI/raw/
  # cp -r $mrdataDir/$scan/images_024_diff_mbep2d_1.5mm_AP_MB4_256DIR_B1000B2000.bval $studyDir/$subj/dMRI/raw/
  # cp -r $mrdataDir/$scan/images_024_diff_mbep2d_1.5mm_AP_MB4_256DIR_B1000B2000.bvec $studyDir/$subj/dMRI/raw/
  # cp -r $mrdataDir/$scan/images_024_diff_mbep2d_1.5mm_AP_MB4_256DIR_B1000B2000.json $studyDir/$subj/dMRI/raw/
  # cp -r $mrdataDir/$scan/images_024_diff_mbep2d_1.5mm_AP_MB4_256DIR_B1000B2000.nii $studyDir/$subj/dMRI/raw/
  # cp -r $mrdataDir/$scan/images_025_diff_mbep2d_1.5mm_APrev_MB4_Bzeros.json $studyDir/$subj/dMRI/raw/
  # cp -r $mrdataDir/$scan/images_025_diff_mbep2d_1.5mm_APrev_MB4_Bzeros.nii $studyDir/$subj/dMRI/raw/
  # cp -r $mrdataDir/$scan/images_026_diff_mbep2d_1.5mm_APrev_MB4_Bzeros.bval $studyDir/$subj/dMRI/raw/
  # cp -r $mrdataDir/$scan/images_026_diff_mbep2d_1.5mm_APrev_MB4_Bzeros.bvec $studyDir/$subj/dMRI/raw/
  # cp -r $mrdataDir/$scan/images_026_diff_mbep2d_1.5mm_APrev_MB4_Bzeros.json $studyDir/$subj/dMRI/raw/
  # cp -r $mrdataDir/$scan/images_026_diff_mbep2d_1.5mm_APrev_MB4_Bzeros.nii $studyDir/$subj/dMRI/raw/
  # cp -r $mrdataDir/$scan/images_03_t1_mpr_ax_1mm_iso_withNose_32ch_v2.nii $studyDir/$subj/T1w/

  # report
  echo "done with $subj"
  echo "  "


done

echo "done"
