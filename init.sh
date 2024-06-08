#!/usr/bin/env bash

set -e

# Ensure that the gpg command can be executed
which gpg

# Generate default key
gpg --full-generate-key

gpg --list-secret-keys --keyid-format=long

key=$(gpg --list-secret-keys --keyid-format=long | tail -n 5 | head -n 1 | xargs | awk -F'[/ ]' '{print $3}')

git config --global user.signingkey $key
git config --global commit.gpgsign true

echo "GPG key"
gpg --armor --export $key

echo "Export GPG_TTY"
[ -f ~/.bashrc ] && echo -e '\nexport GPG_TTY=$(tty)' >> ~/.bashrc

echo
echo "Add the GPG key to your GitHub account"
echo
echo "1. Go to GitHub Settings"
echo "2. Click SSH and GPG Keys"
echo "3. Click New GPG key"
echo "4. Copy your GPG key beginning with ---BEGIN PGP PUBLIC KEY BLOCK--- and ending with ---END PGP PUBLIC KEY BLOCK---"
echo
echo "Done!"