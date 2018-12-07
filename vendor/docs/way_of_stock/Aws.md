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

## Getting a Database Backup

For a complete description of how to do this with screenshots go here:
[Amazon RDS Creating a native Backup](http://www.sqlmatters.com/Articles/Amazon%20RDS%20Creating%20a%20native%20bak%20Backup%20of%20a%20SQL%20Server%20Database%20in%20RDS.aspx)

#### 1 Create an S3 storage bucket

This is where your backup will be stored.  Go to Services -> S3 and create one.

#### 2 Create an Option Group

Under RDS -> Options Groups create a new Option Group.  Give it a description like 'Allow native backups to S3'. 
The Engine is sqlserver-ex and the Major Engine version is 12.00.

#### 3 Add Backup and Restore Option to Option Group

Once the Option Group has been created click Add Option and select SQLSERVER_BACKUP_RESTORE from the drop down.
Make sure 'Apply Immediately' is set to 'Yes'.

You’ll also need to create an IAM role to link to your S3 bucket, by clicking the ‘Create a New Role’ hyperlink. 
Once you’ve done this, if you don’t already have an S3 bucket then you can create one by clicking the ‘Create a New S3 Bucket’ hyperlink

The final step is to change the option group for the RDS instance from the default one to the one we’ve just created. 
To do this go to the ‘Instances’ menu item, select the relevant RDS instance, then click the ‘Modify’ link under ‘Instance Actions’ 
drop down. Scroll down until you see the ‘Database Options’ area. Change the Option Group to whatever you called it and 
make sure you click the ‘Apply Immediately’ checkbox.

#### 4 Create the Backup

Run a special stored procedure to back up the RDS database to the S3 storage bucket.

````sql
exec msdb.dbo.rds_backup_database 
@source_db_name='IRIS_3',
@s3_arn_to_backup_to='arn:aws:s3:::stocksoftware-database-backups/CFS/cfstest.bak',
@overwrite_S3_backup_file=1;
````

Check progress by running this:-

````sql
exec msdb.dbo.rds_task_status @db_name='IRIS_3'
````

#### 5 Download the Backup

Click on the .bak file in the S3 storage bucket you've stipulated and Download.

## More info

Lots of stuff here: [aws-sdk-ruby-dg.pdf](http://docs.aws.amazon.com/sdk-for-ruby/latest/DeveloperGuide/aws-sdk-ruby-dg.pdf)
