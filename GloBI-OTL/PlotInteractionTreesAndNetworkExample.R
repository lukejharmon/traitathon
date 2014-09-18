# install.packages(c('devtools', 'igraph')) 

devtools::install_github("fmichonneau/rotl")
devtools::install_github("ropensci/rglobi")

# retrieve interaction table from GloBI
interactionTable <- rglobi::get_interaction_table(c('Aves'))

get_tree = function(ids) {
  ottIds <- unique(gsub("OTT:", "", ids))
  rotl::tol_induced_subtree(ottIds)
}

# get derived trees from OpenTree of Life 
sourceTree <- get_tree(interactionTable$source_id)
targetTree <- get_tree(interactionTable$target_id)

# start plotting
par(mfrow=c(1,3))

plot(sourceTree, main='source taxa')
plot(targetTree, main='target tree')

# transform interaction table to edges and vertices
edges <- cbind(interactionTable$source_id, interactionTable$target_id)
ids <- c(interactionTable$source_id, interactionTable$target_id)
labels <- c(interactionTable$source_name, interactionTable$target_name)
vertices <- unique(cbind(ids, labels))
graph <- igraph::graph.data.frame(d= edges, directed=T, vertices = vertices)
igraph::V(graph)$label <- vertices[,2]

# plot interaction network
igraph::plot.igraph(graph, layout=igraph::layout.circle, vertex.color='green', vertex.size=5, main='interactions')
