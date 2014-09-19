#' Description: Using a set of species names, get tree from OpenTree
#' Parameters: species_names (character vector of scientific names)
#' Parameters: underscores (boolean, TRUE means scientific names have underscores)
#' For example, T for "Anolis_ahli", F for "Anolis ahli"
#' Expected output: A phylo object containing the species denoted by the input
#' Author: Shan Kothari

OT.from.names<-function(species_names,underscores=F,binomials=T){
  # if underscores==T, replaces with a space to enable faster exact
  # rather than fuzzy matching; also discards anything other than genus and species
  if(underscores==T){
    species_names<-gsub(species_names,pattern="_",replacement=" ")
  }
  # discards anything past genus and species if binomials=T
  if(binomials=T){
    split_names<-strsplit(species_names,split=" ")
    species_names<-sapply(split_names, function(x) paste(x[1],x[2],sep=" "))
  }
  # retrieves OpenTree IDs for species, then tree from ottID
  # tnrs_match_name currently fails for species with hyphens
  ottID<-tnrs_match_names(species_names)[,4]
  OT_phylo<-tol_induced_subtree(ott_ids=ottID)
  return(OT_phylo)
}