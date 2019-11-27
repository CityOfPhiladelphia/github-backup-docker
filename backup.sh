#!/bin/bash
set -eE
trap slack_failure ERR

slack_failure () {
  curl -X POST -H 'Content-type: application/json' --data '{"text":"Github Backup Failed"}' $SLACK_WEBHOOK_URL
}

slack_success () {
  curl -X POST -H 'Content-type: application/json' --data '{"text":"Github Backup Complete"}' $SLACK_WEBHOOK_URL
}

echo "backing up"
github-backup $GITHUB_ORGANIZATION --token $GITHUB_ACCESS_TOKEN --organization -o . --repositories -i
echo "done backing up"
# Take bucket path as env. variable

echo "syncing to s3"
aws s3 sync . s3://${BACKUP_S3_BUCKET} --region us-east-1
echo "s3 sync complete"

slack_success