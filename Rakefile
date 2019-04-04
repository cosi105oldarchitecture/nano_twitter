require "bundler/gem_tasks"
task :default => :spec

require 'nano_twitter'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['test.rb']
  t.warning = false
end
