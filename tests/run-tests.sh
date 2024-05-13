#!/bin/bash

IMAGE_NAME=$1
PY_TEST_PARAMS="$2"
TESTS="$3"
RETRY=$4
[ -z "$RETRY" ] && RETRY=1
JUNITXML=$(echo "$TESTS" | cut -d "." -f1)_tr.xml
LOGFILE=logs/$(echo "$TESTS" | cut -d "." -f1).log

set -x
for ((i=1; i<=$RETRY; i++)); do
    echo "Running the py test for tests: $TESTS, $i/$RETRY..."
    py.test -v --force-flaky --junitxml="$JUNITXML" --log-file-level debug --log-file="$LOGFILE" $PY_TEST_PARAMS --imgname="$IMAGE_NAME" $TESTS && break
done
