# Automerge Branches

Automerge branches are designed to allow a developer to push some changes into a branch and if the changes pass
all tests on the build server, have the branch merged into master. This will mean small changes can be made
and will only be merged into master if they pass all tests. This is useful when upgrading dependencies or build
infrastructure such as domgen etc. It minimizes developer workload while maximizing safety of only having
changes that pass tests in master.

Automerge branches are triggered when the developer creates a branch with a name prefixed with `AM_`. These
Jenkins server has a different build process for these branches. First the `master` branch is merged into
the `AM_` branch and then the build is run as normal. If the build is successful and no changes have been
made to either the `master` or the `AM_` branch since the build started then the `AM_` branch will be merged
into `master` and deleted from the git repository. If changes have been made to the `AM_` branch then it
is assumed a future build will attempt to automerge the changes. If changes have been made on `master`
then these changes are merged into the `AM_` branch and pushed to the git repository, thus triggering another
build.

However sometimes you do not wish to merge into master in which case you can use an alternative syntax and
prefix branch with `AM-mybranch_` in which case the automerge infrastructure will attempt to automatically
merge changes into the branch `mybranch`.

## How to enable?

What do you need to get Automerge branches working? A modern version of `buildr_plus` with the `:jenkins`
feature enabled in the `buildfile` and a jenkins server configured to use `Jenkinsfile` to build projects.
Many projects will already have this enabled?

## How is it implemented?

Essentially `buildr_plus` generates some code that is placed in `Jenkinsfile` that checks the name of the
branch and if it is an automerge branch then performs different behaviour. You can look at the generated
jenkins configuration to understand the nuts-and-bolts. The jenkins server then automatically detects the
presence of the `Jenkinsfile` and runs the build appropriately.
