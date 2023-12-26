#!/bin/bash
mkdir cloneRepos
folder_to_cleanup="cloneRepos"

if [ -d "$folder_to_cleanup" ]
then
    echo "cleaning up folder $folder_to_cleanup"
    rm -rf "$folder_to_cleanup"
else
    echo "$folder_to_cleanup does not exist."
fi

cd cloneRepos
echo "in script file"
#github_url="https://github.com/Harishk9697/robotframework-test-suite.git"
#echo $github_url
git clone https://github.com/Harishk9697/robotframework-test-suite.git
#repo_basename=$(basename "$github_url")
echo $HELLO
ls
robot --outputdir /report robotframework-test-suite/About.robot
