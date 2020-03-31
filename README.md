# PubChem Upload (https://pubchem.ncbi.nlm.nih.gov/upload/)

## 1. Get GlycoCT Data (1.1 or 1.2)

### 1.1 using SPARQL Query from GlyTouCan SPARQL endpoint.

SPARQL endpoint https://ts.glytoucan.org/sparql

```
PREFIX glycan: <http://purl.jp/bio/12/glyco/glycan#>
PREFIX glytoucan: <http://www.glytoucan.org/glyco/owl/glytoucan#>
SELECT  str (?glycoct) str (?id)
FROM <http://rdf.glytoucan.org/core>
FROM <http://rdf.glytoucan.org/sequence/glycoct>
WHERE {
  ?Saccharide glytoucan:has_primary_id ?id .
  ?Saccharide glycan:has_glycosequence ?GlycoSequence .
  ?GlycoSequence glycan:has_sequence ?glycoct.
  ?GlycoSequence glycan:in_carbohydrate_format glycan:carbohydrate_format_glycoct.
  
  MINUS {
    ?GlycoSequence glycan:has_sequence ?glycoct.
   FILTER( contains(str(?glycoct),"r:r") )
  }
  
  MINUS {
    ?GlycoSequence glycan:has_sequence ?glycoct.
   FILTER( contains(str(?glycoct),"UND") )
  }
  
  MINUS {
    ?GlycoSequence glycan:has_sequence ?glycoct.
   FILTER( contains(str(?glycoct),"(-1") )
  }
  
}
```

### 1.2 using gtcct.sh (https://github.com/glyconavi/pubchem/blob/master/gtcct.sh)

## 2. Convert from GlycoCT to Mol(Molfile/SDfile) using GlycoCTToMolfile

GlycoCTToMolfile: https://bitbucket.org/glycosw/glycocttomolfile/src/master/

```

```

