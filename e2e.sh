#!/bin/bash

# 设置镜像名和标签
IMAGE_NAME="my-go-app"
TAG="v1.0"

# 构建 Docker 镜像
echo "构建 Docker 镜像..."
docker build -t $IMAGE_NAME:$TAG .

# 运行 Docker 容器
echo "运行 Docker 容器..."
CONTAINER_ID=$(docker run -d -p 8080:8080 $IMAGE_NAME:$TAG)

# 等待几秒钟以确保应用程序启动
sleep 5

# 验证应用程序是否运行成功
echo "验证应用程序是否运行成功..."
if curl -f http://localhost:8080; then
    echo "应用程序运行成功！"
else
    echo "应用程序未能运行。"
    docker logs $CONTAINER_ID
fi

# 停止并删除容器
docker stop $CONTAINER_ID
docker rm $CONTAINER_ID