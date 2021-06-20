# frozen_string_literal: true

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

require 'rubocop/rake_task'

RuboCop::RakeTask.new

task default: %i[spec rubocop]

desc 'Build the gem.'
task :build do
  sh 'gem build enginn.gemspec'
end

desc 'Build and install the gem.'
task install: [:build] do
  sh 'gem install *.gem'
end

desc 'Clean built gems.'
task :clean do
  rm FileList['*.gem']
end
