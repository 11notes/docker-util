package container

import (
	"errors"
	"os"
	"io/ioutil"
	"strings"
	"regexp"
	"fmt"

	"github.com/11notes/go/util"
)

type Container struct{}
var(
	_util = util.Util{}
)

// tries to get a secret either from environment variable or from a secrets file set by environment variable
func (c *Container) GetSecret(env string, envPath string) (string, error){
	if value, ok := os.LookupEnv(env); ok {
		return value, nil
	}else{
		if value, ok := os.LookupEnv(envPath); ok {
			bytes, err := ioutil.ReadFile(value)
			if err != nil {
				return "", err
			}
			return strings.TrimSpace(string(bytes)), nil
		}else{
			return "", errors.New(env + " and " + envPath + " do not exist!")
		}
	}
}

// merges default parameters and user set parameters
func (c *Container) Command(d []string) []string{
	if(len(os.Args) > 0){
		args := os.Args[1:]
		for _, value := range args{
			d = append(d, value)
		}
	}
	return(d)
}

// replaces variables inside a file
func (c *Container) FileContentReplace(file string, r map[string]interface{}) error{
	// open file
	text, err := _util.ReadFile(file)
	if err != nil {
		return err
	}

	// replace all variables
	for key, value := range r{
		text = string(regexp.MustCompile(fmt.Sprintf(`\${%s}`, key)).ReplaceAllString(text, fmt.Sprintf("%s", value)))
	}

	// replace all not set variablse with empty string
	empty := regexp.MustCompile(`\$\{[A-Z_a-z]+\}`).FindAllString(text, -1)
	for _, e := range empty {
		text = string(regexp.MustCompile(fmt.Sprintf(`%s`, e)).ReplaceAllString(text, ""))
	}

	// write file
	err = _util.WriteFile(file, text)
	if err != nil {
		return err
	}

	return nil
}

// converts contents of an environment variable to a file
func (c *Container) EnvToFile(env string, path string) error{
	if value, ok := os.LookupEnv(env); ok {
		return _util.WriteFile(path, value)
	}else{
		return errors.New(env + " do not exist!")
	}
}