#!/bin/bash
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
VAGRANT_ROOT=$(readlink -m $SCRIPTPATH/..)
PUPPET_ROOT=$VAGRANT_ROOT/puppet
PUPPET_MANIFEST_DIRECTORY=$PUPPET_ROOT/manifests
PUPPET_MODULES_DIRECTORY=$PUPPET_ROOT/modules-dev
PUPPET_LIBRARY_DIRECTORY=$PUPPET_ROOT/modules

EXPECTED_PATHS=($VAGRANT_ROOT $PUPPET_ROOT $PUPPET_MANIFEST_DIRECTORY $PUPPET_MODULES_DIRECTORY $PUPPET_LIBRARY_DIRECTORY)

for i in "${EXPECTED_PATHS[@]}"
do
    :
    if [ ! -d "$i" ];then
        echo "\""$i"\" does not exist."
        exit 1
    fi
done

PUPPET_MODULE_PATH="'"$PUPPET_MODULES_DIRECTORY/:$PUPPET_LIBRARY_DIRECTORY/"'"
cd $PUPPET_MANIFEST_DIRECTORY
sudo puppet apply --verbose --debug --modulepath $PUPPET_MODULE_PATH site.pp --detailed-exitcodes
