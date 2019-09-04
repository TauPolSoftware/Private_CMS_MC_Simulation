from CRABClient.UserUtilities import config, getUsernameFromSiteDB
config = config()

config.General.requestName = "my_lhe_DYJetsToLL_M-50_TuneCUETP8M1_13TeV-madgraphMLM-pythia8"
config.General.workArea = "./crab_workarea"
config.General.transferOutputs = True
config.General.transferLogs = True

config.User.voGroup = "dcms"

config.JobType.pluginName = "PrivateMC"
config.JobType.psetName = "SUS-RunIIWinter15wmLHE-00098_1_cfg.py"
config.JobType.inputFiles = ["test.sh"]
config.JobType.scriptExe = "./test.sh"

config.Data.outputPrimaryDataset = "DYJetsToLL_M-50_TuneCUETP8M1_13TeV-madgraphMLM-pythia8"
config.Data.splitting = "EventBased"
config.Data.unitsPerJob = 1000
config.Data.totalUnits = 100000
config.Data.outLFNDirBase = "/store/user/%s/private_mc" % (getUsernameFromSiteDB())
config.Data.publication = True
config.Data.publishDBS = "phys03"
config.Data.outputDatasetTag = "RunIIWinter15wmLHE-MCRUN2_71_V1_ext1-v1"

config.Site.storageSite = "T2_DE_RWTH"
