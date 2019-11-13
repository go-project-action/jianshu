/*
 * Copyright (c) 2019. The StudyGolang Authors. All rights reserved.
 * Use of this source code is governed by a MIT-style
 * license that can be found in the LICENSE file.
 * https://studygolang.com
 * Author:polaris	polaris@studygolang.com
 */

package global

import (
	"flag"
	"fmt"
	"math/rand"
	"sync"
	"time"

	"github.com/spf13/viper"
)

var once = new(sync.Once)

var (
	config    = flag.String("config", "config", "配置文件名称，默认 config")
)

func Init() {
	once.Do(func() {
		if !flag.Parsed() {
			flag.Parse()
		}

		rand.Seed(time.Now().UnixNano())

		viper.SetConfigName(*config)
		viper.AddConfigPath("/etc/jianshu/")
		viper.AddConfigPath("$HOME/.jianshu")
		viper.AddConfigPath(App.RootDir + "/config")
		err := viper.ReadInConfig()
		if err != nil {
			panic(fmt.Errorf("Fatal error config file: %s \n", err))
		}

		App.fillOtherField()
	})
}
