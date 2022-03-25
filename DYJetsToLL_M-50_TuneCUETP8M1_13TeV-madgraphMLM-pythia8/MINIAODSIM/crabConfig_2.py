from CRABClient.UserUtilities import config

config = config()

config.section_("General")
config.General.requestName = "my_miniaod_DYJetsToTauTau_M-50_TuneCUETP8M1_13TeV-madgraphMLM-pythia8_ext2"
config.General.workArea = "/opt/sbg/cms/ui2_data1/cgrimault/private_mc_workdir/"
config.General.transferOutputs = True
config.General.transferLogs = True

config.section_("JobType")
config.JobType.pluginName = "Analysis"
config.JobType.psetName = "SMP-RunIISummer16MiniAODv3-00001_1_cfg.py"
#config.JobType.inputFiles = ["test.sh", "private_DYJetsToTauTau_inputFiles.txt"]
config.JobType.inputFiles = ["private_dy_input_files_ext2.txt"]
#config.JobType.scriptExe = "./test.sh"

config.section_("Data")
#config.Data.inputDataset = "/DYJetsToLL_M-50_TuneCUETP8M1_13TeV-madgraphMLM-pythia8/tmuller-RunIISummer16DR80Premix-PUMoriond17_80X_mcRun2_asymptotic_2016_TrancheIV_v6_ext1-v1-b1a4edca9adfa7a2e4059536bf605cd7/USER"
#config.Data.inputDBS = "phys03"
#config.Data.splitting = "FileBased"
#config.Data.unitsPerJob = 1
#config.Data.publication = True
#config.Data.publishDBS = "phys03"

#### TO ADD !!!!! ####
config.Data.userInputFiles = open('private_dy_input_files_ext2.txt').readlines()

#config.Data.userInputFiles = ["root://sbgse1.in2p3.fr://dpm/in2p3.fr/home/cms/phedex/store/user/cgrimaul/tau_polarisation/aachen/private_mc/DYJetsToTauTau_M-50_TuneCUETP8M1_13TeV-madgraphMLM-pythia8/RunIISummer16DR80Premix-PUMoriond17_80X_mcRun2_asymptotic_2016_TrancheIV_v6_ext1-v1/191007_095808/0000/SUS-RunIISummer16DR80Premix-00036_step1_100.root"]

config.Data.splitting = "FileBased"
config.Data.unitsPerJob = 1
config.Data.totalUnits = -1
config.Data.outLFNDirBase = "/store/user/cgrimaul/private_mc"
config.Data.outputPrimaryDataset = "DYJetsToTauTau_M-50_TuneCUETP8M1_13TeV-madgraphMLM-pythia8"
config.Data.outputDatasetTag = "RunIISummer16MiniAODv3-PUMoriond17_94X_mcRun2_asymptotic_v3_ext2"

config.section_("Site")
config.Site.storageSite = "T2_FR_IPHC"
config.Site.whitelist = ["T2_FR_IPHC"]

# User
#config.User.voGroup = "cms"
