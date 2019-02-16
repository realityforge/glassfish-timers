# Setup Keycloak to run locally in docker

## Overview

You need docker installed first.

This process will start an instance running keycloak, with an admin user with password 'admin'.
A realm will be created 

## Setup Instructions

    $ docker run --name keycloak -p 8880:8080 -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=admin jboss/keycloak:2.5.1.Final &
  
You can stop start the container with the normal instructions:

    $ docker stop/start keycloak

## Admin console

Once the container is running you will be able to access it at

    http://localhost:8880

## Realm setup

A realm must be created to contain your clients. This will need to be done every time you destroy/recreate the container,
but will survive a stop/start of the container.

You can either just use the 'master' realm that is set up by default, or you can create a new one.
If you choose to create one then it's usually easiest to just do this via the admin console.

## Environment configuration

Our development environment has a number of environment variables which need to be set to properly point at the container:

    KEYCLOAK_AUTH_SERVER_URL=http://localhost:8880/auth
    KEYCLOAK_ADMIN_USERNAME=admin
    KEYCLOAK_ADMIN_PASSWORD=admin
    KEYCLOAK_REALM=master      <-- if you created your own realm then set this appropriately
    KEYCLOAK_REALM_PUBLIC_KEY=[get this from the admin console, under 'keys' | RSA | 'Public Key']

## Creating clients

Clients are created from within each project. Make sure your environment vars are set properly (above):
    
    $ bundle exec buildr keycloak:create

## User management

The default realm uses a local store of users for authentication.

You can add users via the admin console or via the command line:

    $ docker exec keycloak keycloak/bin/add-user-keycloak.sh -u <USERNAME> -p <PASSWORD>
    $ docker restart keycloak

Note that the command line mechanism does not set the firstname/surname/etc attributes. These will have to be set via the admin console.

Creation of users in the non-default realm must be done from the admin console.

## Group management

Some of our applications use Groups to determine the allowed functionality for individual users.
The default setup does not contain any groups, nor map any groups to users.

### Creating groups

Group creation is done through the admin screen, in the realm of your choosing, under the 'Groups' menu item.
Usually there is no need to add any information to the created group (other than its name). 

### Assigning groups

Groups can be assigned to users through the admin screen, by finding the user and navigating to their 'Groups' tab.


