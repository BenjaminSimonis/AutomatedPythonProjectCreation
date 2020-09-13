# Automated Python Project Creation

This little project helps you to create a standard structure for a python project. Also it creates a GitHub repository and makes an initial commit.

At this time, this is tested on Linux and works with Python3.



## Structure

```bash
├── app
│   └── __init__.py
├── data
│   └── __init__.py
├── __init__.py
├── logs
│   ├── error.log
│   └── __init__.py
├── README.md
└── test
    └── __init__.py
```

## Setup

```bash
pip3 install -r requirements.txt

# Edit Constants
vim constants.py

# Edit absolute path
vim git_ini.sh

chmod +x git_ini.sh

echo 'alias create="/path/to/git_ini.sh"' >> ~/.bashrc

source ~/.bashrc
```

## Usage

```bash
# Create local python project without remote repository
create $PROJECTNAME

# Create python project with remote repository in GitHub
create $PROJECTNAME gh

# Create python project with remote repository in your GitLab
create $PROJECTNAME gl
```