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
    VoteHistory.vote(:jp)
  end

  get "/voteen.txt" do
    VoteHistory.vote(:en)
  end
end
