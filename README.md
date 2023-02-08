# eXistentializer: a shell script for generating skeleton eXist-db applications

Location: <https://github.com/Pittsburgh-NEH-Institute/eXistentializer>

Authors:

* Gabi Keane, gabakeane@gmail.com
* David J. Birnbaum, djbpitt@gmail.com, <http://www.obdurodon.org>

## Overview

**eXistentializer** is a lightweight bash shell script that creates the housekeeping files needed to build and install an [eXist-db](https://exist-db.org) package into an instance of the database. The eXistentializer reads a *properties.txt* file that you customize for your project and it uses the information there to create the following files required for useful eXist-db *xar* packages:

* *repo.xml*
* *build.xml*
* *expath-pkg.xml*
* *pre-install.xq*

**eXistentializer** also creates an *.exist.json* file that supports synchronizing development inside VSCode with a running instance of eXist-db. Users have the option to create directories and a sample test structure.

**eXistentializer** prioritizes light weight and ease of use, which means that it creates the three XML files that are required for building and installing an *xar* package (plus the *pre-install.xq* file that helps support indexing) but it does not attempt to create all content that users might want in a project repo. For example, **eXistentializer** does not attempt to configure eXist-db users and permissions, GitHub continuous integration (CI), or Docker. Users who require that additional functionality will find it in Duncan Paterson’s [generator-exist](https://github.com/eXist-db/generator-exist) project.

## Getting started
This script relies on two files to configure the basic app housekeeping required by eXist-db. These files are called `properties.txt` and `eXistentializer.sh`. To run the script and build the application for installation in eXist-db, users require the following software.

### Dependencies
- bash shell
    - Mac and Linux users: use the Terminal or Bash shell already on your computer, or your preferred shell
    - Windows users: use [Git Bash](https://gitforwindows.org/)
- Git
- `ant` is required to build and install eXist-db applications
    - [Mac Homebrew](https://formulae.brew.sh/formula/ant) users may use `brew install ant` at command line
    - Linux users don't need my instructions here
    - [Windows Chocolatey](https://community.chocolatey.org/packages/ant) users may use `choco install ant` at Git bash shell command line

### Instructions

1. Clone the **eXistentializer** repository.
1. Copy or put *eXistentializer.sh* in your PATH and set to executable (`chmod +x eXistentializer.sh`)
1. Create an empty repository for your new app and copy or put *properties.txt* into it. Using a plain text editor, edit the configuration properties according to your requirements and save.
1. At the command line, navigate to your new project directory and run `eXistentializer.sh`. The shell script reads *properties.txt* to create the required housekeeping files.
1. (optional) Using Git and GitHub
    - At the command line, navigate to the target directory and run `git init` to initialize Git.
    - In GitHub, create a new *empty* repository with the same name as your target directory. Do not add a description, README, .gitignore, or license.
    - Once you have created the empty repository, follow the instructions under "...or push an existing repository from the command line."

## About the generated files

### repo.xml

This file is needed to build and install an eXist-db *xar* package. It should not be edited by hand except (optionally) to change the *status* (e.g., alpha, beta, stable) of a project before rebuilding. As an alternative to hand-editing you can update *properties.txt* and rerun the Initializer, which will recreate this file.

### expath-pkg.xml

This file is needed to build and install an eXist-db *xar* package. It should not be edited by hand except (optionally) to change the *release version* (e.g., 0.0.1) of a project before rebuilding. As an alternative to hand-editing you can update *properties.txt* and rerun the Initializer, which will recreate this file.

### build.xml

This file is needed to build and install an eXist-db *xar* package. It should not be edited by hand.

### pre-install.xq

This file is run automatically when an app is installed into a running instance of eXist-db. It copies a file with the filename extension *.xconf* from the project directory into a location where eXist-db will use it to support indexed retrieval, facets, and fields, and the project files are then indexed automatically as they are installed. This file should not be edited by hand. 

It is possible to build and install a package without a *pre-install.xq*, but the Initializer nonetheless supports this file because any non-trivial eXist-db app will use indexing. The Initializer does not create actual index files because 1) those are highly project specific, and 2) they are commonly hand-edited and we wanted to ensure that the Initializer could be rerun inside an existing project without accidentally overwriting files a user might reasonably be expected to have changed.

### .exist.json

This file is not needed to build or install an eXist-db *xar* package, but it is needed to support real-time synchronization between files edited in VSCode and running instance of eXist-db. Users who do not use VSCode can either edit *initializer.sh* to remove the block of code that creates this file or simply delete *.exist.json* after it is created.

## Optional files

Optional files are generated when the user sets the value of `create_directory_structure` to "true" in the *properties.txt* configuration file. If **eXistentializer** is re-run over an existing repository, the script does not overwrite existing content.

### *modules* and *modules/lib.xql*

The *modules* subdirectory contains a sample XQuery library (*lib.xql*) with one function. This function is used in the sample test (see below).

### *data*

The *data* subdirectory contains an empty *.gitkeep* file, which the user should delete when adding their own content.

### *tests* (includes two files)

The *tests* subdirectory includes *test-suite.xq* and *test-runner.xq*. The user writes tests in *test-suite.xq* and runs the tests by executing *test-runner.xq* in eXide or VSCode. The user tests functions that are declared in *lib.xql* or any other XQuery library module they specify in *test-runner.xq*. Testing is included in the [eXist-db documentation](http://exist-db.org).

Common modifications to support a model–view–controller (MVC) architecture include creating a *controller.xql* file (see Siegel and Retter, *eXist*, 197 ff) and a *views* subdirectory that holds XQuery or XSLT files.

## Credit

* **eXistentializer** is part of "Advanced digital editing: modeling the text and making the edition", a 2022 Institute for Advanced Topics in the Digital Humanities awarded by the NEH Office of Digital Humanities (ODH) and co-funded by the NEH Division of Research Programs. Any views, findings, conclusions, or recommendations expressed in materials developed for this project do not necessarily represent those of the National Endowment for the Humanities.
* Parts of **eXistentializer** make use of code from [**generator-exist**](https://github.com/eXist-db/generator-exist) under an [MIT license](LICENSE-MIT.md).


