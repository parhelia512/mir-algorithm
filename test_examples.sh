#!/bin/bash

set -euo pipefail

dub fetch dtools

# extract examples
dub run dtools:tests_extractor -- -i source -o out

git clone https://github.com/libmir/mir-core

# compile the examples
for file in $(find out -name "*.d") ; do
    echo "Testing: $file"
    $DMD -unittest -Isource -Imir-core/source -preview=dip1008 -c -o- "$file"
done
