#!/bin/bash

echo "Encrypting with sops..."
find . -type f \( -name ".env" -o -name ".env.*" -o -name "*.env" -o -name "*.env.*" \) | while read -r file; do
    if grep -q '"sops":' "$file" || grep -q '^sops' "$file"; then
        echo "Skipping $file..."
        continue
    fi
    echo "Encrypting $file..."
    sops encrypt -i $file
done
echo "Done"
