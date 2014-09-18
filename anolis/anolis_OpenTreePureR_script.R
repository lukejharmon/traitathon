# First set the correct working directory
# setwd("~/Documents/openTreeHackathon/traitathon/anolis")
require(aRbor)
require(rotl)

# get the data matrix
anoleData<-read.csv("anolis_fullnames.csv")

# fetch the tree from opentree

# TNRS step
split_names<-strsplit(as.character(anoleData[,1]),split="_")
species_names<-sapply(split_names,function(x) paste(x[1],x[2],sep=" "))
nameMatches<-tnrs_match_names(species_names)

ottID<-nameMatches[,4]

# Get tree step

openTreeAnoles<-tol_induced_subtree(ott_ids=ottID)
otAnoleTree <- read.tree(text=httr::content(openTreeAnoles)$subtree)

otAnoleTree <-compute.brlen(otAnoleTree)
otAnoleTree <- multi2di(otAnoleTree)
plot(otAnoleTree)

# Rename data matrix to match ott tip names
nn<-strsplit(otAnoleTree$tip.label, split="_")
id_tree_order<-character(length=100)
for(i in 1:100) 
	id_tree_order[i]<-nn[[i]][3]

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

ecomorph<-anoleData[,"ecomorph"]
names(ecomorph)<-anoleData[,1]

ace(ecomorph, anoleTree, type="discrete")