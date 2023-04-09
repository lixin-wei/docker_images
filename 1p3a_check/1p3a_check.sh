#!/bin/bash

# Add the following proxys if needed
# export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890

# check & daily question for 1point3acres.com
set -x
BASE_DIR=/root/1point3acres
LOG=$BASE_DIR/1point3acres.log
cd $BASE_DIR/src || exit

sleep_time=$((RANDOM % 5 + 1))
total_log=""
run() {
  sleep $sleep_time
  sleep_time=$(((sleep_time + 60) * 2))
  {
    printf '\n\n'
    date
  } >>$LOG
  log_str=$(python3 service.py |& tee -a $LOG)
  total_log="$total_log\n\n$log_str"
  num_ok=$(echo "$log_str" | grep -c '已答题\|答题成功')
  # check success account number
  test "$num_ok" -eq 1
}

ok=0
for ((i = 0; i < 4; i++)); do
  echo "$i#################"
  if run; then
    ok=1
    break
  fi
done

if [ $ok -eq 0 ]; then
  curl 'https://oapi.dingtalk.com/robot/send?access_token=f6aeb79bfdbd7b33484cf124d9aa08934b716604dfde45e277553d86d934ec1b' \
    -H 'Content-Type: application/json' \
    -d "{\"msgtype\": \"text\",\"text\": {\"content\":\"Notice: log=$total_log\"}}"
fi
