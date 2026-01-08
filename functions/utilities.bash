# Section: [transfer.sh](https://transfer.sh/) #
#----------------------------------------------#

transfer() {
  if [ $# -eq 0 ]; then
    echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"
    return 1
  fi

  tmpfile=$(mktemp -t transferXXX)

  if tty -s; then
    basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g')
    curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >>"$tmpfile"
  else
    curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >>"$tmpfile"
  fi

  cat "$tmpfile"

  rm -f "$tmpfile"
}

#-----------------------------------------------------------#
# Section: [less](http://en.wikipedia.org/wiki/Less_(Unix)) #
#-----------------------------------------------------------#

# Label: Less Interactive
# Description: Inspect file, interactively.
# Parameters: $1 (required) - The file path.
lessi() {
  if [[ "$1" ]]; then
    less +F --LONG-PROMPT --LINE-NUMBERS --RAW-CONTROL-CHARS --QUIET --quit-if-one-screen -i "$1"
  else
    printf "%s\n" "ERROR: File path must be supplied."
    printf "%s\n" "TIP: Use CONTROL+c to switch to VI mode, SHIFT+f to switch back, and CONTROL+c+q to exit."
  fi
}

#---------------------------------------------------------------------#
# Section: [License Finder](https://github.com/pivotal/LicenseFinder) #
#---------------------------------------------------------------------#

# Label: License Finder (include)
# Description: Include license in global list.
# Parameters: $1 (required) - License, $2 (required) - Why.
licensei() {
  local license="$1"
  local why="$2"

  if [[ -z "$license" ]]; then
    printf "%s\n" "ERROR: Must supply license."
    return 1
  fi

  if [[ -z "$why" ]]; then
    printf "%s\n" "ERROR: Explain why the license is safe."
    return 1
  fi

  license_finder whitelist add "$license" --who "$(git config user.name)" --why "$why"
}

# Label: License Finder (add)
# Description: Adds library to global list.
# Parameters: $1 (required) - Library, $2 (required) - Why.
licensea() {
  local library="$1"
  local why="$2"

  if [[ -z "$library" ]]; then
    printf "%s\n" "ERROR: Must supply library."
    return 1
  fi

  if [[ -z "$why" ]]; then
    printf "%s\n" "ERROR: Explain why the license is safe."
    return 1
  fi

  license_finder approval add "$library" --who "$(git config user.name)" --why "$why"
}

#-----------------------------------------#
# Section: [OpenSSL](https://openssl.org) #
#-----------------------------------------#

# Label: SSL Certificate Creation
# Description: Create SSL certificate.
# Parameters: $1 (required) - The domain name.
sslc() {
  local name="$1"

  if [[ -z "$name" ]]; then
    printf "%s\n" "ERROR: Domain name for SSL certificate must be supplied."
    return 1
  fi

  cat >"$name.cnf" <<-EOF
  [req]
  distinguished_name = req_distinguished_name
  x509_extensions = v3_req
  prompt = no
  [req_distinguished_name]
  CN = *."$name"
  [v3_req]
  keyUsage = keyEncipherment, dataEncipherment
  extendedKeyUsage = serverAuth
  subjectAltName = @alt_names
  [alt_names]
  DNS.1 = *."$name"
  DNS.2 = "$name"
EOF

  openssl req \
    -new \
    -newkey rsa:2048 \
    -sha256 \
    -days 3650 \
    -nodes \
    -x509 \
    -keyout "$name.key" \
    -out "$name.crt" \
    -config "$name.cnf"

  rm -f "$name.cnf"
}

#--------------------------------------#
# Section: [curl](http://curl.haxx.se) #
#--------------------------------------#

# Label: Curl Inspect
# Description: Inspect remote file with default editor.
# Parameters: $1 (required) - The URL.
curli() {
  if [[ "$1" ]]; then
    local file=$(mktemp -t suspicious_curl_file) || {
      printf "%s\n" "ERROR: Unable to create temporary file."
      return
    }
    curl --location --fail --silent --show-error "$1" >"$file" || {
      printf "%s\n" "Failed to curl file."
      return
    }
    $EDITOR --wait "$file" || {
      printf "Unable to open temporary curl file.\n"
      return
    }
    rm -f "$file"
  else
    printf "%s\n" "ERROR: URL must be supplied."
    return 1
  fi
}

# Label: Curl Diagnostics
# Description: Curl with diagnostic information for request.
# Parameters: $1 (required) - The URL.
curld() {
  local url="$1"

  printf -v diagnostics "%s\n" "\n" \
    "HTTP Version:   %{http_version}" \
    "HTTP Status:    %{http_code}" \
    "Content Type:   %{content_type}" \
    "DNS Lookup:     %{time_namelookup} seconds" \
    "Connect:        %{time_connect} seconds" \
    "App Connect:    %{time_appconnect} seconds" \
    "Pre-Transfer:   %{time_pretransfer} seconds" \
    "Start Transfer: %{time_starttransfer} seconds" \
    "Speed:          %{speed_upload}↑ %{speed_download}↓ bytes/second" \
    "Total Time:     %{time_total} seconds" \
    "Total Size:     %{size_download} bytes"

  curl --write-out "$diagnostics" --url "$url"
}

#--------------------------------------------------#
# Section: [lsof](http://people.freebsd.org/~abe/) #
#--------------------------------------------------#

# Label: Port
# Description: List file activity on given port.
# Parameters: $1 (required) - The port number.
port() {
  if [[ "$1" ]]; then
    sudo lsof -i :"$1"
  else
    printf "%s\n" "ERROR: Port number must be supplied."
  fi
}

#------------------------------------#
