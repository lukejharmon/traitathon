install.packages(c('devtools', 'igraph')) 


devtools::install_github("fmichonneau/rotl")
devtools::install_github("ropensci/rglobi")

interactions <- rglobi::get_interaction_table(list('Aves'))

get_tree = function(ids) {
  ottIds <- unique(gsub("OTT:", "", ids))
  rotl::tol_induced_subtree(ottIds)
}

par(mfrow=c(1,3))

source_tree <- get_tree(interactions$source_id)
plot(source_tree, main='source taxa')
target_tree <- get_tree(interactions$target_id)
plot(target_tree, main='target tree')

edges <- cbind(interactions$source_id, interactions$target_id)

ids <- c(interactions$source_id, interactions$target_id)
labels <- c(interactions$source_name, interactions$target_name)
vertices <- unique(cbind(ids, labels))
graph <- igraph::graph.data.frame(d= edges, directed=T, vertices = vertices)
igraph::V(graph)$label <- vertices[,2]
igraph::plot.igraph(graph, layout=layout.circle, vertex.color='green', vertex.size=5, main='interactions')
