#!/usr/bin/env bash

# Helper methods CloudFlare's API
# source suderman.github.io/shelper/cloudflare.sh

# Get record id for record name
cf_id() {

  # Pass name, extract sub and domain
  local name=$1
  local sub=$(tmp=${name%.*} && echo ${tmp%.*})
  local domain=${name##$sub.}
  [[ $domain != *.* ]] && domain=$name && sub=$name

  # Allow cloudflare arg
  local CLOUDFLARE=$CLOUDFLARE
  defined "$2" && CLOUDFLARE=$2

  # Extract record id from JSON (if it exists)
  record=$(
    records=$(curl -s https://www.cloudflare.com/api_json.html \
                -d a=rec_load_all                              \
                -d email=$(key :first $CLOUDFLARE)             \
                -d tkn=$(val :first $CLOUDFLARE)               \
                -d z=$domain)
    if [[ $records == *$name* ]]; then
      records=${records%%$name*}
      records=${records##*\"rec_id\":\"}
      records=${records%%\"*}
      echo $records
    fi
  )

  # Return record id or nothing
  echo $record
}

# Create or update a DNS record
cf_set() {

  # Pass name, extract sub and domain
  local name=$1
  local sub=$(tmp=${name%.*} && echo ${tmp%.*})
  local domain=${name##$sub.}
  [[ $domain != *.* ]] && domain=$name && sub=$name

  # Pass content (ip or domain)
  local content=$2
  undefined "$2" && content=router.${domain}

  # Default type is CNAME, set to A if content is an IP address
  local type=CNAME
  local rx='([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])'
  [[ $content =~ ^$rx\.$rx\.$rx\.$rx$ ]] && type=A

  # Allow cloudflare arg, get record id
  local CLOUDFLARE=$CLOUDFLARE
  defined "$3" && CLOUDFLARE=$3
  local id=$(cf_id $name $CLOUDFLARE)

  # Create new record
  if undefined "$id"; then
    curl https://www.cloudflare.com/api_json.html \
      -d email=$(key :first $CLOUDFLARE)          \
      -d tkn=$(val :first $CLOUDFLARE)            \
      -d a=rec_new                                \
      -d type=$type                               \
      -d z=$domain                                \
      -d ttl=1                                    \
      -d name=$sub                                \
      -d content=$content

  # Update existing record
  else
    curl https://www.cloudflare.com/api_json.html \
      -d email=$(key :first $CLOUDFLARE)          \
      -d tkn=$(val :first $CLOUDFLARE)            \
      -d a=rec_edit                               \
      -d type=$type                               \
      -d z=$domain                                \
      -d ttl=1                                    \
      -d name=$sub                                \
      -d id=$id                                   \
      -d content=$content
  fi
}
