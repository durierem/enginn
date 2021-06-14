# frozen_string_literal: true

module Enginn
  class ConfigError < StandardError
  end

  class Config
    attr_accessor :base_url, :api_token
  end
end
