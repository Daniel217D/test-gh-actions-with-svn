#!/usr/bin/env bash

# Exit if any command fails.
set -ex

# Enable nicer messaging for build status.
BLUE_BOLD='\033[1;34m';
GREEN_BOLD='\033[1;32m';
RED_BOLD='\033[1;31m';
YELLOW_BOLD='\033[1;33m';
COLOR_RESET='\033[0m';
error () {
    echo -e "\n${RED_BOLD}$1${COLOR_RESET}\n"
}
status () {
    echo -e "\n${BLUE_BOLD}$1${COLOR_RESET}\n"
}
success () {
    echo -e "\n${GREEN_BOLD}$1${COLOR_RESET}\n"
}
warning () {
    echo -e "\n${YELLOW_BOLD}$1${COLOR_RESET}\n"
}

TAG=$1

if [ -z "$TAG" ]
then
      echo "\$TAG is empty"
      exit 1
fi

rm -rf svn
svn co https://plugins.svn.wordpress.org/wc-tinkoff-secure-deal-payment-gateway svn
rm -rf svn/trunk
cp -r build/wc-tinkoff-secure-deal-payment-gateway svn/trunk

cd svn
svn cp trunk "tags/$TAG"
svn ci -m "Publish $TAG github release" --username *** --password ***

