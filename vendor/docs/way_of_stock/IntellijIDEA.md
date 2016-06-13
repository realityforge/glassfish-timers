# Install Intellij IDEA

Our IDE of choice is [IntelliJ IDEA](https://www.jetbrains.com/idea/) and it is the only supported IDE from
which to build, test and debug our application suite. The version of IDEA that we use is `14.1.5`.

## Download IDEA

The first step is to download the "Ultimate Edition" of IDEA from [https://www.jetbrains.com/idea/download/](https://www.jetbrains.com/idea/download/).
While the website indicates that the version downloaded is a _Free 30-day Trial_ that is the same version we download.
There are three separate versions variants, one for Windows, Linux or Mac OS X. Download the one appropriate for your
operating system. The license key for IDEA can be found in the google docs document at [https://docs.google.com/document/d/1chtpG1YgI-u8TvAvhdTJ2umL4yoUssIEXW_vLn37EmE/edit](https://docs.google.com/document/d/1chtpG1YgI-u8TvAvhdTJ2umL4yoUssIEXW_vLn37EmE/edit), use the one allocated to
your name or find an unallocated key and use that.

### OSX

Install into the default location (i.e. `/Applications/`).

### Ubuntu

Extract to `~/Applications/idea-IU-141.2735.5` (or similar).

Create a symlink called `idea` to the longer directory name.

    $ ln -s ~/Applications/idea-IU-141.2735.5 ~/Applications/idea

## Plugins

When installing IDEA we typically use a reduced subset of the plugins. The fewer plugins that are active, the better
the performance of the IDE. It is highly recommended that the activated plugins be reduced to the following subset.

The builtin plugins that we require:

* Bytecode Viewer
* Database Tools and SQL
* DSM Analysis
* Git Integration
* GitHub
* GlassFish Integration
* GWT Support
* HAML
* _Handlebars/Mustache_
* Hibernate Support
* HTML Tools
* I18n for Java
* IntelliLang
* Java Bytecode Decompiler
* Java EE: * (All the Java EE plugins are required)
* Java Server Pages Integration
* Javascript Debugger
* Javascript Intention Power Pack
* Javascript Support
* JSR45 Integration
* JUnit
* _LESS CSS Compiler_
* LESS support
* _Markdown_
* Maven Integration
* Maven Integration Extension
* Persistence Frameworks Support
* Properties Support
* QuirksMode
* Refactor-X
* REST Client
* _Ruby_
* SASS support
* Spy-js
* _SwungWeave_
* Terminal
* TestNG-J
* Velocity Support
* XPathView + XSLT Support
* XSLT-Debugger
* YAML

Note: Any plugins in _italics_ are plugins that are not supplied with the IDE and must be downloaded from the central
plugin repository.

## Optional Plugins

* _Key Promoter_  can be used to learn the keystroke bindings for those new to IDEA

## JVM Settings

The default JVM settings are insufficient when working on large projects with lot's of source files. So you need to
update the JVM settings of IDEA to give it more memory. The file to edit is at `/Applications/IntelliJ\ IDEA\ 14.app/Contents/bin/idea.vmoptions`
on OSX and `~/Applications/idea-IU-141.2735.5/bin/idea64.vmoptions` and change the memory settings to increase the minimum,
maximum and maximum perm memory settings. A typical configuration may have values such as the following in the
config file:

    -Xms800m
    -Xmx1850m
    -XX:MaxPermSize=550m

## Per Project Configuration

Most projects use Buildr to generate the project files and explicitly configure the required facets and settings. So
follow the Buildr [instructions](BuildrHowto.md#IDE) on how to generate the projects. For the few projects that don't
use Buildr (i.e. the Chef projects), it is enough to manually create the projects.

## inotify limit for Ubuntu

The IDEA filesystem monitor uses inotify built into the Linux kernel to monitor open files. To ensure the kernel is
capable of monitoring enough files for our projects you can check the current limit by running `cat /proc/sys/fs/inotify/max_user_watches`.
It should be `524288`. If that is not the value then you need to add the following line to the `/etc/sysctl.conf` file:

    fs.inotify.max_user_watches = 524288

Then issue the following command to apply the change:

    $ sudo sysctl -p

## Avoiding blocked keyboard input under Ubuntu

IDEA interacts poorly with a somewhat buggy version of IBus that ships with some versions of
Ubuntu (See IDEA-78860 for further details). The symptom is idea failing to accept keystrokes.
There are a few ways to fix this:

* Upgrade IBus to version 1.5.11.
* Append the following line to `~/.bashrc`, then restart your session.
* Turn off IBus at `System Settings | Language Support | Keyboard input method`.

## Setting up icon in ubuntu

To setup an icon for IDEA in ubuntu you need to create a file `/usr/share/applications/jetbrains-idea.desktop`.
The file should contain content similar to:

    [Desktop Entry]
    Version=1.0
    Type=Application
    Name=IntelliJ IDEA
    Exec="/home/username/Applications/idea/bin/idea.sh" %f
    Icon=/home/username/Applications/idea/bin/idea.png
    Comment=Develop with pleasure!
    Categories=Development;IDE;
    Terminal=false
    StartupNotify=true
    StartupWMClass=jetbrains-idea

The file should also be made world executable via:

    $ sudo chmod a+x /usr/share/applications/jetbrains-idea.desktop

## Keyboard mappings for Ubuntu

When running IDEA for Ubuntu, due to the Unity UI, a number of keystrokes are unavailable.

Turn off the following keymappings for Unity to make sure IDEA works as expected:

[TBD, and how]
