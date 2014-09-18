
#' plot a phylogeny with discrete character traits
#' 

#' @param apetree an ape tree object
#' @param characters a data frame of species:trait relationship 
#' @param type what class of tree to build
#' @param trait_header the dataframe column header of your character of interest
#' @return diversitree plot with color-coded characters as tips
#' @author alex harkess
#' @examples
#' plot_trait_dendrogram(tree, charactermatrix, tree_type="fan")

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
	


