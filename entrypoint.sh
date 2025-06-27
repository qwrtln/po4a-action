#!/bin/sh
set -e

CONFIG="$1"
ARGS="$2"
LANGUAGE="$3"

export PERL5LIB="/opt/po4a/lib:${PERL5LIB}"
/opt/po4a/po4a --version

if [ -n "$LANGUAGE" ]; then
    echo "Processing only language: $LANGUAGE"
    trap "git checkout HEAD -- \"$CONFIG\" 2>/dev/null || true" EXIT
    sed -i "s/^\[po4a_langs\].*$/[po4a_langs] $LANGUAGE/" "$CONFIG"
    echo "Modified po4a_langs in $CONFIG to: [po4a_langs] $LANGUAGE"
fi

echo "po4a $ARGS $CONFIG"
eval "/opt/po4a/po4a $ARGS $CONFIG"
