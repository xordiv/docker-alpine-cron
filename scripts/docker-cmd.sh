#!/bin/sh
set -e

export LOGFILE=/var/log/cron/cron.log

if [ "$CRON_TAIL" == "no_logfile" ] 
then
  rm $LOGFILE
  mkfifo $LOGFILE
fi

[ -n "$CRON_CMD_OUTPUT_LOG" ] && output="-M /log_to_file.sh"
[ -n "$CRON_TAIL" ] && tail -f $LOGFILE &

crond $output -s /var/spool/cron/crontabs -f -L $LOGFILE "$@"
