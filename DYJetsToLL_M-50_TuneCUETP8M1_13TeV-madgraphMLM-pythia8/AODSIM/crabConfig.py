from CRABClient.UserUtilities import config, getUsernameFromSiteDB
config = config()

config.General.requestName = "my_aod_DYJetsToLL_M-50_TuneCUETP8M1_13TeV-madgraphMLM-pythia8"
config.General.workArea = "./crab_workarea"
config.General.transferOutputs = True
config.General.transferLogs = True

config.User.voGroup = "dcms"

config.JobType.pluginName = "Analysis"
config.JobType.psetName = "SUS-RunIISummer16DR80Premix-00036_1_cfg.py"
config.JobType.inputFiles = ["test.sh"]
config.JobType.scriptExe = "./test.sh"
#config.JobType.numCores = 4

config.Data.inputDataset = "/DYJetsToLL_M-50_TuneCUETP8M1_13TeV-madgraphMLM-pythia8/tmuller-RunIISummer15GS-MCRUN2_71_V1_ext1-v1-bc6542fc445f5a15d4743bf84e6db154/USER"
config.Data.inputDBS = "phys03"

config.Data.splitting = "FileBased"
config.Data.unitsPerJob = 1
config.Data.outLFNDirBase = "/store/user/%s/private_mc" % (getUsernameFromSiteDB())
config.Data.publication = True
config.Data.publishDBS = "phys03"
config.Data.outputDatasetTag = "RunIISummer16DR80Premix-PUMoriond17_80X_mcRun2_asymptotic_2016_TrancheIV_v6_ext1-v1"

config.Site.storageSite = "T2_DE_RWTH"
