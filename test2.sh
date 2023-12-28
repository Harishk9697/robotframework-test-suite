#!/bin/bash
folder_to_cleanup="cloneRepos"

if [ -d "$folder_to_cleanup" ]
then
    echo "cleaning up folder $folder_to_cleanup"
    rm -rf "$folder_to_cleanup"
    mkdir cloneRepos
else
    echo "$folder_to_cleanup does not exist."
    mkdir cloneRepos
fi

cd cloneRepos

report_folder_to_cleanup="report"
if [ -d "$report_folder_to_cleanup" ]
then
    echo "cleaning up folder $report_folder_to_cleanup"
    rm -rf "$report_folder_to_cleanup"
    mkdir report
else
    echo "$report_folder_to_cleanup does not exist."
    mkdir report
fi

echo "in script file"
#github_url="https://github.com/Harishk9697/robotframework-test-suite.git"
#echo $github_url
aws s3 cp --acl bucket-owner-full-control --recursive s3://tf-rf-scripts-spe-qaqc-bucket/JeopardyTestCase/JEOPARDY/ . && echo "Copied test cases from s3 bucket" || echo "Copying test cases from s3 bucket failed"
#git clone https://github.com/Harishk9697/robotframework-test-suite.git
#repo_basename=$(basename "$github_url")
echo $HELLO

ls
robot --outputdir /cloneRepos/report .

if [ $? -ne 0 ]; then
    echo "Command robot execution failed"
    aws s3 cp --acl bucket-owner-full-control --recursive /cloneRepos/report s3://tf-rf-scripts-spe-qaqc-bucket/RobotFrameworkReport/ && echo "Copied report to s3 bucket" || echo "Copying report to s3 bucket failed"
else
    echo "Command robot execution passed"
    aws s3 cp --acl bucket-owner-full-control --recursive /cloneRepos/report s3://tf-rf-scripts-spe-qaqc-bucket/RobotFrameworkReport/ && echo "Copied report to s3 bucket" || echo "Copying report to s3 bucket failed"
fi
