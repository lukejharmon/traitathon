# install.packages(c('devtools', 'igraph')) 

devtools::install_github("fmichonneau/rotl")
devtools::install_github("ropensci/rglobi")

if (!exists('sourceTaxonNames')) { stop('sourceTargetName not defined') }
if (!exists('targetTaxonNames')) { stop('targetTaxonNames not defined') }
if (!exists('interactionType')) { stop('interactionType not defined') }

interactionMatrix <- rglobi::get_interaction_matrix(source.taxon.names = sourceTaxonNames, target.taxon.names = targetTaxonNames, interaction.type = interactionType)
