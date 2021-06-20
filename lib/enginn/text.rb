# frozen_string_literal: true

require_relative 'resource'

module Enginn
  class Text < Resource
    resource 'texts', only: %i[get patch delete]
  end
end
