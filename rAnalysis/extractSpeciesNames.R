extract_species_names<-function(tree,trait_df){
  if(!is.null(tree) && !is.null(trait_df)){
      stop("Use either tree or trait matrix, not both")
  }
  else if(class(tree)=="phylo"){
    species_names<-phylo$tip.label
  }
  else if(class(trait_df)=="data.frame"){
    ## this is just a heuristic
    ## Zack can input flexible code to look for species among colnames
    ## Then we can also add an error message in case they can't be found
    species_names<-trait_df[,1]
  }
  else{
    stop("Could not interpret file")
  }
}