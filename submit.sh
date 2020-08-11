#!/bin/bash

set -e

source_file=$1
if [[ -z "$1" ]]; then
    echo "usage: $0 <source_file>"
    exit 1
fi

login_cookie=$(cat $HOME/.config/domjudge/session)
contest_id=$(cat $(dirname $source_file)/.contest)
problem_id=$(cat $(dirname $source_file)/.problem)
case ${source_file##*.} in
    "cpp") language="cpp17" ;;
    "py") language="py3" ;;
    *) echo "unknown language" && exit 1 ;;
esac
judge_url=$(cat $HOME/.config/domjudge/judgeurl)

echo "submitting to contest $contest_id, problem $problem_id: $source_file (in language $language)"
http -f post \
    "$judge_url/team/submit" \
    "Cookie:domjudge_refresh=1; PHPSESSID=$login_cookie; domjudge_cid=$contest_id" \
    "submit_problem[code][]@$source_file" \
    "submit_problem[entry_point]=" \
    "submit_problem[language]=$language" \
    "submit_problem[problem]=$problem_id" \
    >/dev/null

team_dashboard="$judge_url/team"
submitted=$(http get $team_dashboard "Cookie:domjudge_refresh=1; PHPSESSID=$login_cookie; domjudge_cid=$contest_id" | grep "Submission done")


if [[ ! -z $submitted ]]; then
    echo "opening $team_dashboard"
    case "$(uname -s)" in
        Linux*) xdg-open $team_dashboard ;;
        Darwin*) open $team_dashboard ;;
        *) ;;
    esac
else
    echo "could not submit"
fi
