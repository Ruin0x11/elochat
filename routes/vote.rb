# -*- coding: cp932 -*-

class Elochat < Sinatra::Base
  get "/text.txt" do
    <<END
<!--START-->
%
fGศูผReXg๔1  [PลฉฎZbg]%
Your favorite alias๔1  [Auto reset every month]%
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
