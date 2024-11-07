echo "**Recommend renaming the parent folder from 'git-tracked-analysis-template' to something unique and informative!**"
rm -rf .git
git init
git add ./* .gitignore
git reset ./re-init.sh
git commit -m "first commit"
rm -f ./re-init.sh &
