/*
 * Copyright (c) 2019. The StudyGolang Authors. All rights reserved.
 * Use of this source code is governed by a MIT-style
 * license that can be found in the LICENSE file.
 * https://studygolang.com
 * Author:polaris	polaris@studygolang.com
 */

package main

import (
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"github.com/spf13/viper"

	"gitea.com/zsxq/jianshu/global"
	"gitea.com/zsxq/jianshu/http/controller"
)

func init() {
	global.Init()
}

func main() {

	e := echo.New()

	e.Use(middleware.Logger())

	// 服务静态文件
	e.Static("/static", "static")

	frontGroup := e.Group("")
	controller.RegisterRoutes(frontGroup)

	viper.SetDefault("http.port", "2019")
	host := viper.GetString("http.host")
	port := viper.GetString("http.port")

	addr := host + ":" + port

	e.Logger.Fatal(e.Start(addr))
}
