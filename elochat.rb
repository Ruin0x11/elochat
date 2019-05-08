# -*- coding: cp932 -*-
require "rubygems"
require "bundler"

Bundler.require

class Elochat < Sinatra::Base
  register Sinatra::ActiveRecordExtension
end

get "/log.txt" do
  content_type 'text/plain;charset=shift_jis'
  id = 1
  resp = "#{id}<C>\n<!--START-->\n"
  10.times do |i|
    resp << i.to_s << '%' << DateTime.now.to_time.to_i.to_s << '%' << 1.to_s << "test" << '%' << "0.0.0.0" << "%\n"
  end
  resp << "<!--END-->\n<!-- WebTalk v1.6 --><center><small><a href='http://www.kent-web.com/' target='_top'>WebTalk</a></small></center>"
  resp
end

get "/text.txt" do
  content_type 'text/plain;charset=shift_jis'
  "<!--START-->\n%\n素敵な異名コンテスト♪1  [１ヶ月で自動リセット]%\nYour favorite alias♪1  [Auto reset every month]%"
end

get "/vote.txt" do
  content_type 'text/plain;charset=shift_jis'
  resp = ""
  10.times do |i|
    resp << 1.to_s << '<>' << "ruin" << '<>' << 10.to_s << '<>' << "0.0.0.0" << '<>' << DateTime.now.to_time.to_i.to_s << '#' << 100.to_s << '#' << '1' << "#<>\n"
  end
  resp
end
