#!/bin/bash

echo -e "\nCopying...\n"

cd /Users/ethanwilkins/Documents/GitHub/

rm -rf kopimia/*

cp -r /Users/ethanwilkins/Documents/ruby/rails/kopimia/ /Users/ethanwilkins/Documents/GitHub/kopimia/

cd /Users/ethanwilkins/Documents/GitHub/kopimia

echo -e "Committing...\n"

git add -A

git commit -m "$1"

git push

echo -e "\n"