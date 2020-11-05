#!/usr/bin/env bash


#### Preliminary Config ####

# Reset log file
rm -f ./install.log

SUDO=''
if (( $EUID != 0 )); then
    SUDO='sudo '
fi

# Declare color codes
RED='\033[0;31m'
ORANGE='\033[0;33m'
GREEN='\033[0;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
RESET='\033[0m'


#### prettify ####

# runs command privileged
elevated () {
  COMMAND="${SUDO}$*"
  echo -e "[ ${GREEN}++${RESET} ] ${COMMAND}"
  ${COMMAND} > /dev/null 2>> ./install.log
}

# runs command unprivileged
execute () {
  COMMAND="$*"
  echo -e "[ ${GREEN}--${RESET} ] ${COMMAND}"
  ${COMMAND} > /dev/null 2>> ./install.log
}

# pretty echo
notify () {
  echo -e "[${YELLOW}info${RESET}] $*"
}

# write error
error () {
  echo -e "[ ${RED}--${RESET} ] $*"
}

# finished prompt
finished () {
  echo -e "[${GREEN}DONE${RESET}] $*"
}

# testing command. unused.
testing () {
  echo "$*"
}


#### Support Functions ####

# this command forces a prompt for credentials. will skip if script was run as
# root.
doElevation () {
  if (( $EUID != 0 )); then
    sudo -k
    sudo echo -n
  fi
}