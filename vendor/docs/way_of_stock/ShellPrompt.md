# Setting up the shell prompt

It is useful to setup the shell prompt to present useful information. Several people at stock derived their shell
prompt using the following script. The prompt modification shows;

* the git branch (if in a git repository)
* if there is any uncommitted changes (if in a git repository)
* the ruby version (if rbenv is installed)

The script can be downloaded from [prompt.sh](prompt.sh). The contents can be appended to the `~/.bashrc` script
or you can place the script in a directory (i.e. `~/.bash.d`) and source it from the `~/.bashrc` script (i.e.
append `source ~/.bash.d/prompt.sh` to the `~/.bashrc` script).
