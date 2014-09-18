library(diversitree)
library(ape)

##### solanaceae walkthrough #####

sol_tree <- read.tree("/Users/alex/GitHub/traitathon/solanaceae/Solanaceae.tre")
sol_char <- read.csv("/Users/alex/GitHub/traitathon/solanaceae/SolanaceaeTraits.csv", row.names=1)

# make sure the character matrix rows are in the same order as the tree tips
sol_char <- sol_char[sol_tree$tip.label, ]

plot_trait_dendrogram(sol_tree, sol_char, legend=TRUE, binary=TRUE, tree_type="fan", tiplabel_cex=0.2)


##### anolis walkthrough #####

anolis_tree <- read.tree("/Users/alex/GitHub/traitathon/anolis/anolis.phy") 
anolis_char <- read.csv("/Users/alex/GitHub/traitathon/anolis/anolis.csv", row.names=1)

# make sure the haracter matrix rows are in the same order as the tree tips
anolis_char <- anolis_char[anolis_tree$tip.label, ]

# pick out the character trait to plot
anolis_char <- anolis_char$island

plot_trait_dendrogram(anolis_tree, anolis_char, legend=TRUE, binary=FALSE, tree_type="fan", tiplabel_cex=0.2)


##### using the tree of sex with a user-provided tree #####



# functions to fiddle with

plot_trait_dendrogram <- function(apetree, character_vector, tree_type="phylogram", binary_trait=FALSE, legend=TRUE, legend_cex=0.75, tiplabel_cex=0.4) {


	plot(apetree, show.tip.label=FALSE, no.margin=FALSE, type=tree_type)
	
	# binary plot colors and legend 
	if(isTRUE(binary_trait)) {
		character_vector <- character_vector + 1
		tipcols <- c("black","red")
		tiplabels(col=tipcols[character_vector], pch=19, cex=tiplabel_cex)
		
		if(isTRUE(legend)) {
			legend("bottomright", as.character(unique(character_vector)), fill=unique(tipcols[character_vector]), bty="n", border=FALSE, cex=legend_cex)
		}
	}
	# discrete plot colors and legend
	else {
		tiplabels(col=character_vector, pch=19)
		if(isTRUE(legend)) {
			legend("bottomright", as.character(unique(character_vector)), fill=as.numeric(unique(character_vector)), bty="n", border=FALSE, cex=legend_cex)
		}
	}
}
	
	


