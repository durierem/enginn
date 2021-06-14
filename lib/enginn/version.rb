# frozen_string_literal: true

module Enginn
  VERSION = begin
    `git describe --always --tag 2> /dev/null`.chomp
  rescue StandardError
    'N/A'
  end
end
