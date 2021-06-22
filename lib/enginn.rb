# frozen_string_literal: true

require 'active_support/core_ext/string'
require 'faraday'

require_relative 'enginn/character'
require_relative 'enginn/character_synthesis'
require_relative 'enginn/color'
require_relative 'enginn/config'
require_relative 'enginn/json'
require_relative 'enginn/project'
require_relative 'enginn/test_synthesis'
require_relative 'enginn/text'
require_relative 'enginn/version'

module Enginn
  class << self
    attr_accessor :config

    # Public: Configure Enginn.
    #
    # Yields an Enginn::Config object.
    def configure(&block)
      @config ||= Config.new
      block.call(@config)
    end

    # Public: Open a connection to the API with the required headers.
    #
    # The headers already defined are:
    #   - Content-Type: application/json
    #   - Authorization: Bearer <your_token>
    #
    # Yields a Faraday::Connection object.
    def connect!(&block)
      check_configuration

      connection = Faraday.new(url: @config.base_url, headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{@config.api_token}"
      })

      block.call(connection)
    end

    # Public: Send a request to the API with the given parameters.
    #
    # method     - The Symbol HTTP method to use.
    # resource   - The String type of resource to fetch (/api/v1/<resource>).
    # id         - The Integer ID of the resource to fetch (default: nil).
    # attributes - The Hash attributes given as the request body (default: nil).
    #
    # Examples
    #
    #   request(:get, 'colors')
    #   request(:patch, 'colors', id: 12, attributes: { name: 'yellow' })
    #   request(:delete, 'colors', id: 12)
    #
    # Returns a Hash with symbolized keys reprensenting the API response.
    def request(method, resource, id: nil, attributes: nil)
      check_configuration

      response = Enginn.connect! do |conn|
        conn.public_send(method, "#{resource}/#{id}") do |req|
          req.body = { resource.to_s.singularize => attributes }.to_json
        end
      end

      Enginn::JSON.safe_parse(response.body, symbolize_names: true)
    end

    private

    def check_configuration
      raise Enginn::ConfigError, 'unconfigured' if @config.nil?
      raise Enginn::ConfigError, 'missing @base_url in config' if @config.base_url.nil?
      raise Enginn::ConfigError, 'missing @api_token in config' if @config.api_token.nil?
    end
  end
end
