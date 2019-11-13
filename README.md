# jianshu

知识星球简书项目实战

## 推荐学习方式

fork（派生）该项目，之后 git clone 下载到任意非 GOPATH 目录下

1. 非 docker 方式：执行 make buid 编译，会在当前目录生成可执行文件
2. docker 方式：make run

## 如何运行

1.非 docker 方式

在本地 mysql 中导入 docs/db.sql，会创建好数据库和表，确保 config/config.toml 中数据库相关配置和本地的一致，比如用户名、密码等。

运行 ./jianshu ，访问 http://localhost:2019 即可看到

2.docker 方式

请[参考这里](Node.md)

## 简书系列文档

1. [简书系列1：总体规划](https://studygolang.com/topics/9652)
2. [简书系列2：需求分析和系统设计 1 - 拆解需要实现哪些功能](https://studygolang.com/topics/9766)
3. [简书系列3：需求分析和系统设计 2 - 技术分析和选型](https://studygolang.com/topics/9825)
4. [简书系列4：需求分析和系统设计 3 - 核心功能的方案设计和难点分析](https://studygolang.com/topics/10373)
