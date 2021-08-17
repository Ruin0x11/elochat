# -*- coding: cp932 -*-

class Elochat < Sinatra::Base
  def log(lang)
    resp = "#{ChatMessage.latest_id(lang)}<C>\n<!--START-->\n"
    ChatMessage.most_recent(lang).each do |mes|
      resp << mes.to_s.encode("sjis")
    end
    resp << "<!--END-->\n<!-- WebTalk v1.6 --><center><small><a href='http://www.kent-web.com/' target='_top'>WebTalk</a></small></center>"
    resp
  end

  get "/log.txt" do
    log(:jp)
  end

  get "/logen.txt" do
    log(:en)
  end

  def create_message(language)
    comment = params["comment"]
    kind = comment[0..3]
    text = comment[4..-1]
    ip_address = (settings.record_ip_addrs && request.ip) || ""

    halt 400 unless ChatMessage.kinds.key? kind

    mes = ChatMessage.create(kind: kind, text: text, language: language, ip_address: ip_address)

    webhook_client = settings.webhook_clients[language]
    if webhook_client
      webhook_client.execute do |builder|
        builder.content = "__#{mes.date_string}:__ #{mes.text}"
      end
    end
  end

  get "/cgi-bin/wtalk/wtalk2.cgi" do
    if params["mode"] == "regist"
      create_message :jp
    else
      halt 400
    end
  end

  get "/cgi-bin/wtalken/wtalk2.cgi" do
    if params["mode"] == "regist"
      create_message :en
    else
      halt 400
    end
  end
end
