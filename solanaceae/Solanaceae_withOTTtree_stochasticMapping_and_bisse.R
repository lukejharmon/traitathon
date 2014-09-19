#' Title: Stochastic mapping of traits
#' Description: This script takes user-inputed trait and tree data, makes the tree ultrametric and then generates stochastic maps for the evolution of red and non-red flower color
#' Parameters: treefile.phy
#' Parameters: traitfile.csv
#' Expected output: Plot of tree with results of stochastic mapping
#' Expected output: Values showing average changes for trait across all trees 
  
setwd("~/Desktop/github/traitathon/solanaceae")

require(aRbor)
require(rotl)

#' Get trait data
SolanaceaeTraits <- read.csv("SolanaceaeTraits.csv")

#' Get tree from OpenTree that matches taxa in trait data file
#' Also remove underscores to make retrieving faster - maximum number of taxa can extract is 1000
nameMatches1<-tnrs_match_names(gsub("_", " ", as.character(SolanaceaeTraits[1:1000,1])))
nameMatches2<-tnrs_match_names(gsub("_", " ", as.character(SolanaceaeTraits[1001:1248,1])))

nameMatches<-rbind(nameMatches1, nameMatches2)

ottID<-nameMatches[,4]

#' Remove NAs
ottIDnoNA <- na.omit(ottID)

openTreeSolanaceae<-tol_induced_subtree(ott_ids=ottIDnoNA)
otSolanaceaeTree <- read.tree(text=httr::content(openTreeSolanaceae)$subtree)

#' Let's look at the tree pulled from Open Tree
plot(otSolanaceaeTree, show.tip.label=F)

#' Need branch lengths and no polytomies for analyses
otSolanaceaeTreeBrLen <- compute.brlen(otSolanaceaeTree)
otSolanaceaeTreeBrLen <- multi2di(otSolanaceaeTreeBrLen)

#' Extract OTT ids to sort tree and trait data
SplitTips <- strsplit(otSolanaceaeTreeBrLen$tip.label,"_")

id_tree_order <- sapply(SplitTips,function(x) x[3])
id_character_order <- paste("ott", ottID, sep="")
mm <- match(id_tree_order, id_character_order)
SortedTraitData <- SolanaceaeTraits[mm,]
rownames(SortedTraitData)<-otSolanaceaeTree$tip.label

#' Plot tree
source("plot_trait_dendrogram.R")
plot_trait_dendrogram(otSolanaceaeTreeBrLen, SortedTraitData$State, legend=TRUE, binary=TRUE, tree_type="fan", tiplabel_cex=0.6)

#' Add tree and trait data together
TD <- make.treedata(otSolanaceaeTreeBrLen, SortedTraitData)
TDstate <- select(TD, State)

#' Stochastic map traits using asymmetrical model of character change
StochasticMap <- aceArbor(TDstate, charType="discrete", discreteModelType="ARD", aceType="stochastic")

#' Let's look at the transition rates
StochasticMap$par

#' Diversification analysis with BiSSE
bisseSolanaceae <- bisseArbor(TDstate)

#' Let's see what the diversification rate parameters and log likelihood look like from the analysis
bisseSolanaceae$State$par
bisseSolanaceae$State$lnLik
