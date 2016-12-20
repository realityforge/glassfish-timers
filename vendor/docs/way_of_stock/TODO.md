# Documentation development

* Architectural Overview
    * Boundary-Control-Entity layers
        * Interactions with External Systems
        * Interfaces for External Systems
        * Typical Transaction Boundaries
        * Boundary Examples: JAXRS, GWT RPC, JAXWS, JSF Controllers, etc
        * Entity Examples: Soap service, Database Service, Mail Service etc

* Environment Setup
    * Document ~/.bash.d/ setup. i.e. Adding the following to .bashrc `for f in ~/.bash.d/*.sh; do source $f; done`
    * sql server and initial dev user
    * virtualbox (via cask on Mac)
        * Sharing Host VPN with VirtualBox guest - http://renier.morales-rodriguez.net/post/90674523562/sharing-host-vpn-with-virtualbox-guest
    * dockertoolbox (via cask on Mac) (Incorporate http://michaelheap.com/docker-machine-on-osx/)
    * Completions under OSX - `brew install homebrew/completions/docker-completion` && `brew install homebrew/completions/docker-machine-completion`

* Intellij
    * Add colouring for buildfile in ide
    * Setting default thread debug behaviour

* Release process (Started in ApplicationRelease)
    * concept of applications in databags, templates, template types etc
    * How to converge
    * How to define Jenkins jobs

* Guiceyloops
    * Document dbcleaner and how to configure
    * Document single database example
    * Document multiple database example
    * Document mail server example
    * Document jndi example
    * Document glassfish container example
    * Document openmq container example

* Domgen
    * Overview
    * Getting started
    * Model Elements
    * Facets
    * Generators

* Dbt
    * new features
    * packaged dbt definition
    * buildr integration
    * better organization

* Replicant

* Way of Stock Software:
    * Goals are to minimize development cost
    * Maintained over the next 15 years
    * Consistency
    * Variance starts as an experiment, is deliberate

* Way of Development
    * Minimize dependencies
    * Consistent dependencies across all the applications
    * Make it like a single user wrote the code
    * Prefer making architecture identical even if it adds overhead
    * Duplicate it when used in two places, extract it when used in third

* Way of Operation
