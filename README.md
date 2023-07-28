# Cisco Webex-Notifier

A simple binary to send messages to a Webex channel.

# Getting Started

Follow these instructions to get the webex-notifier up and running on your local machine.

## Prerequisites

* Golang 1.19 or later
* Access to Webex and a Token

## Installation

### Download the binary

Just download the binary from the releases-page and execute it.

### Use the provided Container

You can use the provider container:

     docker run ghcr.io/telekom-mms/webex-notifier

### Manually

Clone the webex-notifier repository:

    git clone https://github.com/telekom-mms/webex-notifier.git
    cd webex-notifier

Install the required Go packages using go mod:

    go mod download

Build the tool:

    go build

## Usage

```
webex-notifier
  -c, --webex_channel string   The channel to send to. Without hashtag, please (mandatory)
  -m, --webex_message string   The message to send (mandatory)
  -t, --webex_token string     An access token generated in webex. (mandatory)
  -u, --webex_url string       The Webex URL with http(s) (default "https://webexapis.com/v1/messages")
```

## Contributing

Contributions to webex-notifier are welcome! Please follow these steps:

* Fork the repository on GitHub.
* Make your changes in a new branch.
* Create a pull request with a clear description of your changes.
* We will review and merge your contribution if applicable.

## License

This project is licensed under the GPLv3 - see the LICENSE file for details.
