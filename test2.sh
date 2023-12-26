#!/bin/bash
mkdir cloneRepos
folder_to_cleanup="cloneRepos"

#if [ -d "$folder_to_cleanup" ]
#then
#    echo "cleaning up folder $folder_to_cleanup"
#    rm -rf "$folder_to_cleanup"
#else
#    echo "$folder_to_cleanup does not exist."
#fi

cd cloneRepos
echo "in script file"
#github_url="https://github.com/Harishk9697/robotframework-test-suite.git"
#echo $github_url
git clone https://github.com/Harishk9697/robotframework-test-suite.git
#repo_basename=$(basename "$github_url")
echo $HELLO
ls
robot --outputdir /report robotframework-test-suite/About.robot

if [ $? -ne 0 ]; then
    echo "Command robot execution failed"
    aws s3 cp /report s3://tf-rf-scripts-spe-qaqc-bucket/RobotFrameworkReport/ && echo "Copied report to s3 bucket" || echo "Copying report to s3 bucket failed"
else
    echo "Command robot execution passed"
    aws s3 cp /report s3://tf-rf-scripts-spe-qaqc-bucket/RobotFrameworkReport/ && echo "Copied report to s3 bucket" || echo "Copying report to s3 bucket failed"
fi
