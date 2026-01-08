# Section: [asciinema](https://asciinema.org) #
#---------------------------------------------#

# Label: asciinema Record
# Description: Create new asciinema recording.
# Parameters: $1 (required) - The recording label.
cinr() {
  local label="$1"
  local name="${label,,}.cast"

  if [[ -z "$label" ]]; then
    printf "%s\n" "ERROR: Recording label is missing."
    return 1
  fi

  asciinema rec --title "$label" "$name"
}
