#!/bin/bash

# CONFIGURATION
REPO_NAME="fake-activity-2024-lite"
START_DATE="2024-01-01"
END_DATE="2024-12-31"
MAX_COMMITS_PER_DAY=4
FILL_RATIO=80  # percent of days to fill

# Convert date to timestamp
date_to_timestamp() {
  date -d "$1" +%s
}

# Create repo
mkdir $REPO_NAME
cd $REPO_NAME
git init
touch README.md
git add README.md
git commit -m "Initial commit"

START_TS=$(date_to_timestamp $START_DATE)
END_TS=$(date_to_timestamp $END_DATE)

# Loop through each day of 2024
CURRENT_TS=$START_TS
while [ "$CURRENT_TS" -le "$END_TS" ]; do
  CURRENT_DATE=$(date -d "@$CURRENT_TS" +%Y-%m-%d)

  # Randomly decide whether to fill this day
  CHANCE=$((RANDOM % 100))
  if [ "$CHANCE" -lt "$FILL_RATIO" ]; then
    COMMITS=$((RANDOM % MAX_COMMITS_PER_DAY + 1))
    for i in $(seq 1 $COMMITS); do
      echo "Commit $i on $CURRENT_DATE" >> fake2024.log
      git add .
      GIT_AUTHOR_DATE="$CURRENT_DATE 12:00:00" GIT_COMMITTER_DATE="$CURRENT_DATE 12:00:00" git commit -m "Fake commit $i on $CURRENT_DATE"
    done
  fi

  # Move to next day
  CURRENT_TS=$((CURRENT_TS + 86400))
done

echo "✅ All done! Now push to GitHub:"
echo "   git remote add origin https://github.com/YOUR_USERNAME/$REPO_NAME.git"
echo "   git push -u origin main"
