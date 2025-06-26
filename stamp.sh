USERNAME="haretazouzou"
EMAIL="haretazouzou@gmail.com"  # Change this to your Git email

for i in {1..10}; do
  # Random date in 2024
  MONTH=$(printf "%02d" $((RANDOM % 12 + 1)))
  DAY=$(printf "%02d" $((RANDOM % 28 + 1)))
  HOUR=$(printf "%02d" $((RANDOM % 24)))
  MIN=$(printf "%02d" $((RANDOM % 60)))
  SEC=$(printf "%02d" $((RANDOM % 60)))

  DATE="2024-$MONTH-$DAY $HOUR:$MIN:$SEC"

  export GIT_AUTHOR_DATE="$DATE"
  export GIT_COMMITTER_DATE="$DATE"
  export GIT_AUTHOR_NAME="$USERNAME"
  export GIT_COMMITTER_NAME="$USERNAME"
  export GIT_AUTHOR_EMAIL="$EMAIL"
  export GIT_COMMITTER_EMAIL="$EMAIL"

  echo "📁 Fake commit on $DATE" >> timestamp-log.txt
  git add timestamp-log.txt
  git commit -m "Backdated commit on $DATE"
done
