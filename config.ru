$LOAD_PATH << File.dirname(File.expand_path(__FILE__))
require "rubygems"
require "./config/environment"
require "./elochat.rb"

run Elochat
