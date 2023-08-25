#!/usr/bin/env bash

# Exit if any command fails.
set -ex

# Change to the expected directory.
DIR=$(pwd)
BUILD_DIR="$DIR/build/wc-tinkoff-secure-deal-payment-gateway"

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

status "💃 Time to build 🕺"

# remove the build directory if exists and create one
rm -rf "$DIR/build"
mkdir -p "$BUILD_DIR"

# Copy all files
status "Copying files... ✌️"
FILES=(assets includes readme.txt wc-tinkoff-secure-deal-payment-gateway.php)

for file in ${FILES[@]}; do
  cp -R $file $BUILD_DIR
done

# go one up, to the build dir
if command -v zip
then
  status "Creating archive... 🎁"

  cd ./build
  zip -r -q wc-tinkoff-secure-deal-payment-gateway.zip wc-tinkoff-secure-deal-payment-gateway

else
  warning "zip command not found. Create archive by yourself ./build/wc-tinkoff-secure-deal-payment-gateway"
fi

success "Done. You've built plugin! 🎉 "