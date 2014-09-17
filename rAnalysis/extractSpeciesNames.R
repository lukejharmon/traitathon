# Given a trait matrix or a tree, this function will ideally extract species names
# For a tree, it will just return the tip labels, so the tree tips should be the species names
# For a trait matrix, it will search for a column containing species names based on the column name
# Species names should not be rownames

# Species names can subsequently be used to extract a tree from OpenTree,
# or to get a trait matrix from a database, and so on.

get.spnames<-function(trait_df=NULL,tree=NULL){
# only allow either a tree or a trait matrix
  if(!is.null(tree) && !is.null(trait_df)){
      stop("Use either tree or trait matrix, not both")
  }
# if the input is a tree, returns the tip labels
  else if(class(tree)=="phylo"){
    species_names<-phylo$tip.label
  }
# if the input is a data matrix, searches for species names using column names
  else if(class(trait_df)=="data.frame"){
    sp_head<-c("species","scientific name","scientific_name","scientific.name","name")
    sp_match<-grep(paste(sp_head,collapse="|"),colnames(trait_df),ignore.case=T)
    # if no columns match
    if(length(sp_match)<1){
      stop("Could not find column containing species")
      # if multiple columns match
    } else if(length(sp_match)>1){
      stop("Could not uniquely identify column containing species")
      # if only one column matches, contents of column are assumed to be sp names
    } else if(length(sp_match)==1){
      species_names<-trait_df[,sp_match]
    }
  }
  ## if the tree isn't a phylo, or the trait matrix a data frame
  else{
    stop("Could not interpret file")
  }
  return(as.character(species_names))
}