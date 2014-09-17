
#' plot a phylogeny with discrete character traits
#' 

#' @param apetree an ape tree object
#' @param characters a data frame of species:trait relationship 
#' @param type what class of tree to build
#' @param trait_header the dataframe column header of your character of interest
#' @return diversitree plot with color-coded characters as tips
#' @author alex harkess
#' @examples
#' plot_colored_characters(tree, charactermatrix, tree_type="fan", trait_header="island")

plot_trait_dendrogram <- function(apetree, character_matrix, tree_type="phylogram", trait_header=NULL, legend=TRUE, legend_cex=0.75, tiplabel_cex=0.4, binary_trait=FALSE) {
	
	if (is.null(trait_header)) {
		stop("must specify trait column header")
	}


	plot(apetree, show.tip.label=FALSE, no.margin=FALSE, type=tree_type)
	
	# set tip label colors 
	if(isTRUE(binary_trait)) {
		characters <- character_matrix[[trait_header]]
		characters <- characters + 1
		#tipcols <- c("red","blue")
		tiplabels(col=as.numeric(characters), pch=19, cex=tiplabel_cex)
	}
	else {
		characters <- character_matrix[,trait_header]
		tipcols <- as.numeric(characters)
		tiplabels(col=tipcols, pch=19, cex=tiplabel_cex)
	}
	
	
	if (legend == TRUE) {
		legend("bottomright", as.character(unique(characters)), fill=unique(characters), bty="n", border=FALSE, cex=legend_cex)
	}
}
	
	


