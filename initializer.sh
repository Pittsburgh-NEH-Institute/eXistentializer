#!/usr/bin/env bash

source properties.txt

cat > expath-pkg.xml << XPATH_PKG_END
<?xml version="1.0" encoding="UTF-8"?>
<package
    xmlns="http://expath.org/ns/pkg"
    name="$project_URI/app/$name"
    abbrev="$name"
    version="$version"
    spec="1.0">
    <title>$description</title>
    <dependency processor="http://exist-db.org" semver-min="$exist_version"/>
</package>
XPATH_PKG_END


cat > repo.xml << REPO_END
<?xml version="1.0" encoding="UTF-8"?>
<meta
    xmlns="http://exist-db.org/xquery/repo">
    <description>$description</description>
    <author>$author</author>
    <website>$author_URI</website>
    <status>$release_status</status>
    <license>$license</license>
    <copyright>true</copyright>
    <type>application</type>
    <target>$name</target>
    <prepare>pre-install.xq</prepare>
    <finish/>
</meta>
REPO_END
