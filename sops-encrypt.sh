#!/bin/bash

echo "Encrypting with sops..."
find . -type f \( -name ".env" -o -name ".env.*" -o -name "*.env" -o -name "*.env.*" \) | while read -r file; do
    if grep -q '"sops":' "$file" || grep -q '^sops' "$file"; then
        echo "Skipping $file..."
        continue
    fi
    echo "Encrypting $file..."
    SOPS_AGE_KEY_FILE=$HOME/.age/age.key sops encrypt -i $file
done
echo "Done"
