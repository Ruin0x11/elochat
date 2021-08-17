module Puma
  module Request
    # Given a Hash +env+ for the request read from +client+, add
    # and fixup keys to comply with Rack's env guidelines.
    # @param env [Hash] see Puma::Client#env, from request
    # @param client [Puma::Client] only needed for Client#peerip
    # @todo make private in 6.0.0
    #
    def normalize_env(env, client)
      if host = env[HTTP_HOST]
        # host can be a hostname, ipv4 or bracketed ipv6. Followed by an optional port.
        if colon = host.rindex("]:") # IPV6 with port
          env[SERVER_NAME] = host[0, colon+1]
          env[SERVER_PORT] = host[colon+2, host.bytesize]
        elsif !host.start_with?("[") && colon = host.index(":") # not hostname or IPV4 with port
          env[SERVER_NAME] = host[0, colon]
          env[SERVER_PORT] = host[colon+1, host.bytesize]
        else
          env[SERVER_NAME] = host
          env[SERVER_PORT] = default_server_port(env)
        end
      else
        env[SERVER_NAME] = LOCALHOST
        env[SERVER_PORT] = default_server_port(env)
      end

      unless env[REQUEST_PATH]
        # it might be a dumbass full host request header
        uri = URI.parse(env[REQUEST_URI]) 
        env[REQUEST_PATH] = uri.path

        raise "No REQUEST PATH" unless env[REQUEST_PATH]

        # A nil env value will cause a LintError (and fatal errors elsewhere),
        # so only set the env value if there actually is a value.
        env[QUERY_STRING] = uri.query if uri.query
      end

      env[REQUEST_URI] = env[REQUEST_URI].dup.force_encoding("sjis").encode("utf-8")
      env[REQUEST_PATH] = env[REQUEST_PATH].dup.force_encoding("sjis").encode("utf-8")
      env[QUERY_STRING] = env[QUERY_STRING].dup.force_encoding("sjis").encode("utf-8")

      env[PATH_INFO] = env[REQUEST_PATH]

      # From https://www.ietf.org/rfc/rfc3875 :
      # "Script authors should be aware that the REMOTE_ADDR and
      # REMOTE_HOST meta-variables (see sections 4.1.8 and 4.1.9)
      # may not identify the ultimate source of the request.
      # They identify the client for the immediate request to the
      # server; that client may be a proxy, gateway, or other
      # intermediary acting on behalf of the actual source client."
      #

      unless env.key?(REMOTE_ADDR)
        begin
          addr = client.peerip
        rescue Errno::ENOTCONN
          # Client disconnects can result in an inability to get the
          # peeraddr from the socket; default to localhost.
          addr = LOCALHOST_IP
        end

        # Set unix socket addrs to localhost
        addr = LOCALHOST_IP if addr.empty?

        env[REMOTE_ADDR] = addr
      end
    end
  end
end
