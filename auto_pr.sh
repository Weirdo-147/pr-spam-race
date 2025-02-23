#!/bin/bash

REPO_DIR="/workspaces/pr-spam-race"
BRANCH_PREFIX="pr-bot-"
FILENAME="botfile.txt"

cd $REPO_DIR || exit

while true; do
    TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
    BRANCH_NAME="${BRANCH_PREFIX}${TIMESTAMP}"

    # Create a new branch
    git checkout -b "$BRANCH_NAME"

    # Modify the file (or create it)
    echo "PR created at $TIMESTAMP" >> "$FILENAME"

    # Stage, commit, and push changes
    git add "$FILENAME"
    git commit -m "Auto PR - $TIMESTAMP"
    git push origin "$BRANCH_NAME"

    # Create a Pull Request using GitHub CLI
    gh pr create --title "Automated PR - $TIMESTAMP" --body "This is an automated pull request." --base main --head "$BRANCH_NAME"

    echo "✅ PR Created: $BRANCH_NAME"

    # Delay (set to 10s for safety)
    sleep 1
done
