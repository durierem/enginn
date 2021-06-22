# frozen_string_literal: true

require 'json'

module Enginn
  module JSON
    # Internal: Same as JSON.parse but returns nil instead of raising a JSON::ParserError.
    def self.safe_parse(...)
      ::JSON.parse(...)
    rescue ::JSON::ParserError
      nil
    end
  end
end
