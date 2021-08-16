# -*- coding: cp932 -*-
require "sinatra/reloader"
require "sinatra/activerecord"

require "./models/init"
require "./routes/init"
require "./lib/webrick_monkey_patch"

class Elochat < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  enable :raise_errors
  disable :show_exceptions, :record_ip_addrs

  before do
    content_type "text/plain;charset=shift_jis"
  end

  configure :development do
    register Sinatra::Reloader
    enable :logging, :dump_errors, :show_exceptions
  end

  error Sinatra::NotFound do
    "Not found"
  end

  error do
    env["sinatra.error"].errors
  end
end
