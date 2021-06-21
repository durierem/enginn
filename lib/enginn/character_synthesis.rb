# frozen_string_literal: true

require_relative 'resource'

module Enginn
  class CharacterSynthesis < Resource
    resource 'character_syntheses', only: %i[get post]
  end
end
