Heliconia
 ==========
 
Analysis of Heliconia morphological and biogeographic traits
The data includes a phylogenetic tree with branch lengths (time in millions of years; heliconia.nested-json) and several character matrices (heliconia_morphology.csv and heliconia_biogeo.csv).

The goal of the analysis is to construct several workflows:

Analysis "Heliconia A"

1. Start with character matrix heliconia_morphology.csv. Extract columns: 
2. Average continuous characters by species --> output table is heliconia1.csv
3. Next use heliconia_biogeo.csv. 
4. use phyTools in R to generate phylogenetic PCA for biogeographic data 
5. Merge tables by species
6. Look up taxa in open tree
7. [if source heliconia tree was in openTree, it would be extracted here] to do: work w/ openTree to see how uploading and downloading tree would work

Analysis "Heliconia B"

1. Start with phylogenetic tree heliconia.nested-json
2. match tips to characters
3. correlation of elevation and leaf lenghth or leaf width (independent contrasts)
4. correlation of elavation and vegHabit (independent contrasts)
5. phylogenetic signal of all traits individually

These analyses will test the use of potential source trees with branch lenghts from OpenTree in Arbor to be used in comparative methods

Files HeliconiaSelectEditFullname.phy and heliconiaFullname.csv have been edited to use full scientific name to facilitate searching in other taxonomic services.
