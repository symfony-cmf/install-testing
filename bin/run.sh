#!/usr/bin/env bash

BASE_DIR=${PWD}
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
for bundle in ${BUNDLES[*]}
do
    ${BASE_DIR}/bin/install.sh -osymfony-cmf -b${bundle}
done
