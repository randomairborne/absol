package main

import (
	"github.com/bwmarrin/discordgo"
	"github.com/randomairborne/absol/api"
	"github.com/randomairborne/absol/api/logger"
	"github.com/randomairborne/absol/modules/alert"
	"github.com/randomairborne/absol/modules/cleaner"
	"github.com/randomairborne/absol/modules/factoids"
	"github.com/randomairborne/absol/modules/hjt"
	"github.com/randomairborne/absol/modules/log"
	"github.com/randomairborne/absol/modules/twitch"
	"strings"
)

var loadedModules = make(map[string]api.Module, 0)

func LoadModule(ds *discordgo.Session, modules []string) {
	for _, v := range modules {
		logger.Out().Printf("Loading %s\n", v)
		switch strings.ToLower(v) {
		case "twitch":
			loadedModules["twitch"] = &twitch.Module{}
		case "cleaner":
			loadedModules["cleaner"] = &cleaner.Module{}
		case "alert":
			loadedModules["alert"] = &alert.Module{}
		case "log":
			loadedModules["log"] = &log.Module{}
		case "factoids":
			loadedModules["factoids"] = &factoids.Module{}
		case "hjt":
			loadedModules["hjt"] = &hjt.Module{}
		default:
			logger.Err().Printf("No logger with name %s\n", v)
		}
	}

	for k, v := range loadedModules {
		v.Load(ds)
		logger.Out().Printf("Loaded %s\n", k)
	}
}
