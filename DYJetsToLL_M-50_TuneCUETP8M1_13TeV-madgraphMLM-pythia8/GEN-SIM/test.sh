#!/bin/bash

REQUEST=SUS-RunIISummer15GS-00148
#wget --quiet https://raw.githubusercontent.com/cms-sw/genproductions/master/bin/utils/request_fragment_check.py
#python request_fragment_check.py --bypass_status --prepid $REQUEST
ERRORS=$?
if [ $ERRORS -ne 0 ]; then
    echo "GEN Request Checking Script returned exit code $ERRORS which means there are $ERRORS errors"
    echo "Validation WILL NOT RUN"
    echo "Please correct errors in the request and run validation again"
    exit $ERRORS
fi
echo "Running VALIDATION. GEN Request Checking Script returned no errors"

export SCRAM_ARCH=slc6_amd64_gcc481
source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_7_1_20_patch3/src ] ; then 
 echo release CMSSW_7_1_20_patch3 already exists
else
scram p CMSSW CMSSW_7_1_20_patch3
fi
cd CMSSW_7_1_20_patch3/src
eval `scram runtime -sh`

curl -s --insecure https://cms-pdmv.cern.ch/mcm/public/restapi/requests/get_fragment/SUS-RunIISummer15GS-00148 --retry 2 --create-dirs -o Configuration/GenProduction/python/SUS-RunIISummer15GS-00148-fragment.py 
[ -s Configuration/GenProduction/python/SUS-RunIISummer15GS-00148-fragment.py ] || exit $?;

if grep -q "gridpacks" Configuration/GenProduction/python/SUS-RunIISummer15GS-00148-fragment.py; then
  if ! grep -q "/cvmfs/cms.cern.ch/phys_generator/gridpacks" Configuration/GenProduction/python/SUS-RunIISummer15GS-00148-fragment.py; then
     echo "Gridpack inside fragment is not in cvmfs."
    exit -1
  fi
fi

scram b
cd ../../
#cmsDriver.py Configuration/GenProduction/python/SUS-RunIISummer15GS-00148-fragment.py --filein "dbs:/DYJetsToLL_M-50_TuneCUETP8M1_13TeV-madgraphMLM-pythia8/RunIIWinter15wmLHE-MCRUN2_71_V1_ext1-v1/LHE" --fileout file:SUS-RunIISummer15GS-00148.root --mc --eventcontent RAWSIM --customise SLHCUpgradeSimulations/Configuration/postLS1Customs.customisePostLS1,Configuration/DataProcessing/Utils.addMonitoring --datatier GEN-SIM --conditions MCRUN2_71_V1::All --beamspot Realistic50ns13TeVCollision --step GEN,SIM --magField 38T_PostLS1 --python_filename SUS-RunIISummer15GS-00148_1_cfg.py --no_exec -n 10 || exit $? ;
cmsDriver.py Configuration/GenProduction/python/SUS-RunIISummer15GS-00148-fragment_edit.py --filein "file:/home/home2/institut_3b/tmuller/home/cms/htt/generator/DYJetsToLL_M-50_reproduction/LHE/SUS-RunIIWinter15wmLHE-00098.root" --fileout file:SUS-RunIISummer15GS-00148.root --mc --eventcontent RAWSIM --customise SLHCUpgradeSimulations/Configuration/postLS1Customs.customisePostLS1,Configuration/DataProcessing/Utils.addMonitoring --datatier GEN-SIM --conditions MCRUN2_71_V1::All --beamspot Realistic50ns13TeVCollision --step GEN,SIM --magField 38T_PostLS1 --python_filename SUS-RunIISummer15GS-00148_1_cfg.py --no_exec -n 10 || exit $? ; 
#cmsRun -e -j SUS-RunIISummer15GS-00148_rt.xml SUS-RunIISummer15GS-00148_1_cfg.py || exit $? ; 
cmsRun -e -j SUS-RunIISummer15GS-00148_rt.xml -p PSet.py || exit $? ; 
cp SUS-RunIISummer15GS-00148_rt.xml FrameworkJobReport.xml
echo 10 events were ran 
grep "TotalEvents" SUS-RunIISummer15GS-00148_rt.xml 
if [ $? -eq 0 ]; then
    grep "Timing-tstoragefile-write-totalMegabytes" SUS-RunIISummer15GS-00148_rt.xml 
    if [ $? -eq 0 ]; then
        events=$(grep "TotalEvents" SUS-RunIISummer15GS-00148_rt.xml | tail -1 | sed "s/.*>\(.*\)<.*/\1/")
        size=$(grep "Timing-tstoragefile-write-totalMegabytes" SUS-RunIISummer15GS-00148_rt.xml | sed "s/.* Value=\"\(.*\)\".*/\1/")
        if [ $events -gt 0 ]; then
            echo "McM Size/event: $(bc -l <<< "scale=4; $size*1024 / $events")"
        fi
    fi
fi
grep "EventThroughput" SUS-RunIISummer15GS-00148_rt.xml 
if [ $? -eq 0 ]; then
  var1=$(grep "EventThroughput" SUS-RunIISummer15GS-00148_rt.xml | sed "s/.* Value=\"\(.*\)\".*/\1/")
  echo "McM time_event value: $(bc -l <<< "scale=4; 1/$var1")"
fi
echo CPU efficiency info:
grep "TotalJobCPU" SUS-RunIISummer15GS-00148_rt.xml 
grep "TotalJobTime" SUS-RunIISummer15GS-00148_rt.xml 

