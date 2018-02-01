#!/bin/bash
#
# example of how to use nomer to map grin descriptors into the trait ontology
#

# first clean term cache to remove any old trait maps
java -jar nomer.jar clean

# first stream grin scrape through nomer and append matched terms 
# when no match is found, an explicit "NONE" is appended along 
# with the matched term

# please note that records without a GRINTaxon are dropped
# see https://github.com/jhpoelen/samara/issues/49

zcat input/grin.tsv.gz | grep "^GRINTaxon" | java -Dnomer.term.map.url=file://${PWD}/input/grin-trait-map.tsv -Dnomer.term.cache.url=file://${PWD}/input/traits.tsv -jar nomer.jar append --properties=nomer.properties | gzip > output/grin-mapped.tsv.gz 
