#!/bin/sh
set -e
existing=$(grep -o '^[^#]*' $1)
if [ $(grep -o '^[^#]*' $1 | wc -l) = "0" ]; then
  echo 'Aborting commit due to empty commit message.'
  exit -1
branch=$(git rev-parse --abbrev-ref HEAD)
ticket=$(echo $branch | perl -lne '/([A-Z]+-\d+)/ && print $1')
prefix=""
if [ $branch != "master" ]; then
  prefix="[$ticket] "
fi
echo "${prefix}$(cat $1)" > $1