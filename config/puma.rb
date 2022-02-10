# frozen_string_literal: true

max_threads_count = ENV.fetch("PUMA_MAX_THREADS", 5)
min_threads_count = ENV.fetch("PUMA_MIN_THREADS") { max_threads_count }

rails_env = ENV.fetch("RAILS_ENV", "development")

port(ENV.fetch("PUMA_PORT", 3000))
environment(rails_env)
threads(min_threads_count, max_threads_count)

if rails_env == "development"
  worker_timeout(3600)
  plugin(:tmp_restart)
else
  if ENV.key?("PUMA_WORKERS")
    workers(ENV["PUMA_WORKERS"])
  else
    require "etc"
    workers(Etc.nprocessors)
  end

  # bind_to_activated_sockets("only")
  preload_app!

  before_fork do |_server, _worker|
    if defined?(ActiveRecord::Base)
      ActiveRecord::Base.connection.disconnect!
    end
  end
end
