#!/usr/bin/env bash
#
# Example script utilising prettify.sh. All it does is check for updates in apt.
source ./prettify.sh


init() {
    set -euo pipefail # strict mode
}


# if you want to embed prettify, comment out the source line at the beginning of
# this script and replace this commend with the contents of prettify.sh.


main() {
    init # run init function
    notify "This script checks for package updates via APT."
    notify "No packages will actually be installed."
    notify "To continue, enter your sudo password. If you want to cancel, press CTRL + C."
    doElevation
    elevated "apt-get update"
    finished "Checking for updates."
}


# make sure bash 4 is being used and run the script, exit otherwise
# this prevents people from running the script with an unsupported interpreter
if [ -z "${BASH_VERSINFO}" ] || [ -z "${BASH_VERSINFO[0]}" ] || [ ${BASH_VERSINFO[0]} -lt 4 ]
then
    echo "This script requires Bash version 4 or newer."
    exit 1
else
    main
fi
