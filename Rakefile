require "./config/environment"
require './elochat'
require 'sinatra/activerecord/rake'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = "test/*_test.rb"
end

namespace :db do
  desc 'Drop, create, migrate then seed the development database'
  task reseed: [ 'db:drop', 'db:create', 'db:migrate', 'db:seed' ] do
    puts 'Reseeding completed.'
  end
end

namespace :elochat do
  desc 'Start a new voting history. (To be run at the 1st of each month)'
  task :new_vote do
    VoteHistory.new_vote
  end
end
