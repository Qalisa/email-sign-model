#!/bin/bash

#
readonly OUTPUT_FOLDER=./signatures
readonly INPUT_ENVS_FILES=./persons
readonly SIGNATURE_TEMPLATE_FILE=sign-template.html

#
rm -rf $OUTPUT_FOLDER
mkdir $OUTPUT_FOLDER


#
readonly OUTPUT_FOLDER_R=`realpath $OUTPUT_FOLDER`
readonly PERSONS_FOLDER_R=`realpath $INPUT_ENVS_FILES`
readonly PERSONS_ENV_FILES=`find $PERSONS_FOLDER_R -maxdepth 1 -type f -not -path '*/\.*' | sort`

#
for i in $PERSONS_ENV_FILES;
do 
    # read and export (MANDATORY !) .env file related to person
    set -o allexport && source $i && set +o allexport

    #
    TMP_NAME=`basename $i .env`
    GENERATE_FILE_AT=$OUTPUT_FOLDER_R/$TMP_NAME.html

    #
    envsubst < $SIGNATURE_TEMPLATE_FILE > $GENERATE_FILE_AT

    #
    echo "[$TMP_NAME] Signature generated at \"$GENERATE_FILE_AT\" !"
done
