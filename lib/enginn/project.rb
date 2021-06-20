# frozen_string_literal: true

require_relative 'resource'

module Enginn
  class Project < Resource
    resource 'project', only: :get
  end
end
