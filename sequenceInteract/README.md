Test Case for Hackathon: OTL phylogeny from short read archives (SRA)

This test case is to figure out a quick way to take a short read archive dataset (SRA) and retrieve the "true" phylogeny for those organisms from OTL.

The problem: many surveys of biodiversity use "barcodes" or short sequences of DNA to assess diversity. Researchers would like to use these sequences to estimate phylogenetic diversity within and among habitats, but these short sequences are usually not suitable for reconstructing the "true" phylogeny.

Currently, researchers must BLAST short sequences against GenBank, retrieve full sequences from GenBank, then build a phylogeny, then somehow place the short sequences into the phylogeny derived from full sequences, then prune the tree to only contain the organisms of interest.

This method can be implemented right now using PPLACER: http://matsen.fhcrc.org/pplacer/ or using MAFFT+RAxML to place the sequences, then using R drop.tips to prune the tree.

Would it be better to match SRA sequences to names in GenBank, then retrieve the OTL phylogeny?

Here is a link to a google drive folder with supporting documents:
https://drive.google.com/folderview?id=0BwYrMB7I9dMkdFdDY0FFamZlbW8&usp…

References:
MarineInvertebrateDietBarcodingExample Blankenship Yayanos 2005.pdf
This publication provides an example of why someone might want to take this sort of approach.

MER 2014....Zhan et al 2014.pdf
This publication reviews various methods for using a next-generation sequencing approach to assess biodiversity. From this paper, I extracted
eukaryote_18S_AppendixS2_Zhan_etal_2014.fasta which contains 77 full 18S sequences of eukaryotes
eukaryote_18S_full_RAxML_Tree.newick contains the "true" phylogeny for this group
I used the primers developed by Zhan et al. to extract what their short read archive (SRA) would be for these 77 sequences.
eukaryote_18S_SRA.fasta contains the un-aligned SRA.
eukaryote_18S_SRA_RAxML_Tree.newick contains the phylogeny as estimated from the SRA and you will see many differences vs. the "true" phylogeny

FreshwaterBacteria....Zwart et al 2002.pdf
This publication uses a similar approach to examine plankton in freshwater lakes.
I assembled a set of 20 sequences from 2 lakes (CL: Crater Lake, OR; LF: Lake Fryxell, Antarctica), and make a full sequence alignment plus phylogeny; and an SRA-based phylogeny. In this case, you will see very few differences between the two phylogenies, primarily branch lengths. But, I included it because there are no organism names here, just OTU numbers or GenBank Accession numbers. If you would like a larger dataset of bacterial OTUs, let me know and I can send you 100,000 from EMP.
