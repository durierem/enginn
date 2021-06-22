# frozen_string_literal: true

require 'json'

module JSON
  # Internal: Same as JSON.parse but returns nil instead of raising a JSON::ParserError.
  def self.safe_parse(...)
    parse(...)
  rescue JSON::ParserError
    nil
  end
end
