# frozen_string_literal: true

require_relative 'resource'

module Enginn
  class CharacterSynthesis < Resource
    resource 'characters_syntheses', only: %i[get post]
  end
end
