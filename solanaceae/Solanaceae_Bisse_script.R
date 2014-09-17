#point to working directory

setwd("~lib/Desktop/github/traitathon/solanaceae")

require(aRbor)

# read in Solanaceae tree
SolanaceaeTree<-read.tree("Solanaceae.phy")

#check whether tree is ultrametric
is.ultrametric(SolanaceaeTree)

#check whether tree is binary
is.binary.tree(SolanaceaeTree)

#make tree ultrametric
chronopl(SolanaceaeTree, lambda=1) -> SolanaceaeTree

####
read.tree("SolanaceaeUltrametric.phy")->SolanaceaeTree
#visualise tree
plot(SolanaceaeTree, "fan", show.tiplabel=FALSE)

# get the data matrix
SolanaceaeTraits<-read.csv("SolanaceaeTraits.csv")
SolanaceaeTraits[,2]->SolanaceaeTraits
names(SolanaceaeTraits)<-SolanaceaeTree$tip.label

# glue traits and trees together
TD<-make.treedata(SolanaceaeTree, SolanaceaeTraits)
TDstate<-select(TD, State)

###################
#Diversification analysis
###################
library(diversitree)

# MAXIMUM LIKELIHOOD #

#Need a starting point for ML search
p <- starting.point.bisse(TDstate$phy) 

#create a likelihood function to run BiSSE
#incompletely sampled tree, 0.46 and 0.59 of the non-red and red flowered species included in tree, respectively
lik<-make.bisse(TDstate$phy, SolanaceaeTraits, sampling.f=c(0.46,0.59))

#Start an ML search from starting point-full model
fit.bisse <- find.mle(lik, p)



#Model with constraints
#constraining lambda
lik.lambda <- constrain(lik, lambda1 ~ lambda0)
fit.lambda <- find.mle(lik.lambda, p[argnames(lik.lambda)])
#constraining mu
lik.mu <- constrain(lik, mu1~mu0)
fit.mu <- find.mle(lik.mu, p[argnames(lik.mu)])
#constraining q
lik.q <- constrain(lik, q01~q10)
fit.q <- find.mle(lik.q, p[argnames(lik.q)])

#constraining lambda & mu
lik.lambdamu <- constrain(lik, lambda1 ~ lambda0, mu1~mu0)
fit.lambdamu <- find.mle(lik.lambdamu, p[argnames(lik.lambdamu)])
#constraining lambda & q
lik.lambdaq <- constrain(lik, lambda1 ~ lambda0, q01~q10)
fit.lambdaq <- find.mle(lik.lambdaq, p[argnames(lik.lambdaq)])
#constraining mu & q
lik.muq <- constrain(lik, mu1 ~ mu0, q01~q10)
fit.muq <- find.mle(lik.muq, p[argnames(lik.muq)])

#constraining all
lik.lambdamuq <- constrain(lik, lambda1 ~ lambda0, mu1~mu0, q01~q10)
fit.lambdamuq <- find.mle(lik.lambdamuq, p[argnames(lik.lambdamuq)])
