#!/bin/env bash

echo "APPLYING TOPUP"

# definitions
studyDir=~/scratch/paTMS/diffusion_Jul2018/
dataDir=$studyDir/data

# list the subjects
subjectList="P1 P2 P3"

# applying topup
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
