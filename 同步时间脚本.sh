#!/bin/bash

# 定义要同步时间的节点列表
nodes=("node1" "node2" "node3")

# 使用 ntpdate 命令同步时间，如果无法连接 NTP 服务器，则使用第一台服务器的时间
for node in "${nodes[@]}"
do
  if ntpdate -u pool.ntp.org >/dev/null 2>&1; then
    echo "Time updated on node '$node' using NTP server."
  else
    ssh "$node" "date -s '$(ssh "${nodes[0]}" date +"%Y-%m-%d %H:%M:%S")'"
    echo "Time updated on node '$node' using reference server."
  fi
done

echo "Time synchronization complete."
