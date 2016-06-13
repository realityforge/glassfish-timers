data_bag() { knife data bag from file $1 data_bags/$1/$2; }
data_bag_database() { data_bag 'databases' $1; }
data_bag_template() { data_bag 'templates' $1; }
data_bag_services() { data_bag 'services' $1; }
data_bag_application() { data_bag 'applications' $1; }
data_bag_destination() { data_bag 'destinations' $1; }

alias kdba=data_bag_application
alias kdbd=data_bag_destination
alias kdbdb=data_bag_database
alias kdbs=data_bag_services
alias kdbt=data_bag_template
alias kcb='knife cookbook upload'
alias kenv='knife environment from file'
alias kdiff='ruby xpiceweasel.rb --diff'

_database() {
   local word=${COMP_WORDS[COMP_CWORD]}
   COMPREPLY=( $( compgen -W "`find data_bags/databases/*.json -exec basename {} \;`" -- $word ) )
}
complete -F _database kdbdb

_destination() {
   local word=${COMP_WORDS[COMP_CWORD]}
   COMPREPLY=( $( compgen -W "`find data_bags/destinations/*.json -exec basename {} \;`" -- $word ) )
}
complete -F _destination kdbd

_services() {
   local word=${COMP_WORDS[COMP_CWORD]}
   COMPREPLY=( $( compgen -W "`find data_bags/services/*.json -exec basename {} \;`" -- $word ) )
}
complete -F _services kdbs

_app() {
   local word=${COMP_WORDS[COMP_CWORD]}
   COMPREPLY=( $( compgen -W "`find data_bags/applications/*.json -exec basename {} \;`" -- $word ) )
}
complete -F _app kdba

_template() {
   local word=${COMP_WORDS[COMP_CWORD]}
   COMPREPLY=( $( compgen -W "`find data_bags/templates/*.json -exec basename {} \;`" -- $word ) )
}
complete -F _template kdbt

_cookbook() {
   local word=${COMP_WORDS[COMP_CWORD]}
   COMPREPLY=( $( compgen -W "`find cookbooks/* -maxdepth 0 -type d -exec basename {} \;`" -- $word ) )
}
complete -F _cookbook kcb

_environment() {
   local word=${COMP_WORDS[COMP_CWORD]}
   COMPREPLY=( $( compgen -W "`find environments/*.json -exec basename {} \;`" -- $word ) )
}
complete -F _environment kenv

