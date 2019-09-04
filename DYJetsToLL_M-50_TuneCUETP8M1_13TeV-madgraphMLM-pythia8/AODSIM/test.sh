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
#cmsDriver.py step1 --filein "dbs:/DYJetsToLL_M-50_TuneCUETP8M1_13TeV-madgraphMLM-pythia8/RunIISummer15GS-MCRUN2_71_V1_ext1-v1/GEN-SIM" --fileout file:SUS-RunIISummer16DR80Premix-00036_step1.root  --pileup_input "dbs:/Neutrino_E-10_gun/RunIISpring15PrePremix-PUMoriond17_80X_mcRun2_asymptotic_2016_TrancheIV_v2-v2/GEN-SIM-DIGI-RAW" --mc --eventcontent PREMIXRAW --datatier GEN-SIM-RAW --conditions 80X_mcRun2_asymptotic_2016_TrancheIV_v6 --step DIGIPREMIX_S2,DATAMIX,L1,DIGI2RAW,HLT:@frozen2016 --nThreads 1 --datamix PreMix --era Run2_2016 --python_filename SUS-RunIISummer16DR80Premix-00036_1_cfg.py --no_exec --customise Configuration/DataProcessing/Utils.addMonitoring -n 10 || exit $? ; 
cmsDriver.py step1 --filein "file:/home/home2/institut_3b/tmuller/home/cms/htt/generator/DYJetsToLL_M-50_reproduction/GEN-SIM/SUS-RunIISummer15GS-00148.root" --fileout file:SUS-RunIISummer16DR80Premix-00036_step1.root  --pileup_input "dbs:/Neutrino_E-10_gun/RunIISpring15PrePremix-PUMoriond17_80X_mcRun2_asymptotic_2016_TrancheIV_v2-v2/GEN-SIM-DIGI-RAW" --mc --eventcontent PREMIXRAW --datatier GEN-SIM-RAW --conditions 80X_mcRun2_asymptotic_2016_TrancheIV_v6 --step DIGIPREMIX_S2,DATAMIX,L1,DIGI2RAW,HLT:@frozen2016 --nThreads 1 --datamix PreMix --era Run2_2016 --python_filename SUS-RunIISummer16DR80Premix-00036_1_cfg.py --no_exec --customise Configuration/DataProcessing/Utils.addMonitoring -n 10 || exit $? ; 
#cmsRun -e -j SUS-RunIISummer16DR80Premix-00036_rt.xml SUS-RunIISummer16DR80Premix-00036_1_cfg.py || exit $? ; 
cmsRun -e -j SUS-RunIISummer16DR80Premix-00036_rt.xml -p PSet.py || exit $? ; 
cp SUS-RunIISummer16DR80Premix-00036_rt.xml FrameworkJobReport.xml
echo 10 events were ran 
grep "TotalEvents" SUS-RunIISummer16DR80Premix-00036_rt.xml 
if [ $? -eq 0 ]; then
    grep "Timing-tstoragefile-write-totalMegabytes" SUS-RunIISummer16DR80Premix-00036_rt.xml 
    if [ $? -eq 0 ]; then
        events=$(grep "TotalEvents" SUS-RunIISummer16DR80Premix-00036_rt.xml | tail -1 | sed "s/.*>\(.*\)<.*/\1/")
        size=$(grep "Timing-tstoragefile-write-totalMegabytes" SUS-RunIISummer16DR80Premix-00036_rt.xml | sed "s/.* Value=\"\(.*\)\".*/\1/")
        if [ $events -gt 0 ]; then
            echo "McM Size/event: $(bc -l <<< "scale=4; $size*1024 / $events")"
        fi
    fi
fi
grep "EventThroughput" SUS-RunIISummer16DR80Premix-00036_rt.xml 
if [ $? -eq 0 ]; then
  var1=$(grep "EventThroughput" SUS-RunIISummer16DR80Premix-00036_rt.xml | sed "s/.* Value=\"\(.*\)\".*/\1/")
  echo "McM time_event value: $(bc -l <<< "scale=4; 1/$var1")"
fi
echo CPU efficiency info:
grep "TotalJobCPU" SUS-RunIISummer16DR80Premix-00036_rt.xml 
grep "TotalJobTime" SUS-RunIISummer16DR80Premix-00036_rt.xml 

cmsDriver.py step2 --filein file:SUS-RunIISummer16DR80Premix-00036_step1.root --fileout file:SUS-RunIISummer16DR80Premix-00036.root --mc --eventcontent AODSIM --runUnscheduled --datatier AODSIM --conditions 80X_mcRun2_asymptotic_2016_TrancheIV_v6 --step RAW2DIGI,RECO,EI --nThreads 1 --era Run2_2016 --python_filename SUS-RunIISummer16DR80Premix-00036_2_cfg.py --no_exec --customise Configuration/DataProcessing/Utils.addMonitoring -n -1 || exit $? ; 
cmsRun -e -j SUS-RunIISummer16DR80Premix-00036_2_rt.xml SUS-RunIISummer16DR80Premix-00036_2_cfg.py || exit $? ; 
#cmsRun -e -j SUS-RunIISummer16DR80Premix-00036_2_rt.xml -p PSet.py || exit $? ; 
#cp SUS-RunIISummer16DR80Premix-00036_2_rt.xml FrameworkJobReport.xml
mv SUS-RunIISummer16DR80Premix-00036_step1.root SUS-RunIISummer16DR80Premix-00036_step1_backup.root
mv SUS-RunIISummer16DR80Premix-00036.root SUS-RunIISummer16DR80Premix-00036_step1.root
echo 10 events were ran 
grep "TotalEvents" SUS-RunIISummer16DR80Premix-00036_2_rt.xml 
if [ $? -eq 0 ]; then
    grep "Timing-tstoragefile-write-totalMegabytes" SUS-RunIISummer16DR80Premix-00036_2_rt.xml 
    if [ $? -eq 0 ]; then
        events=$(grep "TotalEvents" SUS-RunIISummer16DR80Premix-00036_2_rt.xml | tail -1 | sed "s/.*>\(.*\)<.*/\1/")
        size=$(grep "Timing-tstoragefile-write-totalMegabytes" SUS-RunIISummer16DR80Premix-00036_2_rt.xml | sed "s/.* Value=\"\(.*\)\".*/\1/")
        if [ $events -gt 0 ]; then
            echo "McM Size/event: $(bc -l <<< "scale=4; $size*1024 / $events")"
        fi
    fi
fi
grep "EventThroughput" SUS-RunIISummer16DR80Premix-00036_2_rt.xml 
if [ $? -eq 0 ]; then
  var1=$(grep "EventThroughput" SUS-RunIISummer16DR80Premix-00036_2_rt.xml | sed "s/.* Value=\"\(.*\)\".*/\1/")
  echo "McM time_event value: $(bc -l <<< "scale=4; 1/$var1")"
fi
echo CPU efficiency info:
grep "TotalJobCPU" SUS-RunIISummer16DR80Premix-00036_2_rt.xml 
grep "TotalJobTime" SUS-RunIISummer16DR80Premix-00036_2_rt.xml 

