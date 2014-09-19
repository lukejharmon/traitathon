# install.packages(c('devtools', 'igraph')) 

devtools::install_github("fmichonneau/rotl", ref="2277f68e0441d83304caf84759c98a1eb66dd358")
devtools::install_github("ropensci/rglobi")

plotTreesAndInteractions <- function(source.taxa, target.taxa) {
  interactionTable <- rglobi::get_interaction_table(source.taxon.names = source.taxa, target.taxon.names = target.taxa, interaction.type = 'parasiteOf', limit = 1500)

  get_tree = function(ids) {
    ottIds <- unique(gsub("OTT:", "", ids))
    rotl::tol_induced_subtree(ott_ids = ottIds)
  }

  # get derived trees from OpenTree of Life 
  sourceTree <- get_tree(interactionTable$source_id)
  targetTree <- get_tree(interactionTable$target_id)

  # start plotting
  par(mfrow=c(1,3))

  plot(sourceTree, main='parasites')
  plot(targetTree, main='hosts')

  # transform interaction table to edges and vertices
  edges <- cbind(interactionTable$source_id, interactionTable$target_id)
  ids <- c(interactionTable$source_id, interactionTable$target_id)
  labels <- c(interactionTable$source_name, interactionTable$target_name)
  vertices <- unique(cbind(ids, labels))
  graph <- igraph::graph.data.frame(d= edges, directed=T, vertices = vertices)
  igraph::V(graph)$label <- vertices[,2]

  # plot interaction network
  igraph::plot.igraph(graph, layout=igraph::layout.circle, vertex.color='green', vertex.size=5, main='parasite-host interactions')
}

chipmunks <- list('Tamias')

chewingLice <- c('Geomydoecus', 'Thomomydoecus')
# pocket gophers
pocketGophers <- c('Geomyidae')

#plotTreesAndInteractions(list(), chipmunks)
plotTreesAndInteractions(chewingLice, pocketGophers)
