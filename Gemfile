source "https://rubygems.org"

gem "addressable", "~> 2.6"
gem "pg", "~> 1.1"
gem "rake", "~> 12.3"
gem "sinatra", "~> 2.0"
gem "sinatra-activerecord", "~> 2.0"
gem "rack", "~> 2.2"
gem 'discordrb', github: 'shardlab/discordrb', ref: '79568216389529fe69fa1d429dd7f9772dcd0fb8'
#gem "discordrb-webhooks", "~> 3.4"
gem "rack-attack", "~> 6.5"

group :test do
  gem "minitest", "~> 5.11"
end

group :development do
  gem "sinatra-reloader", "~> 1.0"
  gem "racksh", "~> 1.0"
end

group :development, :test do
  gem "byebug", "~> 11.0"
  gem "irb", "~> 1.0"
  gem "factory_bot", "~> 5.0"
end
