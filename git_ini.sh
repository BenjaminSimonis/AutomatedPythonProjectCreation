#!/bin/bash

INITPATH=""     # Absolute path to this project with / at the end

function create() {
    USERNAME=$(sed -n '1p' < ${INITPATH}constants.py | cut -d'"' -f 2)
    path=$(sed -n '3p' < ${INITPATH}constants.py | cut -d'"' -f 2)
    cd
    mkdir -p $path
    cd $path
    mkdir $1
    cd $1
    curl -o .gitignore https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore
    echo "# My Python Project" > "README.md"
    touch __init__.py
    touch requirements.txt
    mkdir app
    touch app/__init__.py
    mkdir data
    touch data/__init__.py
    mkdir logs
    touch logs/__init__.py
    touch logs/error.log
    mkdir test
    touch test/__init__.py
    
    cd $INITPATH
    python3 create.py $1

    cd
    cd ${path}${1}
    git init
    git remote add origin git@github.com:$USERNAME/$1.git
    git add .
    git commit -m "Initial commit"
    git push -u origin master
}
