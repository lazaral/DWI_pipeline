#!/bin/env bash

# put the original data in a structure that makes sense
echo "PREPARING RAW DATA"

# definitions
studyDir=/vols/Data/disease/alazari/qMRI_cross
dataDir=$studyDir/DWI
mkdir -p $dataDir

# list the subjects
subjectList="PP3 PP5 PP6 PP8 PP9 PP10 PP11 PP12 PP15 PP16 PP17 PP18 PP19 PP20 PP21 PP22"
#"PLM01pre PLM01post PLM03pre PLM03post PLM04pre PLM04post PLM06pre PLM06post PLM07pre PLM07post PLM08pre PLM08post PLM09pre PLM09post PLM11pre PLM11post PLM14pre PLM14post PLM15pre PLM15post"

# loop over subjects
for subj in $subjectList; do
  echo "  subj: $subj"
  # define the name of the scan
  # case $subj in
  #   PLM03pre ) scanName="W3T_2018_106_006" ;;
  #   PLM03post ) scanName="W3T_2018_106_008" ;;
  #   PLM04pre ) scanName="W3T_2018_106_007" ;;
  #   PLM04post ) scanName="W3T_2018_106_009" ;;
  #   PLM07pre ) scanName="W3T_2018_106_013" ;;
  #   PLM07post ) scanName="W3T_2018_106_015" ;;
  #   PLM08pre ) scanName="W3T_2018_106_016" ;;
  #   PLM08post ) scanName="W3T_2018_106_018" ;;
  #   PLM09pre ) scanName="W3T_2018_106_017" ;;
  #   PLM09post ) scanName="W3T_2018_106_019" ;;
  #   PLM11pre ) scanName="W3T_2018_106_020" ;;
  #   PLM11post ) scanName="W3T_2018_106_021" ;;
  #   PLM14pre ) scanName="W3T_2018_106_023a" ;;
  #   PLM14post ) scanName="W3T_2018_106_024" ;;
  #   PLM15pre ) scanName="W3T_2018_106_025" ;;
  #   PLM15post ) scanName="W3T_2018_106_026" ;;
  # esac

  # define the file names of the data

  ###### FOR TMS PLASTICITY 2
  # take the last of the images, if multiple exist
  t1w=$(find $dataDir/$subj/T1w/images_*_t1_mpr_ax_1mm_iso_withNose_32ch_v2.nii | sort | tail -1)
  diff=$(find $dataDir/$subj/dMRI/raw/images_*_diff_mbep2d_1.5mm_AP_MB4_256DIR_B1000B2000.nii | sort | tail -1)
  diffRev=$(find $dataDir/$subj/dMRI/raw/images_*_diff_mbep2d_1.5mm_APrev_MB4_256DIR_B1000B2000.nii | sort | tail -1)
  bvec=$(find $dataDir/$subj/dMRI/raw/images_*_diff_mbep2d_1.5mm_AP_MB4_256DIR_B1000B2000.bvec | sort | tail -1)
  bval=$(find $dataDir/$subj/dMRI/raw/images_*_diff_mbep2d_1.5mm_AP_MB4_256DIR_B1000B2000.bval | sort | tail -1)

  ###### FOR TMS PLASTICITY 3
  # t1w=$(find $dataDir/$subj/T1w/images_*_t1_mpr_ax_1mm_iso_withNose_32ch_v2.nii | sort | tail -1)
  # diff=$(find $dataDir/$subj/dMRI/raw/images_*_diff_mbep2d_1.5mm_AP_MB4_256DIR_B1000B2000.nii | sort | tail -1)
  # diffRev=$(find $dataDir/$subj/dMRI/raw/images_*_diff_mbep2d_1.5mm_APrev_MB4_Bzeros.nii | sort | tail -1)
  # bvec=$(find $dataDir/$subj/dMRI/raw/images_*_diff_mbep2d_1.5mm_AP_MB4_256DIR_B1000B2000.bvec | sort | tail -1)
  # bval=$(find $dataDir/$subj/dMRI/raw/images_*_diff_mbep2d_1.5mm_AP_MB4_256DIR_B1000B2000.bval | sort | tail -1)
  # bvalRev=$(find $dataDir/$subj/dMRI/raw/images_*_diff_mbep2d_1.5mm_APrev_MB4_Bzeros.bval | sort | tail -1)



  # check if these files exist and give a warning if they don't
  for file in $t1w $diff $diffRev $bvec $bval ; do
    [[ ! -r $file ]] && >&2 echo "file not found: $file" && exit
  done

  # create folders
  # mkdir -p $dataDir/$subj/T1w
  # mkdir -p $dataDir/$subj/dMRI/raw

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
