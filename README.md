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

### 1.2 using gtcsel (https://github.com/glyconavi/pubchem/blob/master/gtcsel)


## 2. GlyTouCan TSV to TEXT for GlycoCTToMolfile

ctconv.php: https://github.com/glyconavi/pubchem/blob/master/PubChemUpload/tsv2txt/ctconv.php


*  input file name: selectedCT.txt

*  output file name: ct.txt

```
Path:
+ ctconv.php
+ selectedCT.txt

$ php ctconv.php

```


#### TSV file of GlyTouCan
```
G35898DT	"RES
1b:a-dgal-HEX-1:5
2s:n-acetyl
3b:b-dgal-HEX-1:5
4b:b-dglc-HEX-1:5
5s:n-acetyl
6b:b-dgal-HEX-1:5
7b:a-lgal-HEX-1:5|6:d
8b:b-dglc-HEX-1:5
9s:n-acetyl
10b:b-dglc-HEX-1:5
11s:n-acetyl
12b:b-dgal-HEX-1:5
13b:a-lgal-HEX-1:5|6:d
LIN
1:1d(2+1)2n
2:1o(3+1)3d
3:3o(3+1)4d
4:4d(2+1)5n
5:4o(4+1)6d
6:6o(2+1)7d
7:3o(6+1)8d
8:8d(2+1)9n
9:1o(6+1)10d
10:10d(2+1)11n
11:10o(4+1)12d
12:12o(2+1)13d"
G64165TJ	"RES
1b:x-dgal-HEX-1:5
2s:n-acetyl
3b:b-dgal-HEX-1:5
4b:b-dglc-HEX-1:5
5s:n-acetyl
....
```


## 3. Convert from GlycoCT to Mol(Molfile/SDfile) using GlycoCTToMolfile

GlycoCTToMolfile: https://bitbucket.org/glycosw/glycocttomolfile/src/master/

#### input format

```
ID:G35898DT
RES
1b:a-dgal-HEX-1:5
2s:n-acetyl
3b:b-dgal-HEX-1:5
4b:b-dglc-HEX-1:5
5s:n-acetyl
6b:b-dgal-HEX-1:5
7b:a-lgal-HEX-1:5|6:d
8b:b-dglc-HEX-1:5
9s:n-acetyl
10b:b-dglc-HEX-1:5
11s:n-acetyl
12b:b-dgal-HEX-1:5
13b:a-lgal-HEX-1:5|6:d
LIN
1:1d(2+1)2n
2:1o(3+1)3d
3:3o(3+1)4d
4:4d(2+1)5n
5:4o(4+1)6d
6:6o(2+1)7d
7:3o(6+1)8d
8:8d(2+1)9n
9:1o(6+1)10d
10:10d(2+1)11n
11:10o(4+1)12d
12:12o(2+1)13d

ID:G64165TJ
RES
1b:x-dgal-HEX-1:5
2s:n-acetyl
3b:b-dgal-HEX-1:5
4b:b-dglc-HEX-1:5
5s:n-acetyl
6b:a-lgal-HEX-1:5|6:d
7b:b-dgal-HEX-1:5
8b:a-lgal-HEX-1:5|6:d
9b:b-dglc-HEX-1:5
10s:n-acetyl
11b:b-dgal-HEX-1:5
LIN
1:1d(2+1)2n
2:1o(3+1)3d
3:3o(3+1)4d
4:4d(2+1)5n
5:4o(3+1)6d
6:4o(4+1)7d
7:7o(2+1)8d
8:3o(6+1)9d
9:9d(2+1)10n
10:9o(4+1)11d

ID:G32188JT
RES
1b:x-dgal-HEX-1:5
....
```

