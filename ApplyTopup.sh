#!/bin/env bash

echo "APPLYING TOPUP"

# definitions
studyDir=~/scratch/paTMS/diffusion_Jul2018/
dataDir=$studyDir/data

# list the subjects
#subjectList="PP05 PP06 PP10 PP11 PP12 PP15 PP16 PP18 PP19 PP20 PP21 PP22"
subjectList="PLM03pre"
#subjectList="PP06 PP10 PP11 PP12 PP15 PP16 PP18 PP19 PP20 PP21 PP22"

# running TOPUP - this should take a while
for subj in $subjectList; do
echo "  subj: $subj"
  # make directories
  paramDir=$dataDir/$subj/dMRI/acqparams
  topupDir=$dataDir/$subj/dMRI/topup
  rawDir=$dataDir/$subj/dMRI/raw
  mkdir -p $dataDir/$subj/dMRI/applytopup
  applytopupDir=$dataDir/$subj/dMRI/applytopup

  applytopup --imain=$rawDir/nodif_AP,$rawDir/nodif_PA --method=jac --topup=$topupDir/topup_${subj} --datain=$paramDir/acqparams.txt --inindex=1,2 --out=$applytopupDir/hifi_nodif
done

# report
echo "DONE"
echo "  "
