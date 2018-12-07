# Braid

[Braid](http://cristibalan.github.io/braid/) is a simple tool to help track vendor branches in a
[Git](http://git-scm.com/) repository. That costs and benefits of vendoring in an external library
rather than referencing an external library is well documented on the [Braid](http://cristibalan.github.io/braid/)
website. We use it to vendor in external repositories such as dbt, domgen, rptman as well as documentation
repositories like this repository. A project uses braid if it has a file named `.braids.json` in the root directory.

For an existing project you can braid in a new project with a command similar to:

    $ braid add https://github.com/stocksoftware/way_of_stock.git vendor/docs/way_of_stock

To update a repository that is already braided in use:

    $ braid update vendor/docs/way_of_stock

## Working with external repositories

Local changes can be made made as usual to the braided in repository. Commit the changes locally. Most changes
should aim to be pushed back to the source repository. There are three basic mechanisms for doing this.

### Repositories you can push to master

For repositories that you have direct access to you can just push the changes directly like;

    $ braid push vendor/docs/way_of_stock

### Realityforge repositories

For `realityforge` repositories you should request to be a collaborator on the repository. This involves asking
`@realityforge` for collaboration access, then waiting for `@realityforge` to granted it and then accepting access
in your github settings page. You will be able to create new branches in these repositories but you will not be able
to push to master without getting the changes reviewed. To push changes to this repository you first push to a new
branch in the repository and then go to the GitHub web interface and create a pull request (This process will
likely be streamlined in the future so that it cann all be done from the commandline). Then `@realityforge` will review
the change and merge it to master. To push local changes to a new branch `MyNewFeature` use;

    $ braid push vendor/tools/domgen --branch MyNewFeature

After the new branch has been merged into master, it is simply a matter of issuing another
`braid update` command to update the local braid. It is recommended that this is done immediately to avoid merge problems
down the track.

### Other repositories

Pushing changes back to third party repositories is a little more complex. These repositories typically require
changes to conform to the "GitHub way" and require a pull request to get changes into the upstream repository.

The first step is to fork the source repository into you own account on GitHub and check out the fork to your local
filesystem. In the checked out version of the project you need to add a new remote that references the upstream
project. For domgen you would execute a command such as:

    $ git remote add upstream https://github.com/realityforge/domgen.git

Each time you want to generate a pull request you have to make sure your local master is up to date with the upstream
master using the following commands:

    $ git fetch upstream
    $ git checkout master
    $ git reset --hard upstream/master
    $ git push master

If you have ever made changes directly on master, you may need to force push the branch to reset master to the
upstream. Any local changes to master will be lost. This can be done via:

    $ git push -f master

Then you need to create a local branch from master that includes the changes you want to merge into the upstream
repository via:

    $ git checkout -b my_domgen_enhancements

Then apply the changes as per usual:

    $ git apply patch.diff
    $ git add .
    $ git commit -m "Added wonderful stuff"
    $ git push --set-upstream origin my_domgen_enhancements

And then generate a pull request and work to getting it merged. This can be done through the GitHub website or can
be done by using the hub command:

    $ hub pull-request
