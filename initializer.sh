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
<project default="all" name="$name">
  <description>$description</description>
  <xmlproperty file="expath-pkg.xml" />
  <property name="project.version" value="\${package(version)}" />
  <property name="project.app" value="$name" />
  <property name="build.dir" value="build" />
  <!-- Start it -->
  <target name="init" description="create build directory">
    <tstamp />
    <mkdir dir="\${build.dir}" />
  </target>
  <!-- Release build -->
  <target name="deploy" depends="init" description="compile release build">
    <zip basedir="." destfile="\${build.dir}/\${project.app}-\${project.version}.xar" excludes="**/\${build.dir}/**" />
  </target>
  <target name="all" depends="deploy">
    <tstamp />
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