# grin-to-trait-ontology
an example how to map grin scrape into trait ontology using nomer

# prerequisites 

1. some linux / commandline 
2. internet connection for running "big" mapping
3. java sdk 8+ (test by opening commandline and running ```java -version```)

# usage

## test run

First try a test run by executing ```bash map-small.sh```. This should provided an output like:

```
$ ./map-test.sh 
Nomer [version: 0.0.5]
cleaning cache at [./.nomer]...
cleaning cache at [./.nomer] done.
Nomer [version: 0.0.5]
using matcher [org.eol.globi.taxon.TaxonCacheService]
taxon cache initializing at [/home/jorrit/proj/planteome/grin-to-trait-ontology/./.nomer/term-cache...
no pre-existing cache found, rebuilding...
taxon cache loading [file:///home/jorrit/proj/planteome/grin-to-trait-ontology/input/traits.tsv]...
taxon cache loading [file:///home/jorrit/proj/planteome/grin-to-trait-ontology/input/traits.tsv] done.
cache with [78] items built in [0.0] s or [1814.0] items/s.
taxon lookup service instantiating...
no pre-existing taxon lookup index found, re-indexing...
taxon map loading [file:///home/jorrit/proj/planteome/grin-to-trait-ontology/input/grin-trait-map.tsv] ...
cache with [203] items built in [0.0] s or [4833.3] items/s.
taxon map loading [file:///home/jorrit/proj/planteome/grin-to-trait-ontology/input/grin-trait-map.tsv] done.
taxon lookup service instantiating done.
taxon cache at [/home/jorrit/proj/planteome/grin-to-trait-ontology/./.nomer/term-cache initialized.
verbatim_taxon_id   verbatim_taxon_name resolved_taxon_id   descriptor_id   descriptor_name descriptor_definition   method_id   method_name observed_value  accession_id    accession_number    accession_name  collected_from  citations   NONE    descriptor_id   descriptor_name         
GRINTaxon:300359    Medicago sativa L. subsp. sativa    NCBITaxon:3879  GRINDesc:89309  [testing] By pass protein   In-vitro dry matter disappearance (ivdmd) expressed as a percent of the cultivar venal.  Higher than 100% suggests low digestibility & higher by-pass protein.  GRINMethod:391002   ALFALFA.PROTBYPASS.93.VOLENEC   140 GRINAccess:1140225  PI 162787   'PAMPA'Argentina    D.Z. Skinner. 1999. Non random chloroplast DNA hypervariability in Medicago sativa. Theor Appl Genet Theoretical and applied genetics; international journal of b.|D.H. Basigalup, D.K. Barnes, and R.E. Stucker. 1995. Development of a Core Collection for Perennial Medicago Plant Introductions. Crop Sci 35:1163-1168. SAME_AS TO:0000658  days to slik            days to slik                            
GRINTaxon:300359    Medicago sativa L. subsp. sativa    NCBITaxon:3879  GRINDesc:68102  Crude protein in the leaf   Crude protein in the leaf.  GRINMethod:490600   ALFALFA.1989.BARNES 29.4    GRINAccess:1140225  PI 162787   'PAMPA' Argentina   D.Z. Skinner. 1999. Non random chloroplast DNA hypervariability in Medicago sativa. Theor Appl Genet Theoretical and applied genetics; international journal of b.|D.H. Basigalup, D.K. Barnes, and R.E. Stucker. 1995. Development of a Core Collection for Perennial Medicago Plant Introductions. Crop Sci 35:1163-1168. NONE    GRINDesc:68102  Crude protein in the leaf           
```

The file ```output/grin-small-mapped.tsv``` should have been regenerated.

## big run 

After making sure the test works, you can try to run the mapping of all GRIN descriptors using bbop's copy at https://build.berkeleybop.org/view/Planteome/job/extract-grin-traits/ .

Start the mapping by executing ```./map-grin.sh```. The input (downloaded/streamed from bbop) is saved in ```input/grin.tsv.gz``` and the mapped output is in ```output/grin-mapped.tsv.gz``` .

You can have a look at the first 10 lines of the result by doing something like ```zcat output/grin-mapped.tsv.gz | head -n 11```.

Now, to identify mapped terms, something ```zcat output/grin-mapped.tsv.gz | grep SAME_AS``` will select all lines with matched GRINDesc terms. To get a list of all unique unmatched terms, awk may be used in combination with sort and uniq like: ```zcat output/grin-mapped.tsv.gz | grep -P '\tNONE\t' | awk -F '\t' '{print $4 "\t" $5 }' | sort | uniq > output/grin-unmatched-desc.tsv```
