# New Computer Checklist

* Create User:
* Install Homebrew: [Homebrew.md](Homebrew.md).
* Install Chrome: `brew cask install google-chrome`.
* Git: See [Git.md](Git.md).
* Java 7: See [Java.md](Java.md).
* Java 8: See [Java.md](Java.md).
* Intellij Idea: See [IntellijIDEA.md](IntellijIDEA.md).
* Ruby: See [Ruby.md](Ruby.md).
* Buildr: See [GemDependencies.md](GemDependencies.md).
* Payara: See [GlassFish.md](GlassFish.md).
* NodeJS: See [HowToNodeJS.md](NodeJS.md).
* Postgres: See [Postgres.md](Postgres.md).
* LibreOffice: `brew cask install libreoffice`
* VPN: [Download Cisco AnyConnect mobility client 3.1](https://s3-ap-southeast-2.amazonaws.com/stocksoftware-installers/CiscoAnyConnect/mac/anyconnect-macosx-i386-3.1.06079-k9.dmg).
* Keepass: See [KeePass.md](KeePass.md).
* Slack: `brew cask install slack`
* Source Tree: `brew cask install sourcetree`
* Bookmarks: Add all the links on the [External Services](ExternalServices.md) page.

## Set up Localhost (Mac only)

You may run into problems when connecting to the VPN whereby your localhost turns into something
unrecognisable. If this happens issue the following command replacing computer_name with your machines
name e.g. 'Karens-MacBook-Pro':-

```sh
sudo scutil --set HostName <computer_name>.local
```
