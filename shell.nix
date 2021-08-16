#!/usr/bin/env nix-shell
with import <nixpkgs> {};
let
  # define packages to install with special handling for OSX
  inputs = [
    ruby_2_7
    postgresql
  ];

  # define shell startup command
  hooks = ''
    export LANG=en_US.UTF-8
    mkdir -p postgres/
    export PGDATA="$PWD/postgres"
    export SOCKET_DIRECTORIES="$PWD/sockets"
    mkdir $SOCKET_DIRECTORIES
    initdb
    echo "unix_socket_directories = '$SOCKET_DIRECTORIES'" >> $PGDATA/postgresql.conf
    pg_ctl -l $PGDATA/logfile start
    createuser postgres --createdb -h localhost
    function end {
      echo "Shutting down the database..."
      pg_ctl stop
      echo "Removing directories..."
      rm -rf $PGDATA $SOCKET_DIRECTORIES
    }
    trap end EXIT
  '';

in mkShell {
  buildInputs = inputs;
  shellHook = hooks;
}
