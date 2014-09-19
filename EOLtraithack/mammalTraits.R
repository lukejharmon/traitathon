##  --------------------------------- ##
##                                    ##
##            Example 1:              ##
##     Download mammal trait data     ##
##         written by B.Banbury       ##
##             18 Sept 14             ##
##                                    ##
##  --------------------------------- ##



##  Download/load packages  ##

#devtools::install_github("arborworkflows/aRbor")  #not building
setwd("~/aRbor/trunk/R")
system("svn update")
sourcefiles <- system("ls ", intern=TRUE)
for(i in sequence(length(sourcefiles))){
  print(i)
  source(sourcefiles[i])
}
#devtools::install_github("fmichonneau/rotl")  #not building
setwd("~/rotl/trunk/R")
system("svn update")
sourcefiles <- system("ls ", intern=TRUE)
for(i in sequence(length(sourcefiles))){
  print(i)
  source(sourcefiles[i])
}
source("~/traitathon/trunk/EOLtraithack/traitbankSource.R")
library(phytools)


##  Get OpenTree phylogeny  ##

#using the mammal example on the rotl github
furry_studies <- studies_find_studies(property="ot:focalCladeOTTTaxonName", value="Mammalia")
( furry_ids <- unlist(furry_studies$matched_studies) )
furry_metadata <-get_study_meta(2647)
furry_metadata$nexml$treesById
tr_string <- get_study_tree(study="2647", tree="tree6169",format="newick")
tr_string <- gsub(" ", "_", tr_string)
tr_string <- gsub("'", "", tr_string)
tr <- read.tree(text=tr_string)


##  Get EOL TraitBank Data  ##

#Find EOL ID values that match tips on the tree and then download the files to your working directory. You can also choose not to save the individual files, by changing to.file=FALSE, but beware that large numbers of taxa will chew up your computers RAM. 
EOLids <- MatchTaxatoEOLID(tr$tip.label)
OTLmamms <- DownloadEOLtraits(EOLids[,3], to.file=TRUE)
files <- RemoveNAFiles(list.files(pattern="eol"))  #some EOLIDs lead to missing trait info

#You can see which traits are available
availableTraits <- WhichTraits(files)

#Then you can compile data from each of the files for whichever trait is available.  We chose to examine body mass. Then the trait will need a little finagling. 
mass <- GetData("body mass", files, chatty=TRUE)
mass <- mass[which(mass[,5] == "adult"),]  #only want adult animals
mass[,1] <- sapply(mass[,1], FirstTwo) #species names have authors attached
mass[,1] <- gsub(" ", "_", mass[,1])  
mass[which(mass[,4] == "kg"),][,3] <- as.numeric(mass[which(mass[,4] == "kg"),][,3])*1000 #convert kg to g
mass[,3] <- log((as.numeric(mass[,3]))) #log transform
mass[which(mass[,4] == "kg"),][,4] <- rep("g", length(mass[which(mass[,4] == "kg"),][,4]))
mass[,4] <- paste("log.", mass[,4], sep="") 

#We will make a single named vector of mass, so that we can plot it using phytools. 
trait <- mass[,3]
names(trait) <- mass[,1]
trait <- trait[-which(duplicated(names(trait)))]  #ooops duplicate entries for some species! Meaning that some of these mammals have more than one adult measured.  THis could be great for your study! But here, we will ignore the duplicates. 
trait <- trait[-which(names(trait) %in% name.check(newtree, trait)$data_not_tree)]  #and get rid of taxa that aren't in the tree! How does this happen!?  

#Then drop taxa from the tree that do not have data and plot!! 
newtree <- drop.tip(tr, name.check(tr, trait)$tree_not_data)
newtree$edge.length <- rep(1, dim(newtree$edge)[1])  #these trees have no branch length info!  
contMap(newtree, trait, fsize=c(1, 1), lwd=2)





##  --------------------------------- ##
##                                    ##
##            Example 2:              ##
##     Download mammal trait data     ##
##         written by B.Banbury       ##
##             18 Sept 14             ##
##                                    ##
##  --------------------------------- ##


#this is really bad hacking (sorry), but it is just to get us going for proof of concept.
web <- "http://lib.colostate.edu/wildlife/atoz.php?letter=ALL"
weblines <- readLines(web)
weblines <- weblines[grep("Genus", weblines)][-c(1,2)]
speciesList <- NULL
for(i in sequence(length(weblines))){
  species <- strsplit(weblines[i], ">")[[1]][3]
  species <- strsplit(species, "<")[[1]][1]
  speciesList <- c(speciesList, species)
}

mammalEOLIDs <- MatchTaxatoEOLID(speciesList)[,3]
allmammals <- DownloadEOLtraits(mammalEOLIDs, to.file=TRUE)  
files <- RemoveNAFiles(list.files(pattern="eol"))  #some eolids lead to missing info
availableTraits <- WhichTraits(files)
bodymass <- GetData("body mass", files, chatty=TRUE)
adultbodymass <- bodymass[which(bodymass[,5] == "adult"),]
species <- sapply(adultbodymass[,1], FirstTwo)

#Now to get the tree using rotl
matchnames <- tnrs_match_names(species)
ottIDs <- matchnames[,4]

#Get Tree
OTmammTree <- tol_induced_subtree(ott_ids=ottIDs)  #takes a long time, never finishes :(
#mammTree <- compute.brlen(OTmammTree)
#mammTree <- multi2di(mammTree)
#plot(mammTree)
randomTree <- ladderize(rcoal(dim(adultbodymass)[1]))  #for pretend
randomTree$tip.label <- adultbodymass[,1]

#need to convert kg to g in adult bodymass
adultbodymass[which(adultbodymass[,4] == "kg"),][,3] <- as.numeric(adultbodymass[which(adultbodymass[,4] == "kg"),][,3])*1000
adultbodymass[which(adultbodymass[,4] == "kg"),][,4] <- rep("g", length(adultbodymass[which(adultbodymass[,4] == "kg"),][,4]))
adultbodymass[,1] <- sapply(adultbodymass[,1], FirstTwo)

trait <- as.numeric(adultbodymass[,3])
trait <- log(trait)
names(trait) <- adultbodymass[,1]
contMap(randomTree, trait, fsize=c(.1, 1), lwd=2)



















