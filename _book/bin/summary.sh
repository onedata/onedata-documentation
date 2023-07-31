#!/usr/bin/env bash

git_extra_mktemp() {
    mktemp -t "$(basename "$0")".XXX
 }
export -f git_extra_mktemp

tmp=$(git_extra_mktemp)
above=0

# if the output won't be printed to tty, disable the color
test -t 1 && to_tty=true
color=
longest_line=0
sort_column=2
review_file=REVIEW
qurated_file=QURATED

#
# print usage message
#
usage() {
  echo 1>&2 "usage: git effort [--above <value>] --sort [ <column_number>[,<column_number>]...] [<path>...] [-- [<log options>...]]"
}

#
#
#
file_needs_review() {
  if grep "^$1[[:space:]]*$" "$review_file" 1>/dev/null ; then
    review_start_time="$(git log --diff-filter=A --follow --format=%at -1 -- $review_file)"
    file_last_commit_time="$(git log  -1 --format=%ct  -- $1)"
    is_file_modified_locally="$(git status --porcelain $1)"
    if [[ $is_file_modified_locally != "" ]]; then
      needs_review="local"
    elif (( (file_last_commit_time - review_start_time) > 0)); then
      needs_review="committed"
    else
      needs_review="yes"
    fi

  else
    needs_review="no"
  fi
  echo "$needs_review"
}

#
# get main file or directory contributor using git blame
#
main_file_contributor() {
  if [[ $(file "$1") = *text* ]]; then
    git blame --line-porcelain "$1" 2>/dev/null | grep "^author\ " | LC_ALL=C sed -n 's/^author //p' | sort | uniq -c | sort -nr | head -1 | tr -s ' '
  elif [[ $(file "$1") = *directory* ]]; then
      git ls-files "$1" | xargs -I{} git blame --line-porcelain {} 2>/dev/null | grep "^author\ " | LC_ALL=C sed -n 's/^author //p' | sort | uniq -c | sort -nr | head -1 | tr -s ' '
  else
    git log --date-order -1 --format='%an' "$1"
  fi
}

#
# calculates number of days passed from a given date
# expected input format is 2016-12-22
#
days_passed() {
   a_date=$(date -j -f '%Y-%m-%d' "$1" '+%s' )
   now=$(date -j '+%s')
   datediff=$(( (  now - a_date )/60/60/24  ))
   echo "$datediff"
   #date -j -f '%Y-%m-%d' '2016-12-22' "+DATE: %Y-%m-%d%nTIME: %H:%M:%S"
}

#
# get dates for the given <commit>
#
dates() {
  eval "git log $args_to_git_log --date-order --pretty='format: %ad' --date=short -- \"$1\""
}

#
# gets the tag that was created just before the last commit on this file
#
last_tag() {
  save_ifs=$IFS
  IFS=$'\t' read -r -a last_commit_with_tags <<< "$(git --no-pager  log --date-order --before "$1" --pretty=format:'%ad%x09%D' --tags --date=short | grep "tag:" | head -1)"
  IFS=$save_ifs
  read -r -a last_tags <<< "$(echo "${last_commit_with_tags[1]}" | tr ',' '\n' | grep 'tag: ' )"
  without_date="${last_tags[*]}"
  echo "${without_date:5}" # remove 'tag: '
}

# tput, being quiet about unknown capabilities
tputq() {
  tput "$@" 2>/dev/null
  return 0
}

#
# hide cursor
#
hide_cursor() {
  tputq civis 
}

#
# show cursor, and remove temporary file
#
show_cursor_and_cleanup() {
  tputq cvvis
  tputq sgr0
  rm "$tmp" > /dev/null 2>&1
  exit 0
}

#
# get active days for the given <commit>
#
active_days() {
  echo "$1" | sort -r | uniq | wc -l
}

#
# set 'color' based on the given <num>
#
color_for() {
  if [ "$to_tty" = true ]; then
    if [[ $1 = "yes" ]]; then color="$(tputq setaf 1)"  # red
    elif [[ $1 = "no" ]]; then color="$(tputq setaf 2)"  # green
    elif [[ $1 = "committed" ]]; then color="$(tputq setaf 5)"  # purplish
    elif [[ $1 = "local" ]]; then color="$(tputq setaf 3)"  # yellow
    elif   [ $1 -gt 200 ]; then color="$(tputq setaf 1)$(tputq bold)"
    elif [ $1 -gt 150 ]; then color="$(tputq setaf 1)"  # red
    elif [ $1 -gt 125 ]; then color="$(tputq setaf 2)$(tputq bold)"
    elif [ $1 -gt 100 ]; then color="$(tputq setaf 2)"  # green
    elif [ $1 -gt 75 ]; then color="$(tputq setaf 5)$(tputq bold)"
    elif [ $1 -gt 50 ]; then color="$(tputq setaf 5)"  # purplish
    elif [ $1 -gt 25 ]; then color="$(tputq setaf 3)$(tputq bold)"
    elif [ $1 -gt 10 ]; then color="$(tputq setaf 3)"  # yellow
    else color="$(tputq sgr0)" # default color
    fi
  else
    color=""
  fi
}

#
# compute the effort of the given <path ...>
#
effort() {
    path=$1
    local commit_dates
    local color reset_color commits len dot f_dot i msg active
    reset_color=""
    test "$to_tty" = true && reset_color="$(tputq sgr0)"
    commit_dates=$(dates "$path")
    [ $? -gt 0 ] && exit 255

    # Ensure it's not just an empty line
    if [ -z "$(head -c 1 <<<$(echo $commit_dates))" ]
    then
      exit 0
    fi

    commits=$(wc -l <<<"$(echo "$commit_dates")")
    color='90'
    newest_commit=$(head -1 <<<"$(echo "$commit_dates")")
    # ignore <= --above
    test $commits -le $above && exit 0

    # commits
    color_for $(( commits - above ))
    len=${#path}
    dot="."
    f_dot="$path"
    i=0 ; while test $i -lt $(( longest_line - len )) ; do
      f_dot=$f_dot$dot
      i=$((i+1))
    done

    msg=$(printf "  ${color}%s %-9d" "$f_dot" "$commits")

    # active days
    active=$(active_days "$commit_dates")
    #a=$(gdate -d "today - $newest_commit")
    color_for $(( active - above ))
    msg="$msg $(printf "${color} %-9d${reset_color}\n" "$active")"

    # days since active
    days_since_active=$( days_passed "${newest_commit#[[:space:]]}" )
    color_for "$days_since_active"
    msg="$msg $(printf "${color} %-10d${reset_color}\n" "$days_since_active")"

    # most active contributor to this file
    contributor="$(main_file_contributor "$path")"
    msg="$msg $(printf "%-30s" "$contributor")"

    # last_tag_for_commit
    last_tag_for_commit=$( last_tag "$newest_commit" )
    [[ $last_tag_for_commit = '' ]] && last_tag_for_commit="     "
    msg="$msg $(printf "${color} %-10s${reset_color}\n" "${last_tag_for_commit[@]}")"


    if [[ -e "$review_file" ]]; then
      # needs review?
      needs_review=$( file_needs_review "$path" )
      color_for "$needs_review"
      [[ $needs_review = "YES" ]] && color="$(tputq setaf 1)$(tputq bold)"
      msg="$msg $(printf "${color} %s${reset_color}\n" "${needs_review}")"
    fi
    echo "$msg"
}

#
# print heading
#

heading() {
  echo
  printf "  %-${longest_line}s %-10s %-10s %-10s %-30s %-10s %s\n" 'path' 'commits' 'active' 'since' 'author' 'tag' 'needs_review'
  echo
} 

#
# output sorted results
#

sort_effort() {
  clear
  echo " "
  heading
  < "$tmp" sort -rn -k $sort_column
}

declare -a paths=()
while [ "${#}" -ge 1 ] ; do

  case "$1" in
    --above)
      shift
      above=$1
      ;;
    --sort)
      shift
      sort_column=$1
      ;;
    --ls-files-opt)
      shift
      ls_files_opt=$1
      ;;
    --)
      shift
      args_to_git_log=$(printf " %q" "${@:1}")
      break
      ;;
    --*)
      usage
      echo 1>&2 "error: unknown argument $1"
      echo 1>&2 "error: if that argument was meant for git-log,"
      echo 1>&2 "error: please put it after two dashes ( -- )."
      exit 1
      ;;
    *)
      paths+=( "$1" )
      ;;
  esac

  shift
done

# Exit if above-value is not an int
if [ -z "${above##*[!0-9]*}" ] ; then
  echo "error: argument to --above was not an integer" 1>&2
  exit 1
fi

# remove empty quotes that appear when there are no arguments
args_to_git_log="${args_to_git_log#\ \'\'}"
export args_to_git_log

# [path ...]

if test "${#paths}" -eq 0; then
  save_ifs=$IFS
  IFS=$(echo -en "\n\b")
 
  if [[ -e "$review_file" ]]; then
    paths=($(grep -v -e '^$' -e "^#" <"$qurated_file"))
  else
    paths=($(git ls-files "$ls_files_opt"))
  fi
  IFS=$save_ifs
  unset save_ifs
fi

# get longest line
longest_line=$(printf '%s\n' "${paths[@]}" | awk '{ if (length() > max) { max = length()} } END {print max}')

# hide cursor
hide_cursor
trap show_cursor_and_cleanup INT

# export functions so subshells can call them
export -f effort
export -f color_for
export -f active_days
export -f dates
export -f tputq
export to_tty
export above
export log_args
export longest_line
export ls_files_opt

export qurated_file
export review_file
export -f main_file_contributor
export sort_column
export -f days_passed
export -f last_tag
export -f file_needs_review

bash_params=
# If bash exits sucessfully with --import-functions,
# then we need to pass it (FreeBSD probably)
bash --import-functions -c ":" 1>/dev/null 2>&1
if [ $? -eq 0 ] ; then
  bash_params="--import-functions"
fi

heading

# send paths to effort
printf "%s\0" "${paths[@]}" | xargs -0 -n 1 -P 4 -I % bash $bash_params -c "effort \"%\"" | tee "$tmp"

# if more than one path, sort and print
test "$(wc -l "$tmp" | awk '{print $1}')" -gt 1 && sort_effort
echo

show_cursor_and_cleanup
