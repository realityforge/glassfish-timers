# Rptman

[Rptman](https://github.com/realityforge/rptman) is a library we use for managing SSRS reports. The main
website can be referenced for basic operation. However we typically integrate it into our projects using
[BuildrPlus](BuildrPlus.md). It is sufficient to braid the library in and add it to the `Gemfile`. i.e.

    $ braid add https://github.com/realityforge/rptman.git vendor/tools/rptman

And then add the following line to the `Gemfile`:

    gem 'buildr_plus', '= 1.0.0', :path => 'vendor/tools/buildr_plus'

Assuming [BuildrPlus](BuildrPlus.md) is present then it will define a data source for the `:default`
database that matches root project name. You may still need to define custome data sources in `buildfile`
via:

    require 'rptman'

    SSRS::Config.define_datasource('SAMS','sams')

[BuildrPlus](BuildrPlus.md) will also define the following tasks if there exists a file
`config/ci-report-database.yml`.

    $ buildr rptman:download_production_environment

Downloads reports form production to local drive. Useful if you need to try and find out what changes
have been made to production without also being checked into source control.

    $ buildr rptman:upload_to_production_environment

Uploads reports (but not data sources) to production. Useful until we can correctly automate reports
as part of our release process.
