
#' plot a diversitree with colored nodes for character states
#' 

#' @param apetree an ape tree object
#' @param characters a data frame of species:trait relationship 
#' @param type what class of tree to build
#' @param trait_header the dataframe column header of your character of interest
#' @return diversitree plot with color-coded characters as tips
#' @author alex harkess
#' @examples
#' plot_colored_characters(tree, charactermatrix, tree_type="fan", trait_header="island")

plot_colored_characters <- function(apetree, character_matrix, tree_type="phylogram", trait_header=NULL, continuous=FALSE) {
	
	if (!is.null(trait_header)) {
	
		plot(apetree, show.tip.label=FALSE, no.margin=FALSE, type=tree_type)
		characters <- character_matrix[,trait_header]
		tipcols <- as.numeric(characters)
		tiplabels(col=tipcols, pch=19)
		legend("bottomright", as.character(unique(characters)), fill=unique(characters), bty="n", border=FALSE)
	}
	
	else stop("must specify trait column header")
}

