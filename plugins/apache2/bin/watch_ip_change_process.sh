#!/bin/sh

pid=0
while read line; do
  if [ $(echo $line | grep -c 'inet') -eq 0 ]; then
    continue
  fi
  if [ $pid -ne 0 ]; then
    kill $pid > /dev/null 2>&1
  fi
  # waiting if there are more changes coming soon
  {
    sleep 0.5;
    echo "Regenerating DNS records"
    /usr/share/lamp/bind-views.sh
  } &
  pid=$!
done
