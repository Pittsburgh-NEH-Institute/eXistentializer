# eXist-db app initializer shell script

Location: <https://github.com/Pittsburgh-NEH-Institute/initializer>

Authors:

* Gabi Keane, gabakeane@gmail.com
* David J. Birnbaum, djbpitt@gmail.com, <http://www.obdurodon.org>

## Overview

The **eXist-db App Initializer** is a lightweight bash shell script that creates the housekeeping files needed to build and install an [eXist-db](https://exist-db.org) package into an instance of the database. The initializer reads a *properties.txt* file that you customize for your project and it uses the information there to create the following files required for useful eXist-db *xar* packages:

* *repo.xml*
* *build.xml*
* *expath-pkg.xml*
* *pre-install.xq*

The Initializer also creates an *.exist.json* file that supports synchronizing development inside VSCode with a running instance of eXist-db.

The Initializer prioritizes light weight and ease of use, which means that it creates the three XML files that are required for building and installing an *xar* package (plus the *pre-install.xq* file that helps support indexing) but it does not attempt to create all content that users might want in a project repo. For example, the Initializer does not attempt to configure eXist-db users and permissions, GitHub continuous integration (CI), or Docker. Users who require that additional functionality will find it in Duncan Paterson’s [generator-exist](https://github.com/eXist-db/generator-exist) project.

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
- How to change version or status (rerun initializer or hand-edit generated configuration files)

## About the generated files

### repo.xml

This file is needed to build and install an eXist-db *xar* package. It should not be edited by hand except (optionally) to change the *status* (e.g., alpha, beta, stable) of a project before rebuilding. As an alternative to hand-editing you can update *properties.txt* and rerun the Initializer, which will recreate this file.

### expath-pkg.xml

This file is needed to build and install an eXist-db *xar* package. It should not be edited by hand except (optionally) to change the *release version* (e.g., 0.0.1) of a project before rebuilding. As an alternative to hand-editing you can update *properties.txt* and rerun the Initializer, which will recreate this file.

### build.xml

This file is needed to build and install an eXist-db *xar* package. It should not be edited by hand.

### pre-install.xq

This file copies a file with the filename extension *.xconf* from the project directory into a location where eXist-db will use it to support indexed retrieval, facets, and fields. It should not be edited by hand. It is possible to build and install a package without a *pre-install.xq*, but the Initializer nonetheless supports this file because any non-trivial eXist-db will use indexing. The Initializer does not create index files because 1) those are highly project specific, and 2) they are commonly hand-edited and we wanted to ensure that the Initializer could be rerun in an existing project without accidentally overwriting files a user might reasonably be expected to have changed.

### .exist.json

This file is not needed to build or install an eXist-db *xar* package, but it is needed to support real-time synchronization between files edited in VSCode and running instance of eXist-db. Users who do not use VSCode can either edit *initializer.sh* to remove the block of code that creates this file or simply delete *.exist.json* after it is created.

## Credit


