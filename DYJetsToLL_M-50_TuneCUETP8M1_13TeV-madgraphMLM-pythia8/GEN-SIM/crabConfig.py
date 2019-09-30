from CRABClient.UserUtilities import config, getUsernameFromSiteDB
config = config()

config.General.requestName = "my_gensim_DYJetsToTauTau_M-50_TuneCUETP8M1_13TeV-madgraphMLM-pythia8"
config.General.workArea = "./crab_workarea"
config.General.transferOutputs = True
config.General.transferLogs = True

config.User.voGroup = "dcms"

config.JobType.pluginName = "Analysis"
config.JobType.psetName = "SUS-RunIISummer15GS-00148_1_cfg.py"
config.JobType.inputFiles = ["test.sh"]
config.JobType.scriptExe = "./test.sh"
config.JobType.maxMemoryMB = 2000
config.JobType.maxJobRuntimeMin = 2000

config.Data.inputDataset = "/DYJetsToTauTau_M-50_TuneCUETP8M1_13TeV-madgraphMLM-pythia8/tmuller-RunIIWinter15wmLHE-MCRUN2_71_V1_ext1-v1-7f7e6017268932b66086dd43c4453d63/USER"
config.Data.inputDBS = "phys03"

config.Data.splitting = "FileBased"
config.Data.unitsPerJob = 1
config.Data.outLFNDirBase = "/store/user/%s/private_mc" % (getUsernameFromSiteDB())
config.Data.publication = True
config.Data.publishDBS = "phys03"
config.Data.outputDatasetTag = "RunIISummer15GS-MCRUN2_71_V1_ext1-v1"

config.Site.storageSite = "T2_DE_RWTH"
