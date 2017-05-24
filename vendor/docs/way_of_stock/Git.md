# Setup Git

## Install Git

Git is likely already installed but if not, it will need to be installed.

### OSX Instructions

Under OSX with [Homebrew](Homebrew.md) installed you can install via;

    $ brew update
    $ brew install git

### Linux Instructions

To install under linux we install the package via;

    $ sudo apt-get install git git-gui

## Configuring Basic Settings

The first thing you should do when you install Git is to set your user name and email address. This is important
because every Git commit uses this information, and it’s immutably baked into the commits you start creating:

    $ git config --global user.name "My Name"
    $ git config --global user.email myname@example.com

Our projects also rely on `.giattributes` files controlling the EOL style for files. i.e. CRLF for windows `.bat`
files, LF for almost all other source files. To make sure this works you need to disable auto conversion of EOLs
via:

    $ git config --global core.autocrlf false

You can verify the settings are correctly set by listing the values using the command:

    $ git config --global -l

Again, you need to do this only once if you pass the `--global` option, because then Git will always use that
information for anything you do on that system. If you want to override this with a different name or email
address for specific projects, you can run the command without the `--global` option when you’re in that project.

If the email used in a commit matches a verified GitHub or GitHub Enterprise user account, the account's username
is used on website, instead of the username set by Git.

## Configure prompt-less password for accessing repositories over http

When attempting to clone or pull a repository over http or https you will normally need to enter your password
at a prompt. This can be quite annoying after a while so instead you can add configuration to the ``~/.netrc``
file that will supply credentials. It is useful to add it for both the internal GitHub repository as well as the
public git hub repository.

Add the following snippet to the ``~/.netrc`` file creating it if necessary and updating the username and password
as appropriate.

    machine github.com login myusername password mypassword

## GPG signing commits

Authorship of git commits is determined by some metadata setup when running git as documented in the
[Configuring Basic Settings](#Configuring Basic Settings) section. It is trivial to impersonate anyone
when committing code. To avoid this scenario you can gpg sign your commits which means that it is harder
to impersonate your commits. Your commits are also marked as _Verified_ on GitHub website. See the
[documentation](https://help.github.com/articles/signing-commits-using-gpg/) on GutHub for how to setup
gpg signing.

The cliff notes for setting up gpg signing are run the following command:

    $ git config --global commit.gpgsign true

Install [GPG Suite](https://gpgtools.org/) under OSX, [Gpg4win](https://www.gpg4win.org/) under windows
or run `sudo apt-get install gnupg2` under Linux and [generate and upload](https://help.github.com/articles/generating-a-new-gpg-key/)
 a key to GitHub. Then commit as usual and you should see your commits coming through as verified.

If you perform git commits through IntelliJ and want them to be signed, add the following lines to your
`~/.gnupg/gpg.conf` file:

    # This option tells gpg not to expect a TTY interface and allows IntelliJ to sign commits
    no-tty

## Turning off the "helpful" popup when using git gui

When running `git gui` you will almost always get a warning that there is too many loose objects and a gc
is required. This message can be disabled by running the following command:

    $ git config --global gui.gcwarning false

## Set push.default configuration

Historically the config _push.default_ was set to _matching_ which means that git will push local branches
to the remote branches that already exist with the same name. This means that when you type `git push` you
could be pushing any number of branches and not just the current branch. This can cause a significant amount
of confusion and thus the default was changed to _simple_. You should update your configuration to make sure
it is set to the new default via:

    $ git config --global push.default simple

## Setting up Git Global Ignores

Each OS has a separate set of temporary files it will place in each directory. Rather than adding
ignores for all these files into every project, it is easier to set it up at a global level. A
file named `.gitignore_global` should be placed in your home directory with the contents:

    .DS_Store
    .DS_Store?
    ._*
    .Spotlight-V100
    .Trashes
    ehthumbs.db
    Thumbs.db
    *~
    #.*

Then the following command should be run:

    $ git config --global core.excludesfile ~/.gitignore_global
