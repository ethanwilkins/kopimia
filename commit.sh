#!/bin/bash

cd /Users/ethanwilkins/Documents/GitHub/

rm -rf social/*

cp -r /Users/ethanwilkins/Documents/ruby/rails/social/ /Users/ethanwilkins/Documents/GitHub/social/

cd /Users/ethanwilkins/Documents/GitHub/social

echo -e "\nCOMMITTING NOW\n"

git add -A

git commit -m "$1"

git push

echo -e "\nDONE COMMITTING\n"