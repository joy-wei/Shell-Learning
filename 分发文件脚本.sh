#!/bin/bash

# 定义需要分发的文件名和目标目录
filename="example.txt"
target_dir="/path/to/target/directory"

# 定义要分发的节点列表
nodes=("node1" "node2" "node3")

# 遍历节点列表，将文件分发到每个节点
for node in "${nodes[@]}"
do
  # 使用 scp 命令将文件上传到目标节点
  scp "$filename" "$node:$target_dir"
  echo "File '$filename' uploaded to node '$node'"
done

echo "File distribution complete."
