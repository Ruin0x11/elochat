root = "/app/elochat"
app_dir = Dir.getwd

bind "unix://#{root}/tmp/puma/socket"
pidfile "#{root}/tmp/puma/pid"
state_path "#{root}/tmp/puma/state"
rackup "#{app_dir}/config.ru"
stdout_redirect "#{root}/log/stdout.log", "/#{root}/log/stderr.log", true

workers 2
threads 1, 6

rack_env = ENV['RACK_ENV'] || "production"
environment rack_env

on_worker_boot do
  require "active_record"
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rack_env])
end

activate_control_app
