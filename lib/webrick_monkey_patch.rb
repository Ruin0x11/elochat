# Monkey patch to get around the fact that vanilla elona will encode
# messages in URL params as Shift-JIS, which fails to parse under
# URI::Parser (ugh), and will also confuse WEBrick as it expects UTF-8
# URIs.
require "webrick/httprequest"
require 'addressable/uri'

class WEBrick::HTTPRequest
  def parse_uri(str, scheme="http")
    if @config[:Escape8bitURI]
      str = HTTPUtils::escape8bit(str)
    end
    str.sub!(%r{\A/+}o, '/')

    # Always assume URI is Shift-JIS.
    str = str.force_encoding("sjis").encode("utf-8")
    uri = Addressable::URI::parse(str)

    return uri if uri.absolute?

    if @forwarded_host
      host, port = @forwarded_host, @forwarded_port
    elsif self["host"]
      pattern = /\A(#{URI::REGEXP::PATTERN::HOST})(?::(\d+))?\z/n
      host, port = *self['host'].scan(pattern)[0]
    elsif @addr.size > 0
      host, port = @addr[2], @addr[1]
    else
      host, port = @config[:ServerName], @config[:Port]
    end

    uri.scheme = @forwarded_proto || scheme
    uri.host = host
    uri.port = port ? port.to_i : nil

    # Instead of doing URI.parse(uri.to_s), return the earlier URI.
    return uri
  end
end
