package conf

import (
	"fmt"
	"os"

	"github.com/spf13/pflag"
	"github.com/spf13/viper"
)

func ReadConf() {
	viper.SetConfigName("application") // name of config file (without extension)
	viper.SetConfigType("yaml")        // REQUIRED if the config file does not have the extension in the name
	viper.AddConfigPath(".")           // optionally look for config in the working directory

	viper.AutomaticEnv()
}

func ParseCliOpts() {
	pflag.StringP("webex_message", "m", "", "The message to send (mandatory)")
	pflag.StringP("webex_channel", "c", "", "The channel to send to. Without hashtag, please (mandatory)")
	pflag.StringP("webex_alias", "a", "Friendly Bot", "The Name of the Sender")
	pflag.StringP("webex_emoji", "e", ":robot:", "A Emoji to use as the avatar")
	pflag.StringP("webex_token", "t", "", "An access token generated in Rocketcha. (mandatory)")
	pflag.StringP("webex_url", "u", "https://webexapis.com/v1/messages", "The Webex URL with http(s)")

	pflag.Parse()
	viper.BindPFlags(pflag.CommandLine)

	if viper.GetString("webex_message") == "" {
		fmt.Println("Please add a message to send")
		pflag.PrintDefaults()
		os.Exit(1)
	}

	if viper.GetString("webex_channel") == "" {
		fmt.Println("Please add a channel to send the message to")
		pflag.PrintDefaults()
		os.Exit(1)
	}

	if viper.GetString("webex_token") == "" {
		fmt.Println("Please add a token")
		pflag.PrintDefaults()
		os.Exit(1)
	}
}
