# 使用官方 Go 语言镜像
FROM golang:1.24.0

# 设置工作目录
WORKDIR /app

# 复制 go.mod 和 go.sum 文件
COPY go.mod go.sum ./

# 下载依赖
RUN go mod download

# 复制源代码
COPY . .

# 编译应用程序
RUN go build  ./main/test.go

# 确保主程序可执行
RUN chmod +x ./main/test

# 设置容器启动时运行的命令
CMD ["./main/test"]