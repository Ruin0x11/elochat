# -*- coding: cp932 -*-
require "sinatra/reloader"

require "./models/init.rb"
require "./routes/init.rb"

class Elochat < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :show_exceptions, false
  set :raise_errors, true

  before do
    content_type "text/plain;charset=shift_jis"
  end

  configure :development do
    register Sinatra::Reloader
    enable :logging, :dump_errors, :raise_errors
  end

  error Sinatra::NotFound do
    "Not found"
  end

  error do
    env["sinatra.error"].errors
  end
end
