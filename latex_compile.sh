#!/usr/bin/env bash
# -----------------------------------
#| bgll.fullstackfullstock.com       |
#| github.com/babidiii               |
# -----------------------------------


#pdflatex rapport.tex 

ls ./src/*.tex | entr xelatex -shell-escape -output-directory=./build ./src/rapport.tex 
