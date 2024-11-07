echo "**Recommend renaming the parent folder from 'git-tracked-analysis-template' to something unique and informative!**"
rm -rf .git
git init
git add ./* .gitignore
git reset ./re-init.sh
git reset ./README.md
git commit -m "first commit"

echo "#########"
echo "To sync up a local git directory, with this one (assuming ssh access), do this:"
echo "git clone ssh://$(whoami)@$(hostname):$(pwd)"
echo "git config receive.denyCurrentBranch ignore"
echo "git reset --hard"
echo "#########"

rm -f ./README.md
rm -f ./re-init.sh &

