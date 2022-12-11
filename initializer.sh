#!/usr/bin/env bash

source properties.txt

cat > expath-pkg.xml << EOL
<package name="$name">
this is a package element
</package>
EOL

echo "Hi mom!"
