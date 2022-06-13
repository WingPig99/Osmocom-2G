#!/bin/sh -e

# https://osmocom.org/projects/cellular-infrastructure/wiki/Build_from_Source#Example-script-for-cloning-and-building-a-single-project

# Location where the git repositories will be stored (must exist)
DIR=$(pwd)/code

# Check usage
if [ -z "$1" ]; then
    echo "usage: $(basename $0) PROJECT" 
    exit 1
fi

# Clone
cd $DIR
if ! [ -d "$1" ]; then
    git clone "git://git.osmocom.org/$1" 
fi

# Build
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig/" 
cd $1
autoreconf -fi

opt_enable=""
if [ "$1" = "libosmo-abis" ]; then
    opt_enable="--disable-dahdi" 
fi
if [ "$1" = "osmo-trx" ]; then
    opt_enable="--with-uhd" 
fi

./configure --sysconfdir "/etc" $opt_enable 
make -j3
make check
sudo make install
sudo ldconfig