traitathon
==========

Solanaceae - evolution of flower color

Trait data (SolanaceaeTraits.csv): 
0 = non-red flowers; 1 = red flowers

Tree data (Solanaceae.tre): tree with branch lengths (substitutions per site)

Two workflows:

Analysis "Solanaceae A":
- Start with the phylogenetic tree and the trait matrix.
- Match the row names in the matrix to the tips of the tree
- Stochastic mapping for flower color.
- Make a pretty plot.

Analysis "Solanaceae B":
- Start with the phylogenetic tree and the trait matrix.
- Match the row names in the matrix to the tips of the tree.
- Diversification analyses (e.g. BiSSE) for flower color.
- Show estimated speciation, extinction and transition rates.

As a check:
- Only provide trait matrix.
- Use name column to pull data from openTree, and get a phylogenetic tree.
- Match the row names in the trait matrix to the tips of the tree.
- Do either of the above analyses.
