#!/bin/bash
export SCRAM_ARCH=slc6_amd64_gcc481
source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_7_1_20_patch2/src ] ; then 
 echo release CMSSW_7_1_20_patch2 already exists
else
scram p CMSSW CMSSW_7_1_20_patch2
fi
cd CMSSW_7_1_20_patch2/src
eval `scram runtime -sh`

#curl -s --insecure https://cms-pdmv.cern.ch/mcm/public/restapi/requests/get_fragment/SUS-RunIIWinter15wmLHE-00098 --retry 2 --create-dirs -o Configuration/GenProduction/python/SUS-RunIIWinter15wmLHE-00098-fragment.py 
#[ -s Configuration/GenProduction/python/SUS-RunIIWinter15wmLHE-00098-fragment.py ] || exit $?;

#scram b
#cd ../../
#cmsDriver.py Configuration/GenProduction/python/SUS-RunIIWinter15wmLHE-00098-fragment.py --fileout file:SUS-RunIIWinter15wmLHE-00098.root --mc --eventcontent LHE --datatier LHE --conditions MCRUN2_71_V1::All --step LHE --python_filename SUS-RunIIWinter15wmLHE-00098_1_cfg.py --no_exec --customise Configuration/DataProcessing/Utils.addMonitoring -n 5760 || exit $? ; 

