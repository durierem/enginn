# frozen_string_literal: true

require 'json'

module JSON
  module_function

  def safe_parse(source)
    JSON.parse(source, symbolize_names: true)
  rescue JSON::ParserError
    nil
  end
end
