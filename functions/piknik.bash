# Section: [piknik](https://github.com/jedisct1/piknik#suggested-shell-aliases) #
#-------------------------------------------------------------------------------#

# pko <content> : copy <content> to the clipboard
pko() {
  if command -v "piknik" &>/dev/null; then
    echo "$*" | piknik -copy
  else
    echo "(piknik) is not installed"
  fi
}

# pkf <file> : copy the content of <file> to the clipboard
pkf() {
  if command -v "piknik" &>/dev/null; then
    piknik -copy <"$1"
  else
    echo "(piknik) is not installed"
  fi
}

# pkfr [<dir>] : send a whole directory to the clipboard, as a tar archive
pkfr() {
  if command -v "piknik" &>/dev/null; then
    tar czpvf - "${1:-.}" | piknik -copy
  else
    echo "(piknik) is not installed"
  fi
}
