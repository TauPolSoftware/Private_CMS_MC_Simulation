#!/bin/bash
export SCRAM_ARCH=slc6_amd64_gcc530
source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_8_0_21/src ] ; then 
 echo release CMSSW_8_0_21 already exists
else
scram p CMSSW CMSSW_8_0_21
fi
cd CMSSW_8_0_21/src
eval `scram runtime -sh`


scram b
cd ../../
#cmsDriver.py step1 --filein "dbs:/DYJetsToLL_M-50_TuneCUETP8M1_13TeV-madgraphMLM-pythia8/RunIISummer16DR80Premix-PUMoriond17_80X_mcRun2_asymptotic_2016_TrancheIV_v6_ext1-v1/AODSIM" --fileout file:SUS-RunIISummer16MiniAODv2-00001.root --mc --eventcontent MINIAODSIM --runUnscheduled --datatier MINIAODSIM --conditions 80X_mcRun2_asymptotic_2016_TrancheIV_v6 --step PAT --nThreads 1 --era Run2_2016 --python_filename SUS-RunIISummer16MiniAODv2-00001_1_cfg.py --no_exec --customise Configuration/DataProcessing/Utils.addMonitoring -n 10 || exit $? ; 
cmsDriver.py step1 --filein "file:/home/home2/institut_3b/tmuller/home/cms/htt/generator/DYJetsToLL_M-50_reproduction/AODSIM/SUS-RunIISummer16DR80Premix-00036.root" --fileout file:SUS-RunIISummer16MiniAODv2-00001.root --mc --eventcontent MINIAODSIM --runUnscheduled --datatier MINIAODSIM --conditions 80X_mcRun2_asymptotic_2016_TrancheIV_v6 --step PAT --nThreads 1 --era Run2_2016 --python_filename SUS-RunIISummer16MiniAODv2-00001_1_cfg.py --no_exec --customise Configuration/DataProcessing/Utils.addMonitoring -n 10 || exit $? ; 
#cmsRun -e -j SUS-RunIISummer16MiniAODv2-00001_rt.xml SUS-RunIISummer16MiniAODv2-00001_1_cfg.py || exit $? ; 
cmsRun -e -j SUS-RunIISummer16MiniAODv2-00001_rt.xml -p PSet.py || exit $? ; 
cp SUS-RunIISummer16MiniAODv2-00001_rt.xml FrameworkJobReport.xml
echo 10 events were ran 
grep "TotalEvents" SUS-RunIISummer16MiniAODv2-00001_rt.xml 
if [ $? -eq 0 ]; then
    grep "Timing-tstoragefile-write-totalMegabytes" SUS-RunIISummer16MiniAODv2-00001_rt.xml 
    if [ $? -eq 0 ]; then
        events=$(grep "TotalEvents" SUS-RunIISummer16MiniAODv2-00001_rt.xml | tail -1 | sed "s/.*>\(.*\)<.*/\1/")
        size=$(grep "Timing-tstoragefile-write-totalMegabytes" SUS-RunIISummer16MiniAODv2-00001_rt.xml | sed "s/.* Value=\"\(.*\)\".*/\1/")
        if [ $events -gt 0 ]; then
            echo "McM Size/event: $(bc -l <<< "scale=4; $size*1024 / $events")"
        fi
    fi
fi
grep "EventThroughput" SUS-RunIISummer16MiniAODv2-00001_rt.xml 
if [ $? -eq 0 ]; then
  var1=$(grep "EventThroughput" SUS-RunIISummer16MiniAODv2-00001_rt.xml | sed "s/.* Value=\"\(.*\)\".*/\1/")
  echo "McM time_event value: $(bc -l <<< "scale=4; 1/$var1")"
fi
echo CPU efficiency info:
grep "TotalJobCPU" SUS-RunIISummer16MiniAODv2-00001_rt.xml 
grep "TotalJobTime" SUS-RunIISummer16MiniAODv2-00001_rt.xml 

