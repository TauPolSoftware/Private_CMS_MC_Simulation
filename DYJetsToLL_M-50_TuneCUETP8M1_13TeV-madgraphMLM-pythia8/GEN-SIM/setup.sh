#!/bin/bash
export SCRAM_ARCH=slc6_amd64_gcc481
source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_7_1_20_patch3/src ] ; then 
 echo release CMSSW_7_1_20_patch3 already exists
else
scram p CMSSW CMSSW_7_1_20_patch3
fi
cd CMSSW_7_1_20_patch3/src
eval `scram runtime -sh`

#curl -s --insecure https://cms-pdmv.cern.ch/mcm/public/restapi/requests/get_fragment/SUS-RunIISummer15GS-00148 --retry 2 --create-dirs -o Configuration/GenProduction/python/SUS-RunIISummer15GS-00148-fragment.py 
#[ -s Configuration/GenProduction/python/SUS-RunIISummer15GS-00148-fragment.py ] || exit $?;

#scram b
#cd ../../
#cmsDriver.py Configuration/GenProduction/python/SUS-RunIISummer15GS-00148-fragment.py --filein "dbs:/DYJetsToLL_M-50_TuneCUETP8M1_13TeV-madgraphMLM-pythia8/RunIIWinter15wmLHE-MCRUN2_71_V1_ext1-v1/LHE" --fileout file:SUS-RunIISummer15GS-00148.root --mc --eventcontent RAWSIM --customise SLHCUpgradeSimulations/Configuration/postLS1Customs.customisePostLS1,Configuration/DataProcessing/Utils.addMonitoring --datatier GEN-SIM --conditions MCRUN2_71_V1::All --beamspot Realistic50ns13TeVCollision --step GEN,SIM --magField 38T_PostLS1 --python_filename SUS-RunIISummer15GS-00148_1_cfg.py --no_exec -n 338 || exit $? ; 

