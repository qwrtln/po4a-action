#!/bin/sh
set -e

CONFIG="$1"
ARGS="$2"

export PERL5LIB="/opt/po4a/lib:${PERL5LIB}"
/opt/po4a/po4a --version
echo "po4a $ARGS $CONFIG"
eval "/opt/po4a/po4a $ARGS $CONFIG"
