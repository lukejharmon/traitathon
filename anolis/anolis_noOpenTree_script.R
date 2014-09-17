# First set the correct working directory
# setwd("~/Documents/openTreeHackathon/traitathon/anolis")
require(aRbor)

# read in anolis phylogenetic tree
anoleTree<-read.tree("anolis.phy")
plot(anoleTree)

# get the data matrix
anoleData<-read.csv("anolis.csv")

# glue traits and trees together
td<-make.treedata(anoleTree, anoleData)
tdEcomorph<-select(td, ecomorph)

# now reconstruct and plot ancestral states using aRbor
ancestralStates<-aceArbor(tdEcomorph, charType="discrete", aceType="marginal")
plot(ancestralStates)

ecomorph<-anoleData[,"ecomorph"]
names(ecomorph)<-anoleData[,1]

ace(ecomorph, anoleTree, type="discrete")