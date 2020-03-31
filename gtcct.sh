#!/usr/bin/env bash

EP=https://ts.glycosmos.org/sparql
LIMIT=500

function query() {
  local offset=${1:-0}
  shift

  local sparql=$(cat <<EOS | sed -e 's/^\s\+//' | tr '\n' ' '
PREFIX glycan: <http://purl.jp/bio/12/glyco/glycan#>
PREFIX glytoucan: <http://www.glytoucan.org/glyco/owl/glytoucan#>
SELECT DISTINCT ?glycoct ?id
FROM <http://rdf.glytoucan.org/core>
FROM <http://rdf.glytoucan.org/sequence/glycoct>
WHERE {
  ?Saccharide glytoucan:has_primary_id ?id .
  ?Saccharide glycan:has_glycosequence ?GlycoSequence .
  ?GlycoSequence glycan:has_sequence ?glycoct.
  ?GlycoSequence glycan:in_carbohydrate_format glycan:carbohydrate_format_glycoct.
}
LIMIT ${LIMIT}
OFFSET ${offset}
EOS
)

  curl -XPOST -H 'Accept: text/tab-separated-values' --data-urlencode "query=${sparql}" ${EP} 2>/dev/null | sed '1d'

  return $?
}

function query_recursive() {
  local offset=${1:-0}
  shift

  result=$(query ${offset})

  local status=$?
  if [ ${status} -ne 0 ]; then
    printf "\ncurl returned exit code %s\n" ${status} >&2
    exit ${status}
  fi

  if [ -n "${result}" ]; then
    printf "\rObtained %s entries..." $((offset + $(echo -e "${result}" | wc -l))) >&2
    echo -e "${result}"
    query_recursive $((offset + LIMIT))
  else
    printf "\n" >&2
  fi
}

query_recursive
