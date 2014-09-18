#' Description: Trims ottIDs off of tip labels of phylo objects
#' Parameters: tree (phylo object, usually queried from OpenTree with otts in tip labels)
#' Expected output: tree2 (phylo object, same as tree but without ott ID)
#' Author: Shan Kothari

trim.OT.labels<-function(tree){
  tree2<-tree
  ## split where you find "_ott" plus a number
  split_tip_list<-strsplit(tree$tip.label,paste("ott","(?=[0-9])",sep=""),perl=T)
  trimmed_labels<-sapply(split_tip_list,function(tip) tip[1])
  tree2$tip.label<-trimmed_labels
  return(tree2)
}
