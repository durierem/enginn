# frozen_string_literal: true

require_relative 'resource'

module Enginn
  class TestSynthesis < Resource
    resource 'test_syntheses', only: :post
  end
end
