# Greenmail

[Greenmail](http://www.icegreen.com/greenmail/) is an open source suite of email servers supporting SMTP, POP3 and IMAP.
Any email sent to Greenmail will not go any further, but is stored locally for retrieval via these protocols.
There is no web interface, so it is necessary to use a mail client like [Thunderbird](https://www.mozilla.org/en-US/thunderbird/).

Every time Greenmail receives an email via SMTP, it creates a new email account with the email address as username and password.
Email is not persisted to permanent storage, so every time the server is restarted all email will be discarded.

By default, Greenmail is set up to use the normal ports plus 10000.

    SMTP: 10025
    POP3: 10110
    IMAP: 10143

## Testing

The Guiceyloops test framework, used by most projects, allows tests to start a Greenmail server to capture emails being sent.
This is done by extending AbstractServerTest and overriding enableMailServer() to return true.  This method returns false by default.

      protected boolean enableMailServer() {
        return true;
      }

The build.yaml file defines the following dependency for use by Guiceyloops:

      greenmail: com.icegreen:greenmail:jar:1.4.1

## Development

In development, Greenmail may be used to capture outgoing mail.

The build.yaml file defines the following dependency to start a Greenmail server:

      greenmail_server: com.icegreen:greenmail-webapp:war:1.4.1

The buildfile requires the following to deploy Greenmail when running through Idea (the :packaged attribute does the work).

      ipr.add_glassfish_configuration(project,
                                      :server_name => 'Payara 4.1',
                                      :exploded => [project.name],
                                      :packaged => {:greenmail => :greenmail_server})

## Thunderbird

A mail client is required to retrieve emails sent to Greenmail.  Mozilla Thunderbird is recommended as it is free, self-contained and available for all platforms, but any mail client will work using the same POP3 settings.

To add a new mail account (in v38.3.0 for Ubuntu 14.04):

1. Menu: Edit | Account Settings
2. Account Actions | Add Mail Account
3. Fill in the following: Your name = irrelevant, Email address = <email_address>, Password = <email_address>
4. Continue
5. Manual Config (Thunderbird will attempt to determine the email provider from the address and fail miserably).
6. Incoming: Type = POP3, Server hostname = localhost, Port = 10110, SSL = None, Authentication = Normal password
7. Outgoing: SMTP, Server hostname = localhost, Port = 10025, SSL = None, Authentication = No authentication (it won't be necessary to send any emails from this account but Thunderbird requires settings to be included)
8. Username: <email_address>
9. Re-test.  This will only succeed if you have a running instance of Greenmail and have sent an email to that address to create the account.  Remember emails and accounts are only kept in memory so server restarts will clear them.
