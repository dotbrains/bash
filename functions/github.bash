#---------------------------------------#
# Section: [GitHub](https://github.com) #
#---------------------------------------#

# Label: GitHub
# Description: View GitHub details for current project.
# Parameters: $1 (optional) - The option selection, $2 (optional) - The option input.
gh() {
  if [[ -d ".git" ]]; then
    while true; do
      if [[ $# == 0 ]]; then
        printf "\n%s\n" "Usage: gh OPTION"
        printf "\n%s\n" "GitHub Options (default browser):"
        printf "%s\n" "  o: Open repository."
        printf "%s\n" "  i: Open repository issues."
        printf "%s\n" "  c: Open repository commits. Options:"
        printf "%s\n" "     HASH: Open commit."
        printf "%s\n" "  f: Copy repository file URL."
        printf "%s\n" "  b: Open repository branches. Options:"
        printf "%s\n" "     c: Open current branch."
        printf "%s\n" "     d: Open diff for current branch."
        printf "%s\n" "     r: Open pull request for current branch."
        printf "%s\n" "  t: Open repository tags."
        printf "%s\n" "  r: Open repository pull requests."
        printf "%s\n" "     NUMBER: Open pull request."
        printf "%s\n" "     l: List pull requests."
        printf "%s\n" "  w: Open repository wiki."
        printf "%s\n" "  p: Open repository pulse."
        printf "%s\n" "  g: Open repository graphs."
        printf "%s\n" "  s: Open repository settings."
        printf "%s\n" "  u: Print and copy repository URL. Options:"
        printf "%s\n" "     HASH: Print and copy commit URL."
        printf "%s\n" "     l: Print and copy last commit URL."
        printf "%s\n\n" "  q: Quit/Exit."
        read -p "Enter selection: " response
        printf "\n"
        _process_gh_option "$response" "$2"
      else
        _process_gh_option "$1" "$2" "$3"
      fi
      break
    done
  else
    printf "%s\n" "ERROR: Not a Git repository!"
    return 1
  fi
}

# Label: GitHub Pull Request (all)
# Description: Open pull requests for all projects in current directory (non-master branches only).
ghpra() {
  while read -r project; do
    (
      cd "$project" || exit

      if [[ -d ".git" ]]; then
        if [[ "$(_git_branch_name)" != "master" ]]; then
          gh b r # a.k.a. GitHub Branch Pull Request
        fi
      fi
    )
  done < <(ls -A1)
}

# Label: GitHub URL
# Description: Answer GitHub URL for current project.
_gh_url() {
  local remote="$(git remote -v | ag github.com | ag fetch | head -1 | cut -f2 | cut -d' ' -f1)"
  local match="^git@.*"

  if [[ "$remote" =~ $match ]]; then
    printf "$remote" | sed -e 's/:/\//' -e 's/git@/https:\/\//' -e 's/\.git//'
  else
    printf "$remote"
  fi
}

# Label: GitHub Pull Request List
# Description: List pull requests (local/remote) including subject, author, and relative time.
# Parameters: $1 (optional) - The output format.
_gh_pr_list() {
  local format=${1:-"%(refname) %(color:yellow)%(refname)%(color:reset) %(subject) %(color:blue bold)%(authorname) %(color:green)(%(committerdate:relative))"}

  git for-each-ref --color --format="$format" refs/remotes/pull_requests |
    sed 's/refs\/remotes\/pull_requests\///g' |
    sort --numeric-sort |
    cut -d' ' -f2-
}

# Label: Process GitHub Commit Option
# Description: Process GitHub commit option for remote repository viewing.
# Parameters: $1 (optional) - The commit hash.
_process_gh_commit_option() {
  local commit="$1"

  if [[ "$commit" ]]; then
    open "$(_gh_url)/commit/$commit"
  else
    open "$(_gh_url)/commits"
  fi
}

# Label: Process GitHub File Option
# Description: Process GitHub file option for remote repository viewing.
# Parameters: $1 (required) - The local (relative) file path, $2 (optional) - The line numbers.
_process_gh_file_option() {
  local path="$1"
  local lines="$2"
  local start_index=$(pwd | wc -c)
  local end_index=$(printf "$path" | wc -c)
  local url="$(_gh_url)/blob/$(_git_branch_name)/${path:$start_index:$end_index}"

  if [[ -n "$lines" ]]; then
    url="$url#$lines"
  fi

  printf "$url" | _copy_and_print
}

# Label: Process GitHub Branch Option
# Description: Process GitHub branch option for remote repository viewing.
# Parameters: $1 (optional) - The option.
_process_gh_branch_option() {
  case $1 in
  'c')
    open "$(_gh_url)/tree/$(_git_branch_name)"
    ;;
  'd')
    open "$(_gh_url)/compare/$(_git_branch_name)"
    ;;
  'r')
    open "$(_gh_url)/compare/$(_git_branch_name)?expand=1"
    ;;
  *)
    open "$(_gh_url)/branches"
    ;;
  esac
}

# Label: Process GitHub Pull Request Option
# Description: Process GitHub pull request option for remote repository viewing.
# Parameters: $1 (optional) - The option.
_process_gh_pull_request_option() {
  local option="$1"
  local number_match="^[0-9]+$"

  if [[ "$option" =~ $number_match ]]; then
    open "$(_gh_url)/pull/$option"
  elif [[ "$option" == 'l' ]]; then
    _gh_pr_list
  else
    open "$(_gh_url)/pulls"
  fi
}

# Label: Process GitHub URL Option
# Description: Processes GitHub URL option for remote repository viewing.
# Parameters: $1 (optional) - The commit/option.
_process_gh_url_option() {
  local commit="$1"
  local commit_match="^([0-9a-f]{40}|[0-9a-f]{7})$"

  if [[ "$commit" =~ $commit_match ]]; then
    printf "$(_gh_url)/commit/$commit" | _copy_and_print
  elif [[ "$commit" == 'l' ]]; then
    printf "$(_gh_url)/commit/$(_git_commit_last)" | _copy_and_print
  else
    _gh_url | _copy_and_print
  fi
}

# Label: Process GitHub Option
# Description: Processes GitHub option for remote repository viewing.
# Parameters: $1 (optional) - The first option, $2 (optional) - The second option.
_process_gh_option() {
  case $1 in
  'o')
    open $(_gh_url)
    ;;
  'i')
    open "$(_gh_url)/issues"
    ;;
  'c')
    _process_gh_commit_option "$2"
    ;;
  'f')
    _process_gh_file_option "$2" "$3"
    ;;
  'b')
    _process_gh_branch_option "$2"
    ;;
  't')
    open "$(_gh_url)/tags"
    ;;
  'r')
    _process_gh_pull_request_option "$2"
    ;;
  'w')
    open "$(_gh_url)/wiki"
    ;;
  'p')
    open "$(_gh_url)/pulse"
    ;;
  'g')
    open "$(_gh_url)/graphs"
    ;;
  's')
    open "$(_gh_url)/settings"
    ;;
  'u')
    _process_gh_url_option "$2"
    ;;
  'q') ;;
  *)
    printf "%s\n" "ERROR: Invalid option."
    ;;
  esac
}
