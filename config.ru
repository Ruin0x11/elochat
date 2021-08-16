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

run Elochat
