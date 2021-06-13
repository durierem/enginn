# frozen_string_literal: true

require 'active_support/core_ext/string'
require 'faraday'

require_relative 'enginn/config'
require_relative 'enginn/json'

module Enginn
  class << self
    # Public: Configure.
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
    # Returns a Hash reprensenting the API response.
    def request(method, resource, id: nil, attributes: nil)
      response = Enginn.connect! do |conn|
        conn.public_send(method, "#{resource}/#{id}") do |req|
          req.body = { resource.to_s.singularize => attributes }.to_json
        end
      end

      JSON.safe_parse(response.body)
    end
  end
end
