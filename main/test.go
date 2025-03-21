package main

import (
	"fmt"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
)

func main() {
	// 创建一个新的 Gin 引擎
	r := gin.Default()

	// 定义一个路由，处理 GET 请求
	r.GET("/list-dir", func(c *gin.Context) {
		// 获取目录路径，从查询参数中获取
		dirPath := c.Query("path")
		if dirPath == "" {
			dirPath = "." // 如果未提供，则默认为当前目录
		}

		// 列出目录中的文件和子目录
		files, err := os.ReadDir(dirPath)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}

		var fileNames []string
		for _, file := range files {
			fileNames = append(fileNames, file.Name())
		}

		c.JSON(http.StatusOK, gin.H{"files": fileNames})
	})

	// 启动服务器，监听在 8080 端口
	if err := r.Run(":8080"); err != nil {
		fmt.Printf("Could not start server: %v\n", err)
	}
}
