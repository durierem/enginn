# Enginn API - Ruby Wrapper

## Setup

```ruby
require 'enginn'

Enginn.configure do |config|
  config.api_token = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  config.base_url  = 'https://example.com/api/v1'
end
```

## Usage

```ruby
Enginn.request(:get, 'project')

Enginn.request(:patch, 'colors', id: 42, attributes: { name: 'blue'} )
```

## Custom requests

```ruby
# Enginn.connect! yields a Faraday::Connection object
Enginn.connect! do |conn|
  conn.post('characters') do |req|
    req.body = { character: { name: 'General Grievous' } }
  end
end
```
