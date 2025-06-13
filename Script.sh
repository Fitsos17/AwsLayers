#!/bin/bash

# TERMINATE SCRIPT ON ERROR
set -e

# Variables
# - Allow this bash script to create the alias for python
# - Version can be either 11 or 12. Other versions do not exist in yum (and they are oudated)
PYTHON_VERSION=""
S3_PATH_TO_REQUIREMENTS=""
LAYER_NAME=""

PYTHON_ALIAS="python${PYTHON_VERSION}"
ZIP_FILE_NAME="${LAYER_NAME}.zip"
PATH_TO_ZIP_FILE="fileb://${ZIP_FILE_NAME}"

# update and install packages
shopt -s expand_aliases
sudo yum update -y
sudo yum install $PYTHON_ALIAS -y

alias python=$PYTHON_ALIAS

# Create virtual environment
mkdir env
python -m venv env
source env/bin/activate
python -m pip install --upgrade pip

# Create package with all the libraries:
mkdir python
aws s3 cp $S3_PATH_TO_REQUIREMENTS ./env/requirements.txt
python -m pip install -r ./env/requirements.txt --target=./python
zip -r $ZIP_FILE_NAME ./python

# Upload to lambda
aws lambda publish-layer-version --layer-name=$LAYER_NAME --compatible-runtimes=$PYTHON_ALIAS --zip-file=$PATH_TO_ZIP_FILE

# Cleanup
sudo rm -rf env $ZIP_FILE_NAME  python