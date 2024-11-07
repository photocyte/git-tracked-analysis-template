echo "**Recommend renaming the parent folder from 'git-tracked-analysis-template' to something unique and informative!**"
rm -rf .git
git init
git add ./*
git rm --no-cached re-init.sh
git commit -m "first commit"

