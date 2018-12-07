# NodeJS

NodeJS is a javascript environment for the server and command line. We primarily use it to run
tooling. We use [`nodenv`](https://github.com/nodenv/nodenv) a node version manager, to manage the
node versions used by each project.

To install node we first install `nodenv` then issue commands to `nodenv` to install the correct
versions of node.

Node and `nodenv` are required by a project when there exists a file named `.node-version` in the
base directory of the project.

## Installing nodenv

You need to run:

    $ git clone https://github.com/nodenv/nodenv.git ~/.nodenv
    $ git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build

Optionally, try to compile dynamic bash extension to speed up `nodenv`. Don't worry if it fails; `nodenv`
will still work normally:

    $ cd ~/.nodenv && src/configure && make -C src

Add `~/.nodenv/bin` to your `$PATH` for access to the `nodenv` command-line utility.

    $ echo 'export PATH="$HOME/.nodenv/bin:$PATH"' >> ~/.bashrc
    $ echo 'eval "$(nodenv init -)"' >> ~/.bashrc

## Installing NodeJS

Most projects use _v6.10.3_, the latest LTS version of node. The version of node used by a project can be
determined by reading the contents of the `.node-version` in the base directory of the project. Replace
_v6.10.3_ in the following instructions with the version that the project actually uses.

To install node, it is as simple as:

    $ nodenv install 6.10.3

## Yarn

[NPM](https://npmjs.org/) or the _N_ode _P_ackage _M_anager, is the base package management tool
included within the Node installation. However we have decided to use [Yarn](https://yarnpkg.com/en/)
as it is faster and has more deterministic behaviour but still uses the repositories and package formats,
and local filesystem layout of NPM. Yarn has roughly equivalent behaviour to Bundler in the ruby ecosystem
(and also has authors in common). It is also the tool promoted by Facebook and Google (as well as many
other companies with a focus on speed and reliability).

For a list of useful yarn commands see the [usage](https://yarnpkg.com/en/docs/usage) documentation and if
you already know node/NPM then see the [migrating from node](https://yarnpkg.com/lang/en/docs/migrating-from-npm/)
documentation.

Yarn can install packages globally or locally and we prefer local packages where possible as it means different
projects can have different versions of tools. For local package installation Yarn requires a file `package.json`
to declare the dependencies and will install them into a local cache `./node_modules`.

### Installing Yarn

The documentation for installing yarn is reasonably comprehensive. See the
[documentation](https://yarnpkg.com/en/docs/install) for full details. However the easiest way to install yarn
is to install it as a global npm package.

    $ npm install -g yarn
    $ nodenv rehash

### Global package installation

Installing packages globally is not recommended and deprecated within our projects. However some projects still
make use of this feature. Installing globally  avoids the need to define define node specific metadata (i.e.
`package.json`, `yarn.lock` and `node_modules/*`) in the project. However if you have to add a tool globally you
need to run `nodenv rehash` to ensure that `nodenv` links the bin into the list of shims made available on
the shell.

An example of how to install Less.js a CSS preprocessor that we have used is:

    $ yarn global add less
    $ yarn global add less-plugin-clean-css
    $ nodenv rehash

### Dependency Versioning policy

Most of the time we prefer to use exact versions when we declare dependencies for a project to ensure we
are getting the dependency that we have tested with. For `yarn` this means passing the `-E` flag when adding
the dependency such as:

    $ yarn add react@15.5.4 -E

This results in a version in `package.json` without any qualifier (i.e. no `^` or any other version prefix).
The `package.json` would look something like:

    {
      ...,
      "dependencies": {
        "react": "15.5.4",
        ...
      }
    }
