# frozen_string_literal: true

require 'json'

module JSON
  def self.safe_parse(source)
    parse(source, symbolize_names: true)
  rescue JSON::ParserError
    nil
  end
end
