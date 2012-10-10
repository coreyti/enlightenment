#!/usr/bin/env rake

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

begin
  require 'rdoc/task'
rescue LoadError
  require 'rdoc/rdoc'
  require 'rake/rdoctask'
  RDoc::Task = Rake::RDocTask
end

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Enlightenment'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Bundler::GemHelper.install_tasks

task :default => :spec

desc 'run the spec suite'
task :spec => [:'spec:ruby', :'spec:javascript']

desc 'run the ruby spec suite'
task :'spec:ruby' do
  system 'rspec spec'
end

desc 'run the javascript spec suite'
task :'spec:javascript' do
  system 'cd spec/dummy && rake jasminerice:run'
end
