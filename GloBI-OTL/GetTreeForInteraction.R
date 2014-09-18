# install.packages(c('devtools', 'igraph')) 

devtools::install_github("fmichonneau/rotl")
devtools::install_github("ropensci/rglobi")

if (!exists('sourceTaxonNames')) { stop('sourceTargetName not defined') }
if (!exists('targetTaxonNames')) { stop('targetTaxonNames not defined') }
if (!exists('interactionType')) { stop('interactionType not defined') }

interactionTable <- rglobi::get_interaction_table(source.taxon.names = sourceTaxonNames, target.taxon.names = targetTaxonNames, interaction.type = interactionType)

get_tree = function(ids) {
  ottIds <- unique(gsub("OTT:", "", ids))
  rotl::tol_induced_subtree(ottIds)
}

sourceTree <- get_tree(interactionTable$source_id)
targetTtree <- get_tree(interactionTable$target_id)


par(mfrow=c(1,3))

plot(source_tree, main='source taxa')
plot(target_tree, main='target tree')

edges <- cbind(interactions$source_id, interactions$target_id)

ids <- c(interactions$source_id, interactions$target_id)
labels <- c(interactions$source_name, interactions$target_name)
vertices <- unique(cbind(ids, labels))
graph <- igraph::graph.data.frame(d= edges, directed=T, vertices = vertices)
igraph::V(graph)$label <- vertices[,2]

igraph::plot.igraph(graph, layout=layout.circle, vertex.color='green', vertex.size=5, main='interactions')
