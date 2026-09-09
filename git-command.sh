
#!/bin/sh

echo "Add files and do local commit"
git add .
echo "checking status"
git status
git commit -am "Updating github-actions-role trust relationships and permissions"
echo "Pushing to Github Repository"
git push -u origin master
