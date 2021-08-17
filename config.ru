$LOAD_PATH << File.dirname(File.expand_path(__FILE__))
require "rubygems"
require "./config/environment"
require "./elochat.rb"

# The way Elona encodes URIs is not spec-compliant whatsoever.
module Rack
  class Lint
    def call(env = nil)
      @app.call(env)
    end
  end
end

log = File.new("/app/elochat/log/stdout.log", "a+")
$stdout.reopen(log)
$stdout.sync = true

log = File.new("/app/elochat/log/stderr.log", "a+")
$stderr.reopen(log)
$stderr.sync = true

run Elochat
