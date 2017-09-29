#!/usr/bin/env bash



BASE_DIR=${PWD}
BUILD_DIR=build
BUNDLES=(
    'block-bundle'
    'core-bundle'
    'content-bundle'
    'tree-browser-bundle'
    'routing-auto-bundle'
    'routing-bundle'
    'seo-bundle'
    'menu-bundle'
    'resource-bundle'
    'resource-rest-bundle'
    'sonata-phpcr-admin-integration-bundle'
)
ALL_ERRORS=0

function finish() {
    rm -rf ${BASE_DIR}/${BUILD_DIR}/*-bundle
}

echo "+++ Start in ${BASE_DIR} +++"
for bundle in ${BUNDLES[*]}
do
    DIR=${BASE_DIR}/${BUILD_DIR}/${bundle}
    mkdir ${DIR}
    cd ${DIR}
    echo "+++ Create Symfony skeleton app +++ "
    composer create-project "symfony/skeleton:^3.3" test-app
    cd test-app/
    composer req cli
    echo "+++ Require bundle ${bundle} +++"
    composer req -n "symfony-cmf/${bundle}"
    echo "+++ We should fetch composer exit code here +++"
done

finish

trap finish EXIT

