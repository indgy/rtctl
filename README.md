# rtctl

**R**emo**t**e **c**on**t**ro**l** is a small shell script utility to administer remote hosts,
the only dependencies being `sh` and `ssh` and a *BSD operating system.

*NB: This is incomplete software, caveat emptor!*

## Logic

Each task is divided into 3 areas

* Checking the current system state
* Performing the task
* Checking the final system state

