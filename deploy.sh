#!/data/data/com.termux/files/usr/bin/bash

┌───────────────────────────────────────────┐

│ OmniMetaSystem GitHub PWA Deploy (Termux)│

└───────────────────────────────────────────┘

GITHUB_USER="shroomtop" GITHUB_EMAIL="onesilentflame@gmail.com" REPO_NAME="omnimeta-pwa" REPO_URL="git@github.com:$GITHUB_USER/$REPO_NAME.git" KEY_PATH="$HOME/.ssh/id_ed25519"

1. Git Config

printf "\n==> Configuring Git Identity...\n" git config --global user.name "$GITHUB_USER" git config --global user.email "$GITHUB_EMAIL"

echo "==> Marking repo safe..." git config --global --add safe.directory "$PWD"

2. SSH Key Check

if [ ! -f "$KEY_PATH" ]; then echo "==> Generating SSH key..." ssh-keygen -t ed25519 -f "$KEY_PATH" -C "$GITHUB_EMAIL" -N "" else echo "==> SSH key already exists: $KEY_PATH" fi

3. Show Public Key

echo "\n==> Add this SSH key to GitHub (once):" cat "$KEY_PATH.pub" echo "\nGo to: https://github.com/settings/keys" read -p "Press Enter when you've added the key to GitHub..."

4. Git Remote + Push

if ! git remote | grep -q origin; then echo "==> Adding remote origin..." git remote add origin "$REPO_URL" fi

echo "==> Initializing + committing + pushing..." git init git add . git commit -m "Initial deploy from Termux" git branch -M main git push -u origin main

5. GitHub Pages Reminder

echo "\n==> FINAL STEP:" echo "Go to https://github.com/$GITHUB_USER/$REPO_NAME/settings/pages" echo "Set Source to: main branch, /(root) folder -> Save" echo "Live PWA: https://$GITHUB_USER.github.io/$REPO_NAME"


