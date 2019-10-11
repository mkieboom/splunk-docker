#!/bin/bash

docker build \
  --build-arg SPLUNK_START_ARGS=--accept-license \
  -t mkieboom/splunk-docker .
