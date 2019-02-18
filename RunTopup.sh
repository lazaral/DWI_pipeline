#!/bin/env bash

echo "RUNNING TOPUP"

# definitions
dataDir=/vols/Data/disease/alazari/longitudinal_paTMS/DWI

# list the subjects
subjectList="PLM01pre PLM01post PLM03pre PLM03post PLM04pre PLM04post PLM06pre PLM06post PLM07pre PLM07post PLM08pre PLM08post PLM09pre PLM09post PLM11pre PLM11post"

# running TOPUP - this should take a while
for subj in $subjectList; do
echo "  subj: $subj"
  # make directories
  mkdir $dataDir/$subj/dMRI/acqparams
  paramDir=$dataDir/$subj/dMRI/acqparams
  mkdir $dataDir/$subj/dMRI/topup
  topupDir=$dataDir/$subj/dMRI/topup

  # save acqparams
  echo "0 -1 0 0.095
  0  1 0 0.095" > $paramDir/acqparams.txt
  fsl_sub topup --imain=$dataDir/$subj/dMRI/raw/nodif --datain=$paramDir/acqparams.txt --config=b02b0.cnf  --out=$topupDir/topup_$subj --iout=$topupDir/topup_iout_$subj --fout=$topupDir/topup_fout_$subj
done

# report
echo "DONE"
echo "  "
