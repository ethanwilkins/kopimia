#!/bin/bash

echo -e "\nARCH COMMITTING NOW\n"

git add -A

git commit -m "$1"

git push

echo -e "\nARCH DONE COMMITTING\n"

