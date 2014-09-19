# First set the correct working directory
# setwd("~/Documents/openTreeHackathon/traitathon/anolis")
require(aRbor)
require(phytools)
require(ape)
require(dplyr)
require(rotl)

# get the data matrix
anoleData<-read.csv("anolis_fullnames.csv")

# fetch the tree from opentree

# TNRS step
species_names<-gsub(anoleData[,1],pattern="_",replacement=" ")
ottID<-tnrs_match_names(species_names)[,4]

# Get tree step

otAnoleTree<-tol_induced_subtree(ott_ids=ottID)
otAnoleTree <-compute.brlen(otAnoleTree)
otAnoleTree <- multi2di(otAnoleTree)
plot(otAnoleTree)

# Sort data matrix to match ott tip names
nn<-strsplit(otAnoleTree$tip.label, split="_")
id_tree_order<-sapply(nn,function(x) x[3])
id_character_order<-paste("ott",ottID, sep="")

mm<-match(id_tree_order, id_character_order)

anoleDataSorted<-anoleData[mm,]
rownames(anoleDataSorted)<-otAnoleTree$tip.label

# glue traits and trees together
td<-make.treedata(otAnoleTree, anoleDataSorted)
tdEcomorph<-select(td, ecomorph)

# now reconstruct and plot ancestral states using aRbor
ancestralStates<-aceArbor(tdEcomorph, charType="discrete", aceType="marginal")
plot(ancestralStates)