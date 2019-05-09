# -*- coding: cp932 -*-

class Elochat < Sinatra::Base
  get "/text.txt" do
    <<END
<!--START-->
%
�f�G�Ȉٖ��R���e�X�g��1  [�P�����Ŏ������Z�b�g]%
Your favorite alias��1  [Auto reset every month]%
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
