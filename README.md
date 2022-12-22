# eXist-db app initializer shell script

Location: <https://github.com/Pittsburgh-NEH-Institute/initializer>

Authors:

* Gabi Keane, gabakeane@gmail.com
* David J. Birnbaum, djbpitt@gmail.com, <http://www.obdurodon.org>

## Overview

The eXist-db App Initializer is a lightweight bash shell script that creates the housekeeping files needed to build and install an eXist-db package into an instance of the database. The initializer reads a *properties.txt* file that you customize for your project and it uses the information there to create the following files:

* *repo.xml*
* *build.xml*
* *expath-pkg.xml*
* *pre-install.xq*

The initializer also creates an *.exist.json* file that supports synchronizing development inside VSCode with a running instance of eXist-db. This synchronization assumes that you are running eXist-db on your local machine on port 8080 and that the *admin* password is null. If you are not using VSCode, you can either edit *initializer.sh* to remove the code that creates *.exist.json* or just delete that file after it is created.

The Initializer prioritizes light weight and ease of use, which means that it creates the three files that are required for building and installing an *xar* package file but it does not attempt to create all content that users might want in a project repo. For example, the Initializer does not attempt to configure eXist-db users and permissions, GitHub continuous integration (CI), or Docker. Users who require that additional functionality will find it in Duncan Paterson’s [generator-exist](https://github.com/eXist-db/generator-exist) project.

## Getting started
- edit properties.txt
- run initializer.sh

## Development patterns
- run ant (add links?)
- install in eXist-db using package manager
- start syncing in VSCode (optional)

## Credit


