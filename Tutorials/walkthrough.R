#' Visualizing character data on trees <br />

library(ape)
library(diversitree)
source('/Users/alex/GitHub/traitathon/treeOfSex/plot_trait_dendrogram.R')
source('/Users/alex/GitHub/traitathon/treeOfSex/get_tos_database.R')

#' <br />
#'
#'
#' Example 1: Plotting binary flower color character states onto Solanaceae data <br />
#' <br />
#' Here we already have a tree and a character matrix <br />

#' First, read in the tree with ape() and the character matrix, too.
sol_tree <- read.tree("/Users/alex/GitHub/traitathon/solanaceae/Solanaceae.tre")
sol_char <- read.csv("/Users/alex/GitHub/traitathon/solanaceae/SolanaceaeTraits.csv", row.names=1)

#' Then make sure the character matrix rows are in the same order as the tree tips. This is essential, otherwise they won't match up on the tree.
sol_char <- sol_char[sol_tree$tip.label, ]

#' We only have one binary character that we want to map onto the tree, so we can plot that single column.
plot_trait_dendrogram(sol_tree, sol_char, legend=TRUE, binary=TRUE, tree_type="fan", tiplabel_cex=0.2)


#' Example 2: Visualizing discrete traits from Anolis <br />
#' <br />
#' Again, here we have a user-provided tree and character matrix
anolis_tree <- read.tree("/Users/alex/GitHub/traitathon/anolis/anolis.phy") 
anolis_char <- read.csv("/Users/alex/GitHub/traitathon/anolis/anolis.csv", row.names=1)

#' Make sure the character matrix rows are in the same order as the tree tips
anolis_char <- anolis_char[anolis_tree$tip.label, ]

#' Pick out the character trait to plot on the tree. Here I extract what islands each species is native to.
anolis_char <- anolis_char$island

plot_trait_dendrogram(anolis_tree, anolis_char, legend=TRUE, binary=FALSE, tree_type="fan", tiplabel_cex=0.5)

#' Maybe this would look better as a regular phylogram...
plot_trait_dendrogram(anolis_tree, anolis_char, legend=TRUE, binary=FALSE, tree_type="phylogram", tiplabel_cex=0.25)


#' Example 3: Visualizing discrete and continuous floral traits on a Heliconia tree <br />
#' <br />

helic_tree <- read.tree("/Users/alex/GitHub/traitathon/heliconia/heliconia.phy")
helic_char <- read.csv("/Users/alex/GitHub/traitathon/heliconia/heliconia1.csv", row.names=1)

#' Again, let's make sure the rownames of the character matrix match up with the tree tips
helic_char <- helic_char[helic_tree$tip.label, ]

#' Let's pick out a character trait to plot, like flower arrangement, or perianth color
helic_arrangement <- helic_char$arrangment
helic_color <- helic_char$perColor
#' Now plot it
plot_trait_dendrogram(helic_tree, helic_arrangement, legend=TRUE, binary=FALSE, tree_type="phylogram", tiplabel_cex=0.4, legend_loc="bottomleft")


#' Example 4: Attach other sources of data to a tree (Tree of Sex) <br />
#' <br />
#' Let's say we have a tree, but want to extract some other types of character data. For instance, I'd like to use the [Tree of Sex](http://www.treeofsex.org) database to see if there's any hermaphroditism in my group. <br />
#' Using the heliconia tree from the previous example, let's map some other characteristics onto it. <br />
#' 
#' First let's extract some data from the Tree of Sex <br />
#' # rename
plant_sex <- get_tos_database("plant")

#' What traits are in this database?
colnames(plant_sex)

#' Let's reformat this data a little bit. We want the rownames to be "Genus species". 
new_rownames <- paste(plant_sex$genus,plant_sex$species, sep=" ")
rownames(plant_sex) <- make.names(new_rownames, unique=TRUE)
rownames(plant_sex) <- as.character(sub("\\."," ", rownames(plant_sex)))
head(rownames(plant_sex))
#' Now we can extract some information...like sexual systems in the solanaceae example <br />
#' The tree tip labels in the solanacea have underscores in them, let's change that real quick to match our Tree of Sex data <br />

head(sol_tree$tip.label)
sol_tree$tip.label <- sub("_"," ",sol_tree$tip.label)
head(sol_tree$tip.label)

#' Now extract the Tree of Sex "sexual system" data for leaves in our tree. If there's no entry for a tip species in the Tree of Sex database, title it "unknown" <br />
tipchars <- ifelse(sol_tree$tip.label %in% rownames(plant_sex),plant_sex$sexual_system,NA)
sex_levels <- levels(plant_sex$sexual_system)
solanacea_sex <- sex_levels[tipchars]
solanacea_sex[is.na(solanacea_sex)] <- "unknown" 
solanacea_sex <- as.factor(solanacea_sex)

#' let's see if it worked...!
plot_trait_dendrogram(sol_tree, solanacea_sex, tree_type="fan", tiplabel_cex=0.15, legend=TRUE, legend_loc="bottomleft", legend_cex=0.6)

#' whoops. There are two conditions colored black; we need more colors in our color palette.
palette(c("blue","red", "yellow","orange","purple","black","green","lightblue","grey"))
plot_trait_dendrogram(sol_tree, solanacea_sex, tree_type="fan", tiplabel_cex=0.15, legend=TRUE, legend_loc="bottomleft", legend_cex=0.6)

