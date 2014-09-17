#Traitbank source hack 

library(Reol)
library(rjson)
library(RCurl)

DownloadEOLtraits <- function (pages, to.file = TRUE, MyKey = NULL, verbose = TRUE, cache=2419200, ...) {
#this will download EOL trait data json either to file or to R console (user)
  if (Sys.getlocale("LC_ALL") == "C") 
    warning("Sys.getlocale is set to C. In order to read UTF characters, you need to set the locale aspect to UTF-8 using Sys.setlocale")
  EOLpages <- vector("list", length = length(pages))
  for (i in sequence(length(pages))) {
    pageNum <- pages[i]
    #http://eol.org/api/traits/328598?cache_ttl=2419200 #cache_ttl is the amount of seconds you are willing to wait
    web <- paste("http://eol.org/api/traits/", pageNum, "?cache_ttl=", cache, sep = "")
    if (!is.null(MyKey)) 
      web <- paste(web, "&amp;key=", MyKey, sep = "")
    if (to.file) {
      write(getURL(web, ...), file = paste("eol", pages[i], ".xml", sep = ""))
      if (verbose) 
        print(paste("Downloaded ", "eol", pages[i], ".xml", sep = ""))
    }
    else {
      EOLpages[[i]] <- getURL(web, ...)
      names(EOLpages)[[i]] <- paste("eol", pages[i], sep = "")
      if (verbose) 
        print(paste("eol", pages[i], " saved as R object", sep = ""))
    }
    Sys.sleep(1)
  }
  if (to.file) 
    return(paste("eol", pages, ".xml", sep = ""))
  else return(EOLpages)
}
#whaledata <- DownloadEOLtraits(328574, to.file=FALSE)  

#whaleJSON <- rjson::fromJSON(file="eol328574.xml")  #files work
#whaleJSON <- rjson::fromJSON(json_str=unlist(whaledata))  #works


ReadJSON <- function(rawJSON){
#this will parse and unlist a json file from EOL (internal)
  if(regexpr("^eol[0-9]+.xml$", rawJSON) > 0)  #it is a file
    return(unlist(rjson::fromJSON(file=unlist(rawJSON))$`@graph`))
  return(unlist(rjson::fromJSON(json_str=unlist(rawJSON))$`@graph`))
}
#ReadJSON(whaledata)


WhichTraits <- function(JSON){
#find which trait values are available for this JSON (user)
  whichTraits <- NULL
  for(i in sequence(length(JSON))){
    j <- ReadJSON(JSON[[i]])
    tt <- paste(j[which(names(j) == "dwc:measurementType.rdfs:label.en")])
    whichTraits <- c(whichTraits, tt)
  }
  return(unique(whichTraits))
}
#WhichTraits(whaledata)
#WhichTraits(allwhales)


GetLocationInJSON <- function(traitOfInterest, JSON){
#this will find where in the json your trait is (internal)
  if(any(traitOfInterest == WhichTraits(JSON))){
    j <- ReadJSON(JSON)
    placesOfInterest <- grep(traitOfInterest, j)
    return(placesOfInterest)
  }
  return("NO matches")
}
#GetLocationInJSON("body mass", whaledata)


GetTaxonName <- function(JSON){
#this function will retrieve a taxon name from the JSON (internal)
  j <- ReadJSON(JSON)
  return((j[[grep("scientificName", names(j))]]))
}
#GetTaxonName(whaledata)


GetDataforOne <- function(traitOfInterest, JSON){
#this will return a data frame with hacky trait info (internal)
#it will only work if the data is in the same order...we can/should fix this later 
  if(length(GetLocationInJSON(traitOfInterest, JSON)) > 0){
    locs <- GetLocationInJSON(traitOfInterest, JSON)
    datamat <- matrix(nrow=length(locs), ncol=5)  #ncols hard coded...no likey
    tax <- GetTaxonName(JSON)
    j <- ReadJSON(JSON)
    for(i in sequence(length(locs))){
      datamat[i,] <- c(tax, j[locs[i]], j[locs[i]+2], j[locs[i]+3], j[locs[i]+5])
    }
  }
  return(as.data.frame(datamat, stringsAsFactors=FALSE))
}
#GetDataforOne("body mass", whaledata)
#GetDataforOne("total life span", whaledata)

GetData <- function(traitOfInterest, JSON){
#this function rbinds all the species pages together (user)
  tot <- NULL
  for(i in sequence(length(JSON))){
    inddata <- GetDataforOne(traitOfInterest, JSON[[i]])
    tot <- rbind(tot, inddata)
  }
  return(tot)
}
#GetData("body mass", whaledata)



































