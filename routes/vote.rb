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
    VoteHistory.vote(:jp)
  end

  get "/voteen.txt" do
    VoteHistory.vote(:en)
  end
end
