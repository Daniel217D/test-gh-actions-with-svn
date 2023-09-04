#!/bin/bash

# Exit if any command fails.
set -ex

# Define variables
PLUGIN_SLUG="wc-tinkoff-secure-deal-payment-gateway"   # Replace with your plugin's slug
SVN_REPO="https://plugins.svn.wordpress.org/$PLUGIN_SLUG"
NEW_TAG="$1"  # The new tag version (passed as a command-line argument)

# ENV Переменные
svn_username="$SVN_USERNAME"
svn_password="$SVN_PASSWORD"

# Check if the NEW_TAG variable is empty
if [ -z "$NEW_TAG" ]
then
      echo "\$NEW_TAG is empty"
      exit 1
fi

# Create a ZIP archive of the plugin
bash ./bin/zip.sh

# Remove the local 'svn' directory if it exists
rm -rf svn

# Check out the WordPress SVN repository for the plugin into the 'svn' directory
svn co "$SVN_REPO" svn

# Remove the 'trunk' directory from the checked-out repository
rm -rf svn/trunk

# Copy the contents of the plugin from the 'build' directory to 'svn/trunk'
cp -r build/wc-tinkoff-secure-deal-payment-gateway svn/trunk

# Change the working directory to the 'svn' directory
cd svn

# Create a new tag in the SVN repository by copying the contents of 'trunk' to 'tags/$NEW_TAG'
svn cp trunk "tags/$NEW_TAG"

# Commit the new tag to the SVN repository with a commit message
svn ci -m "Publish $NEW_TAG github release" --username *** --password ***

