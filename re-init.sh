echo "**Recommend renaming the parent folder from 'git-tracked-analysis-template' to something unique and informative!**"
rm -rf .git
git init
git add ./* .gitignore
git reset ./re-init.sh
git reset ./README.md
git commit -m "first commit"
rm -f ./README.md
rm -f ./re-init.sh &
