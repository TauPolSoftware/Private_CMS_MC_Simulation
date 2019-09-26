#!/bin/bash

#gfal-copy -f srm://grid-srm.physik.rwth-aachen.de:8443/srm/managerv2?SFN=/pnfs/physik.rwth-aachen.de/cms//store/user/tmuller/private_mc/gridpacks/2017/13TeV/DYJets_HT_LO_MLM/DYJets_HT_mll50/DYJets_HT-incl/DYJets_HT-incl_tarball.tar.xz DYJets_HT-incl_tarball.tar.xz
gfal-copy -f srm://grid-srm.physik.rwth-aachen.de:8443/srm/managerv2?SFN=/pnfs/physik.rwth-aachen.de/cms//store/user/tmuller/private_mc/gridpacks/2017/13TeV/DYJets_HT_LO_MLM/DYJets_HT_mll50/DYJets_HT-incl/DYJets_HT-incl_slc6_amd64_gcc630_CMSSW_9_3_8_tarball.tar.xz DYJets_HT-incl_tarball.tar.xz
ls -l

REQUEST=SUS-RunIIWinter15wmLHE-00098
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
if [ -r CMSSW_7_1_20_patch2/src ] ; then 
 echo release CMSSW_7_1_20_patch2 already exists
else
scram p CMSSW CMSSW_7_1_20_patch2
fi
cd CMSSW_7_1_20_patch2/src
eval `scram runtime -sh`

curl -s --insecure https://cms-pdmv.cern.ch/mcm/public/restapi/requests/get_fragment/SUS-RunIIWinter15wmLHE-00098 --retry 2 --create-dirs -o Configuration/GenProduction/python/SUS-RunIIWinter15wmLHE-00098-fragment.py 
[ -s Configuration/GenProduction/python/SUS-RunIIWinter15wmLHE-00098-fragment.py ] || exit $?;

#if grep -q "gridpacks" Configuration/GenProduction/python/SUS-RunIIWinter15wmLHE-00098-fragment.py; then
#  if ! grep -q "/cvmfs/cms.cern.ch/phys_generator/gridpacks" Configuration/GenProduction/python/SUS-RunIIWinter15wmLHE-00098-fragment.py; then
#     echo "Gridpack inside fragment is not in cvmfs."
#    exit -1
#  fi
#fi

scram b
cd ../../

cmsDriver.py Configuration/GenProduction/python/SUS-RunIIWinter15wmLHE-00098-fragment.py --fileout file:SUS-RunIIWinter15wmLHE-00098.root --mc --eventcontent LHE --datatier LHE --conditions MCRUN2_71_V1::All --step LHE --python_filename SUS-RunIIWinter15wmLHE-00098_1_cfg.py --no_exec --customise Configuration/DataProcessing/Utils.addMonitoring -n 10 || exit $? ; 

sed -ie "s@/cvmfs/cms.cern.ch/phys_generator/gridpacks/slc6_amd64_gcc481/13TeV/madgraph/V5_2.2.2/DYJets_HT_LO_MLM/DYJets_HT-incl/V1/@../@g" $CMSSW_BASE/src/Configuration/GenProduction/python/SUS-RunIIWinter15wmLHE-00098-fragment.py
sed -ie "s@/cvmfs/cms.cern.ch/phys_generator/gridpacks/slc6_amd64_gcc481/13TeV/madgraph/V5_2.2.2/DYJets_HT_LO_MLM/DYJets_HT-incl/V1/@../@g" SUS-RunIIWinter15wmLHE-00098_1_cfg.py

#cmsRun -e -j SUS-RunIIWinter15wmLHE-00098_rt.xml SUS-RunIIWinter15wmLHE-00098_1_cfg.py || exit $? ; 
cmsRun -e -j SUS-RunIIWinter15wmLHE-00098_rt.xml -p PSet.py || exit $? ; 
cp SUS-RunIIWinter15wmLHE-00098_rt.xml FrameworkJobReport.xml
echo 10 events were ran 
grep "TotalEvents" SUS-RunIIWinter15wmLHE-00098_rt.xml 
if [ $? -eq 0 ]; then
    grep "Timing-tstoragefile-write-totalMegabytes" SUS-RunIIWinter15wmLHE-00098_rt.xml 
    if [ $? -eq 0 ]; then
        events=$(grep "TotalEvents" SUS-RunIIWinter15wmLHE-00098_rt.xml | tail -1 | sed "s/.*>\(.*\)<.*/\1/")
        size=$(grep "Timing-tstoragefile-write-totalMegabytes" SUS-RunIIWinter15wmLHE-00098_rt.xml | sed "s/.* Value=\"\(.*\)\".*/\1/")
        if [ $events -gt 0 ]; then
            echo "McM Size/event: $(bc -l <<< "scale=4; $size*1024 / $events")"
        fi
    fi
fi
grep "EventThroughput" SUS-RunIIWinter15wmLHE-00098_rt.xml 
if [ $? -eq 0 ]; then
  var1=$(grep "EventThroughput" SUS-RunIIWinter15wmLHE-00098_rt.xml | sed "s/.* Value=\"\(.*\)\".*/\1/")
  echo "McM time_event value: $(bc -l <<< "scale=4; 1/$var1")"
fi
echo CPU efficiency info:
grep "TotalJobCPU" SUS-RunIIWinter15wmLHE-00098_rt.xml 
grep "TotalJobTime" SUS-RunIIWinter15wmLHE-00098_rt.xml 

