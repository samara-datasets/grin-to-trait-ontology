#!/bin/bash
#
# example of how to use nomer to map using a small subset of grin scrape

# first, clean the cached nomer term maps
java -jar nomer.jar clean

# then, pipe a small version of grin through nomer to produce a 
# mapped file. Note that a term descriptor was changed to match at 
# least a single term to show that matching actually occurs

cat input/grin_small.tsv | java -Dnomer.term.map.url=file://${PWD}/input/grin-trait-map.tsv -Dnomer.term.cache.url=file://${PWD}/input/traits.tsv -jar nomer.jar append --properties=nomer.properties | tee output/grin_small_mapped.tsv 
