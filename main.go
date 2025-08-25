package util

import (
	"fmt"
	"time"
	"regexp"
	"os"
)

func log(t string, m string){
	l := "INF"
	switch {
		case regexp.MustCompile(`(?i)DEBUG|DBG|DEB`).MatchString(t): l = "DBG"
		case regexp.MustCompile(`(?i)INFO|INF|IN`).MatchString(t): l = "INF"
		case regexp.MustCompile(`(?i)WARNING|WARN|WRN`).MatchString(t): l = "WRN"
		case regexp.MustCompile(`(?i)ERROR|ERR`).MatchString(t): l = "ERR"
		case regexp.MustCompile(`(?i)START`).MatchString(t): l = fmt.Sprintf("starting %s v%s", os.Getenv("APP_NAME"), os.Getenv("APP_VERSION"))
		case regexp.MustCompile(`(?i)PATCH|FIX`).MatchString(t): l = "FIX"
	}
	fmt.Printf(`{"time":"%s","type":"%s","msg":"%s"}` + "\n", time.Now().Format("2006-01-02T15:04:05.000Z"), l, m)
}