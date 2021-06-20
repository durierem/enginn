# Enginn

A Ruby wrapper for the [Enginn API](https://app.enginn.tech/api/docs).

## Installation

Clone and install manually using:

```sh
$ git clone https://github.com/durierem/enginn.git && cd enginn
$ rake install
```

## Usage

Configure the base URL and your authentication token:

```ruby
require 'enginn'

Enginn.configure do |config|
  config.api_token = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  config.base_url  = 'https://example.com/api/v1'
end
```

Use the available RESTful wrapper classes for ease of life:

```ruby
Enginn::Character.get                                     # Get the list of characters
Enginn::Character.get(42)                                 # Get the character of ID 42
Enginn::Color.post(name: 'perfect', code: '#21ce1e')      # Create a new color
Enginn::Character.patch(id: 42, name: 'Obi-Wan Kenobi')   # Update a character's attributes
Enginn::Text.delete(66)                                   # Delete the text of ID 66
```

Here is an exhaustive list of available classes and methods:

Resource | Available methods
-------- | -----------------
`Character` | `get`, `post`, `patch`, `delete`
`CharacterSynthesis` | `get`, `post`
`Color` | `get`, `post`, `patch`, `delete`
`Project` | `get`
`TestSynthesis` | `post`
`Text` | `get`, `patch`, `delete`

You can also directly use the top level `request` method:

```ruby
# Equivalent to Enginn::Project.get
Enginn.request(:get, 'project')

# Equivalent to Enginn::Color.patch(42, name: 'blue')
Enginn.request(:patch, 'colors', id: 42, attributes: { name: 'blue' })
```

## Custom requests

The gem uses Faraday to handle HTTP connections. Use the `connect!` method
to get a `Faraday::Connection` object. Refer to the
[Faraday documentation](https://lostisland.github.io/faraday/usage/)
for further informations about how to make custom requests. Note that `connect!`
already sets necessary headers such as `Content-Type` and `Authorization`.

```ruby
Enginn.connect! do |conn|
  conn.post('characters') do |req|
    req.body = { character: { name: 'General Grievous' } }
  end
end
```
