
# Human readable file size
# (because `du -h` doesn't cut it for me).
hrfs() {
  printf "%s" "$1" |
    awk '{
            i = 1;
            split("B KB MB GB TB PB EB ZB YB WTFB", v);
            value = $1;

            # confirm that the input is a number
            if ( value + .0 == value ) {

                while ( value >= 1024 ) {
                    value/=1024;
                    i++;
                }

                if ( value == int(value) ) {
                    printf "%d %s", value, v[i]
                } else {
                    printf "%.1f %s", value, v[i]
                }

            }
        }' |
    sed -e ":l" \
      -e "s/\([0-9]\)\([0-9]\{3\}\)/\1,\2/; t l"
  #    └─ add thousands separator
  #       (changes "1023.2 KB" to "1,023.2 KB")
}

# Get gzip information (gzipped file size + reduction size).
gz() {
  declare -i GZIPPED_SIZE=0
  declare -i ORIGINAL_SIZE=0

  if [ -f "$1" ]; then
    if [ -s "$1" ]; then

      ORIGINAL_SIZE=$(wc -c <"$1")
      printf "\n original size:   %12s\n" "$(hrfs "$ORIGINAL_SIZE")"

      GZIPPED_SIZE=$(gzip -c "$1" | wc -c)
      printf " gzipped size:    %12s\n" "$(hrfs "$GZIPPED_SIZE")"

      printf " ─────────────────────────────\n"
      printf " reduction:       %12s [%s%%]\n\n" \
        "$(hrfs $((ORIGINAL_SIZE - GZIPPED_SIZE)))" \
        "$(printf "%s" "$ORIGINAL_SIZE $GZIPPED_SIZE" |
          awk '{ printf "%.1f", 100 - $2 * 100 / $1 }' |
          sed -e "s/0*$//;s/\.$//")"
      #              └─ remove tailing zeros

    else
      printf "\"%s\" is empty.\n" "$1"
    fi
  else
    printf "\"%s\" is not a file.\n" "$1"
  fi
}

# extract any type of compressed file
function extract {
  echo Extracting "$1" ...
  if [ -f "$1" ]; then
    case "$1" in
    *.tar.bz2) tar xjf "$1" ;;
    *.tar.gz) tar xzf "$1" ;;
    *.bz2) bunzip2 "$1" ;;
    *.rar) rar x "$1" ;;
    *.gz) gunzip "$1" ;;
    *.tar) tar xf "$1" ;;
    *.tbz2) tar xjf "$1" ;;
    *.tgz) tar xzf "$1" ;;
    *.zip) unzip "$1" ;;
    *.Z) uncompress "$1" ;;
    *.7z) 7z x "$1" ;;
    *) echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Delete files that match a certain pattern from the current directory.
delete_files() {
  local q="${1:-*.DS_Store}"

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  find . -type f -name "$q" -ls -delete
}

# Create data URI from a file.
datauri() {
  local mimeType=""

  if [ -f "$1" ]; then
    mimeType=$(file -b --mime-type "$1")
    #                └─ do not prepend the FILE to the output

    if [[ $mimeType == text/* ]]; then
      mimeType="$mimeType;charset=utf-8"
    fi

    printf "data:%s;base64,%s" \
      "$mimeType" \
      "$(openssl base64 -in "$1" | tr -d "\n")"
  else
    printf "%s is not a file.\n" "$1"
  fi
}

# check if a certain process is running
function is_running {
  declare -r PROCESS="$1"

  if pgrep -f "$PROCESS" >/dev/null; then
    echo "($PROCESS) is running"
  else
    echo "($PROCESS)" "is not running."
  fi
}

# Process phone images.
ppi() {
  command -v "convert" &>/dev/null ||
    exit 0

  declare query="${1:-*.jpg}"
  declare geometry="${2:-50%}"

  for i in $query; do

    if [[ "$(echo "${i##*.}" | tr '[:upper:]' '[:lower:]')" != "png" ]]; then
      imgName="${i%.*}.png"
    else
      imgName="_${i%.*}.png"
    fi

    convert "$i" \
      -colorspace RGB \
      +sigmoidal-contrast 11.6933 \
      -define filter:filter=Sinc \
      -define filter:window=Jinc \
      -define filter:lobes=3 \
      -sigmoidal-contrast 11.6933 \
      -colorspace sRGB \
      -background transparent \
      -gravity center \
      -resize "$geometry" \
      +append \
      "$imgName" &&
      printf "* %s (%s)\n" \
        "$imgName" \
        "$geometry"

  done
}

# Label: Print Black on White
# Description: Print black text on a white background.
# Parameters: $1 (required) - Content to print.
_print_black_on_white() {
  local content="$1"
  printf "\e[0;30m\e[48;5;255m$content\033[m"
}

# Label: Clip and Print
# Description: Copy input to clipboard and print what what was copied (best used with a pipe).
# Parameters: $1 (optional) - Displays "(copied to cliboard)" on a new line. Default: false.
_copy_and_print() {
  local delimiter=${1:-' '}
  local message="$delimiter(copied to clipboard)\n"

  pbcopy && printf "%s" "$(pbpaste)" && printf "$message"
}

# Label: Toggle Total Color
# Description: Format and conditionally color the total.
# Parameters: $1 (required) - The total, $2(required) - The label, $3 (required) - The color.
_toggle_total_color() {
  local total="$1"
  local label="$2"
  local color="$3"

  if [[ $total -gt 0 ]]; then
    printf "$color$total $label\033[m"
  else
    printf "$total $label"
  fi
}
