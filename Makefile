# 设置镜像名和标签
IMAGE_NAME=my-go-app
TAG=v1.0

# 默认目标
all: build run test

# 构建 Docker 镜像
build:
	docker build -t $(IMAGE_NAME):$(TAG) .

# 运行 Docker 容器
run:
	@echo "运行 Docker 容器..."
	@CONTAINER_ID=$$(docker run -d -p 8080:8080 $(IMAGE_NAME):$(TAG)); \
	echo "容器 ID: $$CONTAINER_ID"; \
	sleep 5; \
	if curl -f http://localhost:8080; then \
		echo "应用程序运行成功！"; \
	else \
		echo "应用程序未能运行。"; \
		docker logs $$CONTAINER_ID; \
	fi; \
	docker stop $$CONTAINER_ID; \
	docker rm $$CONTAINER_ID

# 执行 E2E 测试
test:
	@bash e2e.sh

# 清理
clean:
	docker rmi $(IMAGE_NAME):$(TAG) || true