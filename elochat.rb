# -*- coding: cp932 -*-
require "sinatra/reloader"
require "sinatra/activerecord"
require "discordrb/webhooks"

require "./models/init"
require "./routes/init"

require "./lib/webrick_monkey_patch"

class Elochat < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  enable :raise_errors
  disable :show_exceptions

  # This is unused in the original code and also a privacy concern.
  disable :record_ip_addrs

  before do
    content_type "text/plain;charset=shift_jis"
  end

  configure :development do
    register Sinatra::Reloader
    enable :logging, :dump_errors, :show_exceptions
  end

  configure do
    webhook_en = ENV["DISCORD_WEBHOOK_EN"]
    webhook_jp = ENV["DISCORD_WEBHOOK_JP"]

    webhook_clients = {}

    if webhook_en
      webhook_clients[:en] = Discordrb::Webhooks::Client.new(url: webhook_en)
    end
    if webhook_jp
      webhook_clients[:jp] = Discordrb::Webhooks::Client.new(url: webhook_jp)
    end
      
    set :webhook_clients, webhook_clients
  end

  error Sinatra::NotFound do
    "Not found"
  end

  error do
    env["sinatra.error"].errors
  end
end
