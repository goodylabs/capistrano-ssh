#!/bin/bash

# Capistrano SSH v0.2 2017-10-01

CAT=`which cat`
CUT=`which cut`
GREP=`which grep`
HEAD=`which head`
SSH=`which ssh`
TAIL=`which tail`

function show_help {
  echo ""
  echo "Usage: "
  echo "$0 [role] [server_number]"
  echo ""
}

if [ "x$1" == "x--help" ] || [ "x$1" == "x-h" ]; then
  show_help
  exit 1
fi

CAPISTRANO_CONFIG_DIR="config/deploy"

filename=$0

REMOTE_ENV="${filename##*-}"
REMOTE_ENV="${REMOTE_ENV%.*}"

SERVER_ROLE="$1"
SERVER_NO="$2"
if [ "x${SERVER_NO}" == "x" ]; then
  SERVER_NO="1"
fi

echo "Remote ENV: ${REMOTE_ENV}"
echo "Server role: ${SERVER_ROLE}"
echo "Server number: ${SERVER_NO}"

FIRST_SERVER_LINE=`${CAT} ${CAPISTRANO_CONFIG_DIR}/${REMOTE_ENV}.rb  | ${GREP} -v "^#" | ${GREP} "server" | ${GREP} "${SERVER_ROLE}" | ${HEAD} -${SERVER_NO} | ${TAIL} -1`

REMOTE_HOST=`echo ${FIRST_SERVER_LINE} | ${CUT} -f 1 -d "," | ${CUT} -f 2 -d "'" | ${CUT} -f 2 -d "\""`
REMOTE_USER=`echo ${FIRST_SERVER_LINE} | ${CUT} -f 2 -d "," | ${CUT} -f 2 -d "'" | ${CUT} -f 2 -d "\""`

echo "Remote host: ${REMOTE_HOST}"
echo "Remote user: ${REMOTE_USER}"

${SSH} ${REMOTE_USER}@${REMOTE_HOST} -v

