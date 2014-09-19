Retrieve Biotic Interactions and associated phylogenetic trees
==========

The biotic interactions are retrieved in the example code from GloBI using https://github.com/ropensci/rglobi . The phylogenetic trees are retrieved in the example code from Open Tree of Life using https://github.com/fmichonneau/rotl.

However, as of 9/19/2014, the phylogeny of pocket gopher lice is not well-resolved in Open Tree of Life, so the file Lice_Hafner.phy takes the phylogeny from Hafner et al. 1994, fig. 2A. This phylogeny can be used instead of drawing trees from Open Tree if you want to see a resolved phylogeny.

Includes:
  PlotInteractionTreesAndNetworkExample.R - an example for running in R, using gophers and lice.
  GetInteractionMatrix.R - Arbor R snippet to retrieve an interaction matrix
  GetInteractionTrees.R - Arbor R snippet to retrieve an interaction edge table and associated trees for target and source taxa.

