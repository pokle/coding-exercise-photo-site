
require 'rubocop/rake_task'
require 'rspec/core/rake_task'

RuboCop::RakeTask.new
RSpec::Core::RakeTask.new(:spec)

task :site do
  system __dir__ + '/generate.rb works.xml build/sample'
end

task default: [:spec, :rubocop, :site]
