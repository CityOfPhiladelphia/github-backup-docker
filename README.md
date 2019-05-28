# Dockerized github backup script
A docker container to run https://github.com/josegonzalez/python-github-backup and back up the results to a specified s3 bucket. It's recommended to run this nightly via AWS Fargate (or some other container task scheduler)

1. `docker build -t github-backup .`
1. To run locally: 

`docker run -e AWS_SECRET_ACCESS_KEY -e AWS_ACCESS_KEY_ID -e AWS_SECURITY_TOKEN -e GITHUB_ORGANIZATION -e GITHUB_ACCESS_TOKEN -e BACKUP_S3_BUCKET -e SLACK_WEBHOOK_URL github-backup

## Pushing to ECR
This project is designed to run on fargate... Your built container should be tagged and pushed to ECR prior to executing in fargate

## Environment Variables

Run the container with the following environment variables: 

GITHUB_ORGANIZATION: The github org you wish to back up
GITHUB_ACCESS_TOKEN: A github developer access token
BACKUP_S3_BUCKET: The bucket you wish to access
SLACK_WEBHOOK_URL: Slack url to send notifications to

## Github Configation
1. You'll need to create a personal access token with at least read access on all of your organization's repositories. 

## AWS Configuration
This is designed to be run as a recurring task in fargate. Create a fargate cluster along with a scheduled task. Be sure to set all of the environment variables above. 
