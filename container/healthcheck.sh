#!/usr/bin/env bash

set -e

THRESHOLD=21 # seconds

now=$(date +%s)
heartbeat=$(date --reference /ofelia/var/ofelia/heartbeat +%s)
let age=now-heartbeat
if [ $age -gt $THRESHOLD ]; then
  exit 1
else
  exit 0
fi
