# AWS

We use the Amazon Web Services for the provision of a number of servers, for our clients outside Vic Gov.
AWS has a nice web site, but you can also use scripts to manage the servers there.

## Setup for using awsweasel

* You need an account in our AWS account.  See Ian or James for one of these.
* Your account has to have an Access Key
    * Ian/James go to 'Security Credentials', 'Users'
Select the User, and 'Create Access Key'
Download the file, and save it - you can't get the details again, you have to create a new access key

* Create a ~/.aws/credentials file, using the contents of your downloaded access key
```
[default]
aws_access_key_id = your_key_here
aws_secret_access_key = your_secret_here
```

* Define the AWS region you plan to use
```
    $ export AWS_REGION=ap-southeast-1
```
    * You might want to put this into ~/.bash.d/aws.sh

See the head of the aws-infrastructure/awsweasel.rb file for example commands

## Bootstrap a server

An example so we don't lose it
```
bundle exec knife bootstrap 52.62.5.108 --node-name actpcsuat.irisonline.com.au -r 'recipe[ss-node-actpcs-iris]' --sudo
  --environment actpcs_uat --ssh-port 22 --ssh-user ubuntu -i ~/.ssh/aws.pem --bootstrap-version 11.18.6
```

## More info

Lots of stuff here: http://docs.aws.amazon.com/sdk-for-ruby/latest/DeveloperGuide/aws-sdk-ruby-dg.pdf
