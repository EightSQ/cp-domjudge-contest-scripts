#!/bin/bash

set -e

function problem_init {
    problem_name=$1
    problem_name=$2

    # Here add whatever you like for your problem setup preparation

    # Download problem statement pdf
    curl -s -o "problem.pdf" \
        "$judge_url/public/problems/$problem_id/text"
}

contest_id=$1
judge_url=$(cat $HOME/.config/domjudge/judgeurl)
if [[ -z $contest_id ]]; then
    echo "usage: $0 <contest_id>"
    exit 1
fi

contests=$(curl -s "$judge_url/api/contests/$contest_id/problems" | jq '.[] | [.name, .id] | join(",")')

while read line; do
    line=$(sed "s/\"//g" <<< $line)
    problem_name=$(cut -d"," -f1 <<< $line)
    problem_id=$(cut -d"," -f2 <<< $line)
    mkdir "$problem_name"
    cd $problem_name
    echo $problem_id >".problem"
    echo $contest_id >".contest"
    problem_init $problem_name $problem_id
    cd ..
done <<< $contests
