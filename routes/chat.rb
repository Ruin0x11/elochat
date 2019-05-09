# -*- coding: cp932 -*-

class Elochat < Sinatra::Base
  get "/log.txt" do
    ChatMessage.most_recent(:jp)
  end

  get "/logen.txt" do
    ChatMessage.most_recent(:en)
  end
end
