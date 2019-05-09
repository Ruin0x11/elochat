# -*- coding: cp932 -*-

class Elochat < Sinatra::Base
  get "/text.txt" do
    <<END
<!--START-->
%
素敵な異名コンテスト♪1  [１ヶ月で自動リセット]%
Your favorite alias♪1  [Auto reset every month]%
END
  end

  get "/vote.txt" do
    resp = ""
    VoteHistory.top_100.each_with_index do |vote, i|
      resp << (i + 1).to_s << "<>" << vote.to_s
    end
    resp
  end
end
