# Okex

A Ruby wrapper for the [OKex API v1](https://www.okex.me/docs/zh/)

## Installation

```sh
gem install okex
```

## Usage

See https://www.okex.com/docs/zh/ for details.

### HTTP API

#### Example

```ruby
# configure
none
#  API
okex = Okex::Client.new(ok_access_key: 'aaa', ok_access_passphrase: 'bbb', secret_key: 'ccc')

okex.get_server_time
```

## Contributing

## License
