##  --------------------------------- ##
##                                    ##
##        Proof of Concept 1:         ##
##   Download all mammal trait data   ##
##         written by B.Banbury       ##
##             18 Sept 14             ##
##                                    ##
##  --------------------------------- ##



# Download/load packages
#devtools::install_github("arborworkflows/aRbor")  #not building
setwd("~/aRbor/trunk/R")
system("svn update")
sourcefiles <- system("ls ", intern=TRUE)
for(i in sequence(length(sourcefiles))){
  print(i)
  source(sourcefiles[i])
}
require(Reol)
#devtools::install_github("fmichonneau/rotl")  #not building
setwd("~/rotl/trunk/R")
system("svn update")
sourcefiles <- system("ls ", intern=TRUE)
for(i in sequence(length(sourcefiles))){
  print(i)
  source(sourcefiles[i])
}



#this is really bad hacking (sorry), but it is just to get us going for proof of concept.  Maybe we can replace this with the rotl node search when that gets working and then pass eol a vector fo names from a tree.  
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

setwd("~/mammalEOLs")

source("~/traitathon/trunk/EOLtraithack/traitbankhack.R")

allmammals <- DownloadEOLtraits(mammalEOLIDs, to.file=TRUE)  

files <- RemoveNAFiles(list.files(pattern="eol"))  #some eolids lead to missing info

availableTraits <- WhichTraits(files)

bodymass <- GetData("body mass", files, chatty=TRUE)
adultbodymass <- bodymass[which(bodymass[,5] == "adult"),]

species <- sapply(adultbodymass[,1], FirstTwo)

#save(adultbodymass, file="~/traitathon/trunk/adultbodymass.Rdata")
write.table(adultbodymass, file="adultbodymass.txt")


#Now to get the tree using rotl

#TNRS
matchnames <- tnrs_match_names(species)
ottIDs <- matchnames[,4]

#Get Tree
OTmammTree <- tol_induced_subtree(ott_ids=ottIDs)  #takes a long time
tol_induced_subtree <- function(node_ids=NULL, ott_ids=NULL) {
    if (is.null(node_ids) && is.null(ott_ids)) {
    	stop("Must supply \'node_ids\' and/or \'ott_ids\'")
    }
    if ((!is.null(node_ids) && any(is.na(node_ids))) ||
        (!is.null(node_ids) && any(is.na(ott_ids)))) {
        stop("NA are not allowed")
    }
    if (is.null(node_ids) && !is.null(ott_ids)) q <- list(ott_ids  = ott_ids)
    if (!is.null(node_ids) && is.null(ott_ids)) q <- list(node_ids = node_ids)
    if (!is.null(node_ids) && !is.null(ott_ids)) q <- list(ott_ids = ott_ids,
                                                           node_ids = node_ids)
    res <- otl_POST("tree_of_life/induced_subtree", body=q)
    cont <- httr::content(res)

    #phy <- collapse.singles(read.tree(text=(cont)[["subtree"]])); # required b/c of "knuckles"
    #phytoot <- phytools::read.newick(text=(cont)[["subtree"]])
  #phy <- ape::collapse.singles(phytoot); # required b/c of "knuckles"

    #return(phy)
}


#mammTree <- compute.brlen(OTmammTree)
#mammTree <- multi2di(mammTree)

#plot(mammTree)


#need to convert kg to g in adult bodymass

adultbodymass[which(adultbodymass[,4] == "kg"),][,3] <- as.numeric(adultbodymass[which(adultbodymass[,4] == "kg"),][,3])*1000
adultbodymass[which(adultbodymass[,4] == "kg"),][,4] <- rep("g", length(adultbodymass[which(adultbodymass[,4] == "kg"),][,4]))
adultbodymass[,1] <- sapply(adultbodymass[,1], FirstTwo)

randomTree <- ladderize(rcoal(dim(adultbodymass)[1]))
randomTree$tip.label <- adultbodymass[,1]

library(phytools)
trait <- as.numeric(adultbodymass[,3])
trait <- log(trait)
names(trait) <- adultbodymass[,1]
contMap(randomTree, trait, fsize=c(.1, 1), lwd=2)





##  --------------------------------- ##
##                                    ##
##        Proof of Concept 2:         ##
##   Download all mammal trait data   ##
##         written by B.Banbury       ##
##             18 Sept 14             ##
##                                    ##
##  --------------------------------- ##


#using the mammal example on the rotl github

furry_studies <- studies_find_studies(property="ot:focalCladeOTTTaxonName", value="Mammalia")
( furry_ids <- unlist(furry_studies$matched_studies) )
furry_metadata <- httr::content(get_study_meta(2647))
library(ape)
tr <- read.tree(text=httr::content(tr_string))
plot(tr)


( some_birds <- tol_induced_subtree(ott_ids=c(292466, 501678, 267845, 666104)))
( tr <- read.tree(text=httr::content(some_birds)$subtree) )

#none of these examples seem to be working for me.  :( 

























