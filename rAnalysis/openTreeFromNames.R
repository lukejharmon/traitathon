#' Description: Using a set of species names, get tree from OpenTree
#' Parameters: species_names (character vector of scientific names)
#' Parameters: underscores (boolean, TRUE means scientific names have underscores)
#' For example, T for "Anolis_ahli", F for "Anolis ahli"
#' Expected output: A phylo object containing the species denoted by the input
#' Author: Shan Kothari

OT.from.names<-function(species_names,underscores=F){
  # if underscores==T, replaces with a space to enable faster exact
  # rather than fuzzy matching; also discards anything other than genus and species
  if(underscores==T){
    split_names<-strsplit(species_names,split="_")
    species_names<-sapply(split_names, function(x) paste(x[1],x[2],sep=" "))
  # if underscores==F, just discards anything past genus and species
  } else {split_names<-strsplit(species_names,sep=" ")
    species_names<-sapply(split_names, function(x) paste(x[1],x[2],sep=" "))
  }
  # retrieves OpenTree IDs for species
  name_matches<-tnrs_match_names(species_names)
  ottID<-name_matches[,4]
  # retrieves tree from OpenTree IDs
  OT_phylo<-tol_induced_subtree(ott_ids=ottID)
  return(OT_phylo)
}