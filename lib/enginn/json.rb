# frozen_string_literal: true

require 'json'

module JSON
  # Internal: Parse source as JSON.
  # Similiar to JSON.parse but returns nil instead of raising a JSON::ParserError. It also symblize
  # keys for convenience.
  #
  # Returns a Hash representing the JSON or nil.
  def self.safe_parse(source)
    parse(source, symbolize_names: true)
  rescue JSON::ParserError
    nil
  end
end
