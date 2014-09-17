#' Title: Plot a phylogeny with discrete character traits <br />
#' Description: Plots a phylogeny with binary or discrete character states, given a tree and a trait matrix <br />
#'
#' Parameters: apetree (an ape tree object) <br />
#' Parameters: character_matrix (a data frame of species:trait relationship) <br />
#' Parameters: tree_type (what class of tree to build; defaults to phylogram) <br />
#' Parameters: header (the dataframe column header of your character of interest) <br />
#' Expected output: diversitree plot with color-coded characters as tips <br />
#' Author: Alex Harkess <br />
#' Example: plot_trait_dendrogram(tree, charactermatrix, tree_type="fan", trait_header="island")

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