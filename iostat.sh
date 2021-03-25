#!/bin/sh

logfile=/tmp/.io-monitor/`date +%Y-%m-%d`.csv
logdir=$(dirname $logfile)

# Create directory if not exists
test ! -d "$logdir" && mkdir -p "$logdir"

if [ ! -s "$logfile" ]; then
  echo '"time";"%user";"%nice";"%system";"%iowait";"%steal";"%idle";"rrqm/s";"wrqm/s";"r/s";"w/s";"rkB/s";"wkB/s";"avgrq-sz";"avgqu-sz";"await";"r_await";"w_await";"svctm";"%util"' > "$logfile"
fi

tmp=`iostat -x`
result=`echo $tmp | awk -v 's="' '{ print s$15s ";" s$16s ";" s$17s ";" s$18s ";" s$19s ";" s$20s ";" s$36s ";" s$37s ";" s$38s ";" s$39s ";" s$40s ";" s$41s  ";" s$42s ";" s$43s  ";" s$44s ";" s$45s  ";" s$46s ";" s$47s  ";" s$48s ";" s$49s  }'`

echo "\"`date +%H%M%S`\";$result" >> "$logfile"
