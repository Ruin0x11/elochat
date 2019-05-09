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
    VoteHistory.vote(:jp)
  end

  get "/voteen.txt" do
    VoteHistory.vote(:en)
  end
end
