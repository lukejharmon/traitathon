library(diversitree)
library(ape)

##### solanaceae walkthrough #####

sol_tree <- read.tree("/Users/alex/GitHub/traitathon/solanaceae/Solanaceae.tre")
sol_char <- read.csv("/Users/alex/GitHub/traitathon/solanaceae/SolanaceaeTraits.csv", row.names=1)

# make sure the character matrix rows are in the same order as the tree tips
sol_char <- sol_char[sol_tree$tip.label, ]

# we only have one binary character that we want to map onto the tree here.

plot_trait_dendrogram(sol_tree, sol_char, legend=TRUE, binary=TRUE, tree_type="fan", tiplabel_cex=0.2)


##### anolis walkthrough #####

anolis_tree <- read.tree("/Users/alex/GitHub/traitathon/anolis/anolis.phy") 
anolis_char <- read.csv("/Users/alex/GitHub/traitathon/anolis/anolis.csv", row.names=1)

# make sure the character matrix rows are in the same order as the tree tips
anolis_char <- anolis_char[anolis_tree$tip.label, ]

# pick out the character trait to plot
anolis_char <- anolis_char$island

plot_trait_dendrogram(anolis_tree, anolis_char, legend=TRUE, binary=FALSE, tree_type="fan", tiplabel_cex=0.2)


##### heliconia walkthrough #####

helic_tree <- read.tree("/Users/alex/GitHub/traitathon/heliconia/heliconia.phy")
helic_char <- read.csv("/Users/alex/GitHub/traitathon/heliconia/heliconia1.csv", row.names=1)

helic_char <- helic_char[helic_tree$tip.label, ]

# pick out a character trait to plot
helic_arrangement <- helic_char$arrangment
helic_color <- helic_char$perColor


plot_trait_dendrogram(helic_tree, helic_arrangement, legend=TRUE, binary=FALSE, tree_type="phylogram", tiplabel_cex=0.4, legend_loc="bottomleft")

# functions to fiddle with

plot_trait_dendrogram <- function(apetree, character_vector, tree_type="phylogram", binary_trait=FALSE, legend=TRUE, legend_cex=0.75, tiplabel_cex=0.4, legend_loc="bottomleft") {


	plot(apetree, show.tip.label=FALSE, no.margin=FALSE, type=tree_type)
	
	# binary plot colors and legend 
	if(isTRUE(binary_trait)) {
		character_vector <- character_vector + 1
		tipcols <- c("black","red")
		tiplabels(col=tipcols[character_vector], pch=19, cex=tiplabel_cex)
		
		if(isTRUE(legend)) {
			legend(legend_loc, as.character(unique(character_vector)), fill=unique(tipcols[character_vector]), bty="n", border=FALSE, cex=legend_cex)
		}
	}
	# discrete plot colors and legend
	else {
		tiplabels(col=character_vector, pch=19, cex=tiplabel_cex)
		if(isTRUE(legend)) {
			legend(legend_loc, as.character(unique(character_vector)), fill=as.numeric(unique(character_vector)), bty="n", border=FALSE, cex=legend_cex)
		}
	}
}
	
	


