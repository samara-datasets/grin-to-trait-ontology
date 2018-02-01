#!/bin/bash
#
# example of how to use nomer to map grin descriptors into the trait ontology
#

# first clean term cache to remove any old trait maps
java -jar nomer.jar clean

# first stream grin scrape through nomer and append matched terms 
# when no match is found, an explicit "NONE" is appended along 
# with the matched term

# note that the gzip business is an attempt to reduce data file to a size
# that is still accepted by git/ github for archiving purposes
# probably not a good idea to store big files in github ... but nice
# to have things in one place

curl https://build.berkeleybop.org/view/Planteome/job/extract-grin-traits/lastSuccessfulBuild/artifact/grin.tsv | gzip | tee input/grin.tsv.gz | gunzip | java -Dnomer.term.map.url=file://${PWD}/input/grin-trait-map.tsv -Dnomer.term.cache.url=file://${PWD}/input/traits.tsv -jar nomer.jar append --properties=nomer.properties | gzip | tee output/grin_mapped.tsv 
