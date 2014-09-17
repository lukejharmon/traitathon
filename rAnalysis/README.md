R Data Analysis
==========

This folder is for the actual workflow for grabbing trees and traits and generating desired output, without using the online interactive aRbor environment.

Important tasks include:
-Importing trait data from the user's computer or from online databases (using a list of species names) into the R environment
-Importing trees from the user's computer or from OpenTree (using a list of species names) into the R environment (RImportTree.R)
-Taking a trait matrix and extracting species names (to be used in getting a tree from OpenTree) (extractSpeciesNames.R)
-Taking a tree and extracting species names (to be used in extracting a trait matrix from an online database) (extractSpeciesNames.R)
-Using trees and trait data to carry out a variety of tasks, like calculating phylogenetic signal, or doing PIC, etc. (phyloSignalARbor.R, etc.)

Some of this code can be cannibalized from aRbor or other packages.