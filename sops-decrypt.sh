#!/bin/bash

find . -type f \( -name ".env" -o -name ".env.*" -o -name "*.env" -o -name "*.env.*" \) | while read -r file; do
    if grep -q '"sops":' "$file" || grep -q '^sops' "$file"; then
        echo "Decrypting $file..."
        sops decrypt -i $file
    fi
done
echo "Done"
