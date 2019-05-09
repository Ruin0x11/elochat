# -*- coding: cp932 -*-

class Elochat < Sinatra::Base
  get "/log.txt" do
    resp = "#{ChatMessage.latest_id}<C>\n<!--START-->\n"
    ChatMessage.most_recent.each do |mes|
      resp << mes.to_s
    end
    resp << "<!--END-->\n<!-- WebTalk v1.6 --><center><small><a href='http://www.kent-web.com/' target='_top'>WebTalk</a></small></center>"
    resp
  end
end
