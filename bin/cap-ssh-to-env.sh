#!/bin/bash
# Capistrano SSH v0.1 2017-09-29

CAT=`which cat`
CUT=`which cut`
GREP=`which grep`
HEAD=`which head`
SSH=`which ssh`

CAPISTRANO_CONFIG_DIR="config/deploy"

filename=$0

REMOTE_ENV="${filename##*-}"
REMOTE_ENV="${REMOTE_ENV%.*}"

echo "Remote ENV: ${REMOTE_ENV}"

FIRST_SERVER_LINE=`${CAT} ${CAPISTRANO_CONFIG_DIR}/${REMOTE_ENV}.rb  | ${GREP} "server" | ${HEAD} -1`
REMOTE_HOST=`echo ${FIRST_SERVER_LINE} | ${CUT} -f 1 -d "," | ${CUT} -f 2 -d "'"`
REMOTE_USER=`echo ${FIRST_SERVER_LINE} | ${CUT} -f 2 -d "," | ${CUT} -f 2 -d "'"`

${SSH} ${REMOTE_USER}@${REMOTE_HOST} -v

