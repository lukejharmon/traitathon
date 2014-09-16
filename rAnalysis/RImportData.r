get_traits<-function(trait_file_path){
	## this is to be replaced with a way of calling traits
	## given species names
	trait_mat<-read.csv(trait_file_path)
}

get_tree<-function(tree_file_path){
	require(ape)
	## this is to be replaced with a way of calling trees
	## from Open Tree given species names
	tree<-read.tree(tree_file_path)
}