echo "These files are still actual symlinks:"
find . -type l
echo "These files are broken symlinks:"
find . -type l ! -exec test -e {} \; -print ## https://unix.stackexchange.com/questions/34248/how-can-i-find-broken-symlinks

LATEST_TAG=$(git describe --tags --abbrev=0)
ZIPNAME="${PWD##*/}.zip" ## Trick from https://stackoverflow.com/questions/1371261/get-current-directory-or-folder-name-without-the-full-path
echo "Now git archiving to ${ZIPNAME} in the parent directory..."
#git archive --format=zip --output "../${ZIPNAME}" main
git-archive-all "../${ZIPNAME}" ## conda install -y git-archive-all
echo "Latest git tag is ${LATEST_TAG}"
openssl md5 "../${ZIPNAME}"

## The .zip archive created by git is only a snapshot, it doesn't include version history.
## Datalad also doesn't have a great solution to the export git + git-annex type content, see here for details:
## https://handbook.datalad.org/en/latest/basics/101-139-figshare.html
BUNDLENAME="${PWD##*/}.git.bundle.pack" ## Trick from https://stackoverflow.com/questions/1371261/get-current-directory-or-folder-name-without-the-full-path
echo "Now git bundling to ${BUNDLENAME} in the parent directory..."
git bundle create "../$BUNDLENAME" main
openssl md5 "../$BUNDLENAME"


