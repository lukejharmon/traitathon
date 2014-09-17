#point to working directory

setwd("~lib/Desktop/github/traitathon/solanaceae")

require(aRbor)

# read in Solanaceae tree
SolanaceaeTree<-read.tree("Solanaceae.phy")

#check whether tree is ultrametric
is.ultrametric(SolanaceaeTree)

#check whether tree is ultrametric
is.binary.tree(SolanaceaeTree)

#make tree ultrametric
chronopl(SolanaceaeTree, lambda=1) -> SolanaceaeTree

####
read.tree("SolanaceaeUltrametric.phy")->SolanaceaeTree
#visualise tree
plot(SolanaceaeTree, "fan", show.tiplabel=FALSE)

# get the data matrix
SolanaceaeTraits<-read.csv("SolanaceaeTraits.csv")
SolanaceaeTraits[,2]->SolanaceaeTraits
names(SolanaceaeTraits)<-SolanaceaeTree$tip.label


# glue traits and trees together
#TD<-make.treedata(SolanaceaeTree, SolanaceaeTraits)
#TDstate<-select(TD, State)

###################
#Stochastic mapping
###################
library(phytools)

#generate 100 stochastic maps
#equal rates model
SimmapEqRates <- make.simmap(SolanaceaeTree, SolanaceaeTraits, nsim=10, model="ER")

#summarize result of stochastic maps and extract average changes for trait across all trees
describe.simmap(SimmapEqRates, plot=T)->SimmapEqRatesResults

#generate 5 stochastic maps for flower color by first sampling 200 values of Q from its Bayesian posterior distribution then transition rates include this uncertainty
SimmapEqRatesMCMC <- make.simmap(SolanaceaeTree, SolanaceaeTraits, nsim=5, Q="mcmc", model="ER", prior=list(beta=2, use.empirical=TRUE))

#plot stochastic mapped traits and extract average changes for trait across all trees
describe.simmap(SimmapEqRatesMCMC, plot=T)-> SimmapEqRatesMCMCResults
