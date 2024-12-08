#!/bin/bash

# 检查参数个数是否正确
if [ $# -ne 2 ]; then
  echo "Usage: $0 imageName imageTag"
  exit 1
fi

# 获取参数
imageName="$1"
imageTag="$2"

# 参数非空判断
if [ -z "$imageName" ] || [ -z "$imageTag" ]; then
  echo "Both imageName and imageTag must be provided."
  exit 1
fi

# 执行 Docker 命令
echo "Pull image from docker hub: " && \
docker pull "$imageName:$imageTag" && \
docker tag "$imageName:$imageTag" registry.cn-hangzhou.aliyuncs.com/alanwei/"$imageName":"$imageTag" && \
echo "Push image to aliyun: " && \
docker push registry.cn-hangzhou.aliyuncs.com/alanwei/"$imageName":"$imageTag" && \
echo "The image ID: registry.cn-hangzhou.aliyuncs.com/alanwei/$imageName:$imageTag"