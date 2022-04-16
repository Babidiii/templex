#!/usr/bin/env bash
# -----------------------------------
#| bgll.fullstackfullstock.com       |
#| github.com/babidiii               |
# -----------------------------------

# customize you latex build command here if needed
find -name *.tex | entr xelatex -shell-escape -output-directory=./build ./src/rapport.tex 
