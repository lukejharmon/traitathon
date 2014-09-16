# First set the correct working directory
# setwd("~/Documents/openTreeHackathon/traitathon/heliconia")
require(aRbor)

# read in heliconia phylogenetic tree
heliTree<-read.tree("HeliconiaSelectEdit.phy")
plot(heliTree)

# get the data matrix
heliData<-read.csv("heliconia1.csv")
for(i in 7:13) 
	heliData[,i]<-as.numeric(as.character(heliData[,i]))

# glue traits and trees together
heliContinuousTd<-make.treedata(heliTree, heliData[,c(1,7:13)])

continuousCorrelation(heliContinuousTd)