# Manage Jenkins

## SSH to Jenkins

    $ ssh ci

Depends on having the following in ~/.ssh/config:

    Host ci
        HostName ci.stocksoftware.com.au
        User ubuntu
        IdentityFile ~/.ssh/ss-aws.pem
        ServerAliveInterval 60

## Jenkins status

### Check status

    $ sudo service jenkins status

### Restart Jenkins

    $ sudo service jenkins restart

### Stop Jenkins

    $ sudo service jenkins stop

### Start Jenkins

    $ sudo service jenkins start
