
#!/bin/sh

echo "Add files and do local commit"
git add .
echo "checking status"
git status
git commit -am "Adding S3 script to store terraform state in (remote backend) and provide state locking with DynamoDB, and also github actions role scripts to the repository"
echo "Pushing to Github Repository"
git push -u origin master
