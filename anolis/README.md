Anolis
==========

Analysis of anole ecomorph evolution.

The data includes a phylogenetic tree with branch lengths (in relative time units; anolis.phy) and a character matrix (anolis.csv).

The goal of the analysis is to construct two workflows:

Analysis "Anolis A"

1. Start with the phylogenetic tree and the data matrix.
2. Match the row names in the matrix to the tips of the tree
3. Reconstruct ancestral states for ecomorph and make a plot.

Analysis "Anolis B"

1. Start with two columns in the data matrix, "name" and "ecomorph." 
2. Use the name column to pull data from openTree, and get a phylogenetic tree.
3. Match the row names in the matrix to the tips of the tree
4. Reconstruct ancestral states for ecomorph and make a plot.

Comparing the results of these two workflows will give some insight into how well we can do by pulling from openTree.

Added anolis_fullnames.phy to match the names in anolis_fullnames.csv and be useful when query third party services (full scientific names).