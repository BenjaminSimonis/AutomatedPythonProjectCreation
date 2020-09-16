#!/bin/bash

INITPATH=""     # Absolute path to this project with / at the end

function create() {
    ### path = Project root directory of your projects, imported from constants
    path=$(sed -n '9p' < ${INITPATH}constants.py | cut -d'"' -f 2)
    USERNAME=""

    ### Goes to users homedirectory to create the new project there in subdirectory. 
    cd
    mkdir -p $path
    cd $path

    ### If remote repository variable is given, create a subdirectory for it. 
    if [[ "$2" == "gh" ]]
    then
        USERNAME=$(sed -n '1p' < ${INITPATH}constants.py | cut -d'"' -f 2)
        mkdir -p GitHub
        cd GitHub
    elif [[ "$2" == "gl" ]]
    then
        USERNAME=$(sed -n '4p' < ${INITPATH}constants.py | cut -d'"' -f 2)
        mkdir -p GitLab
        cd GitLab
    fi

    mkdir $1
    cd $1
    PROJECTPATH=$(pwd)

    ### Project Structure Creation ###
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

    ### Create local git repository
    git init
    git add .
    git commit -m "Initial commit"

    ### Create remote repository, if variable $2 is given
    if [[ -z "$2"]]
    then
        cd $INITPATH
        python3 create.py $1 $2
        cd ${PROJECTPATH}
    fi

    ### If valid remote variable is given, project will be pushed to new created remote repository
    if [[ "$2" == "gh" ]]
    then
        git remote add origin git@github.com:$USERNAME/$1.git
        git push -u origin master
    elif [[ "$2" == "gl" ]]
    then
        gitlab=$(sed -n '7p' < ${INITPATH}constants.py | cut -d'"' -f 2)
        git remote add origin $gitlab$USERNAME/$1.git
        git push -u origin master
    fi

    ### Starts Visual Studio Code in the new created project directory if uncommented
    # code . &
}
