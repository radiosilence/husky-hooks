#!/bin/sh
set -e
existing=$(grep -o '^[^#]*' $1)
branch=$(git rev-parse --abbrev-ref HEAD)
IFS='_' read -ra ticket <<< "$branch"
if [ $(grep -o '^[^#]*' $1 | wc -l) = "0" ]; then
  echo 'Aborting commit due to empty commit message.'
  exit -1
fi
prefix=""
if [ $branch != "master" ]; then
  prefix="[$ticket] "
fi
echo "${prefix}$(cat $1)" > $1