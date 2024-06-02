#!/bin/sh

# Check if tlmgr is installed
if ! command -v tlmgr &> /dev/null
then
    echo "tlmgr could not be found. Please ensure TeX Live is installed."
    exit
fi

# Read package names from packages.txt and install each one
while IFS= read -r package
do
    echo "Installing $package..."
    sudo tlmgr install "$package"
done < packages.txt

echo "All packages installed."
