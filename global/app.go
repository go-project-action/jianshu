/*
 * Copyright (c) 2019. The StudyGolang Authors. All rights reserved.
 * Use of this source code is governed by a MIT-style
 * license that can be found in the LICENSE file.
 * https://studygolang.com
 * Author:polaris	polaris@studygolang.com
 */

package global

import (
	"os"
	"path/filepath"
	"sync"
	"time"

	"github.com/spf13/viper"

	"gitea.com/zsxq/jianshu/util"
)

func init() {
	App.Version = "V1.0"
	App.LaunchTime = time.Now()

	App.RootDir = "."

	if !viper.InConfig("http.port") {
		App.RootDir = inferRootDir()
	}
	App.TemplateDir = App.RootDir + "/template/"

	fileInfo, err := os.Stat(os.Args[0])
	if err != nil {
		panic(err)
	}

	App.Date = fileInfo.ModTime()
}

func inferRootDir() string {
	cwd, err := os.Getwd()
	if err != nil {
		panic(err)
	}
	var infer func(d string) string
	infer = func(d string) string {
		if util.Exist(d + "/config") {
			return d
		}

		return infer(filepath.Dir(d))
	}

	return infer(cwd)
}

var App = &app{}

type app struct {
	Name    string
	Version string
	Date    time.Time

	// 项目根目录
	RootDir string
	// 模板根目录
	TemplateDir string

	// 启动时间
	LaunchTime time.Time
	Uptime     time.Duration

	Domain string
	SEO map[string]string

	locker sync.Mutex
}

func (a *app) SetUptime() {
	a.locker.Lock()
	defer a.locker.Unlock()
	a.Uptime = time.Now().Sub(a.LaunchTime)
}

func (a *app) fillOtherField() {
	a.Name = viper.GetString("name")
	a.Domain = viper.GetString("domain")
	a.SEO = viper.GetStringMapString("seo")
}
