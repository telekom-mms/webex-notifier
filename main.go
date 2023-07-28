package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"webex-notifier/conf"

	"github.com/spf13/viper"
)

func main() {
	conf.ReadConf()
	conf.ParseCliOpts()

	type payloadStruct struct {
		RoomId   string `json:"roomId"`
		Markdown string `json:"markdown"`
	}

	host := viper.GetString("webex_url")

	var payload = payloadStruct{
		RoomId:   viper.GetString("webex_channel"),
		Markdown: viper.GetString("webex_message"),
	}

	payloadJson, err := json.Marshal(payload)
	if err != nil {
		panic(err.Error())
	}

	req, _ := http.NewRequest("POST", host, bytes.NewBuffer(payloadJson))
	if err != nil {
		fmt.Print(err)
	}

	req.Header.Add("content-type", "application/json")
	req.Header.Add("Authorization", "Bearer "+viper.GetString("webex_token"))

	res, err := http.DefaultClient.Do(req)
	if err != nil {
		panic(err.Error())
	}

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
