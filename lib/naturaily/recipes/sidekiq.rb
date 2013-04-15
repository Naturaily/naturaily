Capistrano::Configuration.instance.load do
  require 'sidekiq/capistrano'

  pretty_log('sidekiq:stop', 'Stoping sidekiq daemon')
  pretty_log('sidekiq:start', 'Starting sidekiq daemon')
  pretty_log('sidekiq:quiet', 'Quieting sidekiq daemon (stop accepting new work)')
end
