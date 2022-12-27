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

cat > build.xml << BUILD_END
<?xml version="1.0" encoding="UTF-8"?>
<project default="xar" name="$name">
  <description>$description</description>
  <xmlproperty file="expath-pkg.xml" />
  <property name="project.version" value="\${package(version)}" />
  <property name="project.app" value="\${package(abbrev)}" />
  <property name="build.dir" value="build" />
  <target name="xar" description="compile release build">
    <mkdir dir="\${build.dir}" />
    <zip basedir="." destfile="\${build.dir}/\${project.app}-\${project.version}.xar" excludes="**/\${build.dir}/**" />
  </target>
</project>
BUILD_END

cat > .existdb.json << EXISTDBJSON_END

{
  "servers": {
    "localhost": {
      "server": "http://localhost:8080/exist",
      "user": "admin",
      "password": "",
      "root": "/db/apps/$name"
    }
  },
  "sync": {
    "server": "localhost",
    "active": true,
    "ignore": [
      ".existdb.json",
      ".git/**",
      ".github/**",
      "build/**",
      ".vscode/**",
      "README.md",
      "*.code-workspace",
      ".DS_Store"
    ]
  }
}
EXISTDBJSON_END

cat > pre-install.xq << PREINSTALL_END
xquery version "1.0";
(:copied from eXist-db/generator-exist (https://github.com/eXist-db/generator-exist)
 :  under an MIT license, reproduced in this repository as LICENSE-MIT.md:)
(:~ The pre-install runs before the actual install and deploy.
 :
 : @version 0.0.0
 :)
import module namespace xdb="http://exist-db.org/xquery/xmldb";

(: The following external variables are set by the repo:deploy function :)

(: file path pointing to the exist installation directory :)
declare variable \$home external;
(: path to the directory containing the unpacked .xar package :)
declare variable \$dir external;
(: the target collection into which the app is deployed :)
declare variable \$target external;

declare function local:mkcol-recursive(\$collection, \$components) {
    if (exists(\$components)) then
        let \$newColl := concat(\$collection, "/", \$components[1])
        return (
            xdb:create-collection(\$collection, \$components[1]),
            local:mkcol-recursive(\$newColl, subsequence(\$components, 2))
        )
    else
        ()
};

(: Helper function to recursively create a collection hierarchy. :)
declare function local:mkcol(\$collection, \$path) {
    local:mkcol-recursive(\$collection, tokenize(\$path, "/"))
};

(: store the collection configuration :)
local:mkcol("/db/system/config", \$target),
xdb:store-files-from-pattern(concat("/db/system/config", \$target), \$dir, "*.xconf")
PREINSTALL_END

# Optionally create directories for app resources
if [ $create_directory_structure == "true" ] ; then
  [ ! -d "modules" ] && mkdir modules
  [ ! -d "views" ] && mkdir views
  [ ! -d "data" ] && mkdir data
  [ ! -d "tests" ] && mkdir tests
fi
