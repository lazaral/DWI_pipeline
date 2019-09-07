#!/bin/env bash

echo "RUNNING EDDY"

# definitions
studyDir=/vols/Scratch/alazari/paTMS/diffusion_Jul2018
dataDir=$studyDir/data

# list the subjects
subjectList="P1 P2 P3"

# loop over subjects
for subj in $subjectList; do
echo "  subj: $subj"
  # specify directories
  eddyDir=$dataDir/$subj/dMRI/eddy
  betDir=$dataDir/$subj/dMRI/brainextraction
  topupDir=$dataDir/$subj/dMRI/topup
  rawDir=$dataDir/$subj/dMRI/raw
  acqDir=$dataDir/$subj/dMRI/acqparams

  # specify files where b-vectors and b-values are located (just 1 file per folder, so easy to find)
  bvecs=$rawDir/bvec
  bvals=$rawDir/bval

  fsl_sub -q cuda.q eddy_cuda --imain=$rawDir/data_AP --mask=$betDir/nodif_brain_${subj}_mask --index=$eddyDir/index.txt --acqp=$acqDir/acqparams.txt --bvecs=$bvecs --bvals=$bvals --topup=$topupDir/topup_$subj --out=$eddyDir/eddy_unwarped_images --niter=8 --fwhm=10,6,4,2,0,0,0,0 --repol --ol_type=both --mporder=8 --s2v_niter=8 --nvoxhp=2000 -v --slspec=$studyDir/DWI_pipeline/slspec_file.txt --cnr_maps --residuals
done

# report
echo "DONE WITH EDDY"
echo "$(date)"; echo ""
echo "  "
