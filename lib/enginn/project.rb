# frozen_string_literal: true

require_relative 'resource'

module Enginn
  class Project < Resource
    resource 'project', only: :get

    def self.patch(attributes)
      Enginn.request(:patch, 'project', attributes: attributes)
    end
  end
end
