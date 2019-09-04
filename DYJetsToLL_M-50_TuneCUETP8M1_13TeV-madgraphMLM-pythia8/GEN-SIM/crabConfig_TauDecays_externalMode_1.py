from CRABClient.UserUtilities import config, getUsernameFromSiteDB
config = config()

config.General.requestName = "my_gensim_DYJetsToLL_M-50_TuneCUETP8M1_13TeV-madgraphMLM-pythia8_TauDecays_externalMode_1"
config.General.workArea = "./crab_workarea_TauDecays_externalMode_1"
config.General.transferOutputs = True
config.General.transferLogs = True

config.User.voGroup = "dcms"

config.JobType.pluginName = "Analysis"
config.JobType.psetName = "SUS-RunIISummer15GS-00148_1_TauDecays_externalMode_1_cfg.py"
config.JobType.inputFiles = ["test.sh"]
config.JobType.scriptExe = "./test.sh"

config.Data.inputDataset = "/DYJetsToLL_M-50_TuneCUETP8M1_13TeV-madgraphMLM-pythia8/tmuller-RunIIWinter15wmLHE-MCRUN2_71_V1_ext1-v1-8793131d8750c177285c8434000be34a/USER"
config.Data.inputDBS = "phys03"

config.Data.splitting = "FileBased"
config.Data.unitsPerJob = 2
config.Data.outLFNDirBase = "/store/user/%s/private_mc" % (getUsernameFromSiteDB())
config.Data.publication = True
config.Data.publishDBS = "phys03"
config.Data.outputDatasetTag = "RunIISummer15GS-MCRUN2_71_V1_ext1-v1_TauDecays_externalMode_1"

config.Site.storageSite = "T2_DE_RWTH"
