# eXist-db app initializer shell script

## Overview
- lightweight
- yeoman generator link

## Getting started
This script relies on two files to configure the basic app housekeeping files required by eXist-db. These files are called `properties.txt` and `initializer.sh`. To run the script and build the application for installation in eXist-db, users require the following software.

### Dependencies
- bash shell
    - Mac and Linux users: use the Terminal or Bash shell already on your computer, or your preferred shell
    - Windows users: use [Git Bash](https://gitforwindows.org/)
- Git
- `ant` is required to build and install eXist-db applications
    - [Mac Homebrew](https://formulae.brew.sh/formula/ant) users may use `brew install ant` at command line
    - Linux users don't need my instructions here
    - [Windows Chocolatey](https://community.chocolatey.org/packages/ant) users may use `choco install ant` at Git bash shell command line

### Instructions (draft, please do not attempt)

1. Download the `repo name` and save to the directory on your computer where you plan to create the eXist-db application.
2. Open `properties.txt` with your favorite text editor. Edit the configuration properties according to your requirements and save.
    2a. Specify the target directory you where you plan to develop the application.
3. At the command line, navigate to the `initializer` directory and run `./initializer.sh`.
4. (optional) Using Git and GitHub
    - At the command line, navigate to the target directory and run `git init` to initialize Git.
    - In GitHub, create a new *empty* repository with the same name as your target directory. Do not add a description, README, .gitignore, or license.
    - Once you have created the empty repository, follow the instructions under "...or push an existing repository from the command line."

## Development patterns
- run ant (add links?)
- install in eXist-db using package manager
- start syncing in VSCode (optional)

## Credit


