#!/usr/bin/env bash

usage="$(basename "$0") [-hl] [-t] -- Script to test a bundle installation with on a symfony application.
    where:
        -h  show help text
        -b  The  complete package name of the bundle;"

BASE_DIR=${PWD}
BUILD_DIR=${BASE_DIR}/build

BUNDLE_NAME=''
ORGANISATION=''
VERSION='dev-master'

function installBundle() {
    DIR=${BUILD_DIR}/${ORGANISATION}/${BUNDLE_NAME}

    mkdir -p ${DIR}
    echo "Create directory ${DIR}"
    cd ${DIR}
    echo "+++ Create Symfony skeleton app +++ "
    composer create-project "symfony/skeleton:^3.3" test-app
    cd test-app/
    composer req cli
    REQUIRE=${ORGANISATION}"/"${BUNDLE_NAME}":"${VERSION}
    echo "+++ Require bundle ${REQUIRE} +++"
    composer req "${REQUIRE}"
    echo "+++ We should fetch composer exit code here +++"
}

while getopts :hvb:o: option
do
    case "${option}"
    in
        b) BUNDLE_NAME=${OPTARG};;
        o) ORGANISATION=${OPTARG};;
        v) VERSION=${OPTARG};;
        h) echo "${usage}"
           exit 1
           ;;
        :) printf "missing argument for -%s\n" "$OPTARG" >&2
           echo "$usage" >&2
           exit 1
           ;;
        \?) printf "illegal option: -%s\n" "$OPTARG" >&2
            echo "$usage" >&2
            exit 1
            ;;
    esac
done

installBundle

