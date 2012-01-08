#!/bin/bash

#* Adaptation d'un script publié par Lukas Ruf en 2006
#* License: GPL3

neighbor=10.1.30.10

scriptname=`basename $0`
scriptname=${scriptname%.*}
delay=10 # sleep time
logfile=/var/log/$scriptname.log  # file for debug messages
lockfile=/var/lock/$scriptname.lock # locking to avoid races

# control where to log debug messages to:
# debugfile = 0 : log to /dev/null
# debugfile = 1 : log to file specified in ${logfile}
debugfile=1

# log a message to the log-file specified by debugfile
function keepalive_debug() {

  local msg="$1"
  local dat=$(date "+%b %d %H:%M:%S") # time stamp

  if [ "${debugfile}" == "1" ]; then
    lockfile -r 1 ${lockfile}
    if [ "$?" == "0" ]; then
      touch ${logfile} >/dev/null 2>&1
      chmod 0644 ${logfile} >/dev/null 2>&1
      echo -n "${dat}: " >>${logfile} 2>&1
      echo "${msg}" >>${logfile} 2>&1
      rm -f ${lockfile} >/dev/null 2>&1
    fi
  else
    echo "${msg}" >/dev/null 2>&1
  fi
}

# redirect messages from stdin to debug
function redirect() {

  local msg="$(cat -)"

  keepalive_debug "${msg}"
}

# ping the ${neighbor} and sleep ${delay} seconds
function alive_ping() {

  local msg=""

  keepalive_debug "alive_ping"
  while $(true) ; do
    msg=$(/bin/ping -W 2 -n -c 1 ${neighbor} 2>&1 | egrep '(bytes from|100% packet loss)')

    if [[ "${msg}" =~ "bytes from" ]] && [[ ! -e /tmp/${neighbor}_up ]]; then
      ip route add default via ${neighbor}
      touch /tmp/${neighbor}_up
      keepalive_debug "${neighbor} is reachable, default route added"
    fi

    if [[ "${msg}" =~ "100% packet loss" ]] && [[ -e /tmp/${neighbor}_up ]]; then
      ip route del default via ${neighbor}
      rm -f /tmp/${neighbor}_up
      keepalive_debug "${neighbor} is not reachable, default route deleted"
    fi

    sleep ${delay}
  done
}

# start up and handle proper daemonization
function main() {

  local argument="daemon"

  if [ "$1" == "${argument}" ]; then
    alive_ping
  else
    keepalive_debug "START"
    keepalive_debug "daemonize $0"
    nohup /bin/bash $0 ${argument} $* >/dev/null 2>&1 &
    keepalive_debug "daemonized $0"
  fi
}

main $*

exit 0 
