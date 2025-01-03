# Design


## Orchestration

* All shell script, no dependencies
* Create a file to be executed on the remote host
    * Take user task, take rtctl file - extract user functions, append user task file (all files)
    * Create folder on control machine, compress, send and extract on remote
* Copy created file and config and templates to remote host
* Execute file on remote host
* Report back results

## special commands (singles)
rtctl init
rtctl create [task]

## standard commands ()
rtctl hostname (or group name, or All) task args

use hosts file in project folder, or use hosts folder and name each file by group name

this will create 

create a 

Functions required:

amend config files (sysrc)
create files
create folders
copy content to file
copy a template file, insert config vars, save to remote host
ensure a file contains supplied lines
ensure a file does not contain supplied lines
set file permissions
set file ownership


config file should contain global config
config file should contain config grouped by hostname


