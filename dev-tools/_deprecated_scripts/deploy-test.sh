#!/bin/bash
# Travis CI Generating and Building for the Google Analytics Ghost Spam Blocker
# Created by: Mitchell Krog (mitchellkrog@gmail.com)
# Copyright: Mitchell Krog - https://github.com/mitchellkrogza
# Repo Url: https://github.com/mitchellkrogza/Stop.Google.Analytics.Ghost.Spam.HOWTO

# MIT License

# Copyright (c) 2017 Mitchell Krog - mitchellkrog@gmail.com
# https://github.com/mitchellkrogza

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# ******************
# Set Some Variables
# ******************

YEAR=$(date +"%Y")
cd $TRAVIS_BUILD_DIR
_input=$TRAVIS_BUILD_DIR/.dev-tools/_input_source/bad-referrers.list

# *********************************************
# Sort our list alphabetically and remove dupes
# *********************************************

sudo sort -u $_input -o $_input

# *******************************
# Remove Remote Added by TravisCI
# *******************************

git remote rm origin

# **************************
# Add Remote with Secure Key
# **************************

git remote add origin https://${GOOGLESPAM_TOKEN}@github.com/${TRAVIS_REPO_SLUG}.git

# *********************
# Set Our Git Variables
# *********************

git config --global user.email "${GIT_EMAIL}"
git config --global user.name "${GIT_NAME}"
git config --global push.default simple

# *******************************************
# Make sure we have checked out master branch
# *******************************************

git checkout master

# ***************************************************
# Set our scripts to be executable
# ***************************************************

sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/modify-readme.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/generate-google-exclude.php
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/install-run-funceble.sh
sudo chmod +x $TRAVIS_BUILD_DIR/.dev-tools/final-commit.sh

# ***************************************************
# Run funceble to check for dead domains
# ***************************************************

#sudo sh -x $TRAVIS_BUILD_DIR/.dev-tools/install-run-funceble.sh

# **************************************************************************************
# Generate our google exclude files and update README with build and version information
# **************************************************************************************

php ./.dev-tools/generate-google-exclude.php
sudo $TRAVIS_BUILD_DIR/.dev-tools/modify-readme.sh

# *************************************
# Add all the modified files and commit
# *************************************

git add -A
git commit -am "V1.$YEAR.$TRAVIS_BUILD_NUMBER [ci skip]"
git push origin master


# *************************************************************
# Travis now moves to the before_deploy: section of .travis.yml
# *************************************************************

# MIT License

# Copyright (c) 2017 Mitchell Krog - mitchellkrog@gmail.com
# https://github.com/mitchellkrogza

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.