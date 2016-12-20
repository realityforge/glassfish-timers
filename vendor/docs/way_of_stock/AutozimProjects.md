# Autozim Branches

Autozim is a feature that will attempt to automatically update dependencies of downstream projects when a
project successfully builds the master branch. i.e. If autozim-enabled project `prj-a` publishes artifacts
`prj-a-db` and `prj-a-model` used by downstream project `prj-b` and `prj-a` successfully builds the master
branch then it will initiate a "Zim" process to update the dependencies in `prj-b`.

The [Zim](Zim.md) process happens in an [Automerge Branches](AutomergeBranches.md) named using the group
name of the source project such as `AM_update_com.example.prja`. If this branch successfully builds then
it will be automatically merged into master.

This is extremely useful to ensure all the projects are updated to the latest version of all the dependencies.
It also helps catch integration problems early. However it does require that our projects improve the level
of test coverage over time to ensure that problems are caught early. Another downside is that a simple commit
to a low-level library can cause a cascade of builds. This will be less of an issue over time as more effective
build prioritization of jobs is enabled on our build server(s).

## How to enable?

What do you need to get Autozim projects working? The project must build on a jenkins server that supports
[Automerge Branches](AutomergeBranches.md). The project must either explicitly enable autozim via adding a
line such as `BuildrPlus::Jenkins.auto_zim = true` to the `buildfile` or be marked as a library. (i.e. Must
depend on `buildr_plus` library project template or have a line such as `BuildrPlus::Dbt.library = true` in
the `buildfile`.)

It should also be notes that zim is only configured to run on projects if all the build processes share the
same artifact repository. Some projects build internally on jenkins and externally on travisci and do NOT
share an artifact repository. These projects are not yet supported as targets of autozim-ming.

## How is it implemented?

Essentially `buildr_plus` generates some code that is placed in `Jenkinsfile` and `.jenkins/main.groovy`
that checks the name of the branch and if it is an `master` branch then triggers a zim job on successful
completion of the build. The zim passes in all the artifacts to update and the target version to update to.
You can look at the generated jenkins configuration to understand the nuts-and-bolts. The jenkins server
is pre-configured with the zim job.
