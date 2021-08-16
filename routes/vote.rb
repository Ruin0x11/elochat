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

  def vote(lang)
    resp = ""
    VoteHistory.current_votes(lang).each do |vote|
      resp << vote.id.to_s << "<>" << vote.to_s.encode("sjis")
    end
    resp
  end

  get "/vote.txt" do
    vote(:jp)
  end

  get "/voteen.txt" do
    vote(:en)
  end

  def create_vote_user(lang)
    name = params["vote"]

    user = VoteUser.find_or_initialize_by(name: name) do |u|
      u.total_vote_count = 0
      u.reset_at = DateTime.now
    end

    user.ip_address = (settings.record_ip_addrs && request.ip) || ""

    hist = VoteHistory.current(lang)
    vote = Vote.find_or_initialize_by(vote_user: user, vote_history: hist) do |v|
      v.vote_count = 0
    end

    vote.save!
    user.save!
  end

  def create_vote(lang)
    number = params["namber"].to_i # this is now a database ID

    vote = VoteHistory.find_vote(lang, number)
    halt 400 if vote.nil?

    vote.vote_count += 1
    vote.save!
  end

  get "/cgi-bin/vote/votec.cgi" do
    language = if params["no"] == "1" then :jp else :en end

    if params["mode"] == "wri"
      if params.key? "vote"
	create_vote_user language
      elsif params.key? "namber"
	create_vote language
      else
	halt 400
      end
    else
      halt 400
    end
  end
end
