#' Reading and visualizing tree:trait data
library(ape)
library(diversitree)
source('/Users/alex/GitHub/traitathon/treeOfSex/plot_trait_dendrogram.R')


#' Plotting character states onto the Solanaceae 

sol_tree <- read.tree("/Users/alex/GitHub/traitathon/solanaceae/Solanaceae.tre")
sol_char <- read.csv("/Users/alex/GitHub/traitathon/solanaceae/SolanaceaeTraits.csv", row.names=1)

#' make sure the character matrix rows are in the same order as the tree tips
sol_char <- sol_char[sol_tree$tip.label, ]

#' we only have one binary character that we want to map onto the tree here.
plot_trait_dendrogram(sol_tree, sol_char, legend=TRUE, binary=TRUE, tree_type="fan", tiplabel_cex=0.2)


#' anolis walkthrough
anolis_tree <- read.tree("/Users/alex/GitHub/traitathon/anolis/anolis.phy") 
anolis_char <- read.csv("/Users/alex/GitHub/traitathon/anolis/anolis.csv", row.names=1)

#' make sure the character matrix rows are in the same order as the tree tips
anolis_char <- anolis_char[anolis_tree$tip.label, ]

#' pick out the character trait to plot
anolis_char <- anolis_char$island

plot_trait_dendrogram(anolis_tree, anolis_char, legend=TRUE, binary=FALSE, tree_type="fan", tiplabel_cex=0.5)

#' maybe this would look better as a regular phylogram
plot_trait_dendrogram(anolis_tree, anolis_char, legend=TRUE, binary=FALSE, tree_type="phylogram", tiplabel_cex=0.25)


#' heliconia walkthrough

helic_tree <- read.tree("/Users/alex/GitHub/traitathon/heliconia/heliconia.phy")
helic_char <- read.csv("/Users/alex/GitHub/traitathon/heliconia/heliconia1.csv", row.names=1)

helic_char <- helic_char[helic_tree$tip.label, ]

#' pick out a character trait to plot
helic_arrangement <- helic_char$arrangment
helic_color <- helic_char$perColor


plot_trait_dendrogram(helic_tree, helic_arrangement, legend=TRUE, binary=FALSE, tree_type="phylogram", tiplabel_cex=0.4, legend_loc="bottomleft")


#' plot tree of sex data onto heliconia #####


