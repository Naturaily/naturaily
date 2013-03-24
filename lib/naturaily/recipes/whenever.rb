Capistrano::Configuration.instance.load do
  require 'whenever/capistrano'

  pretty_log('whenever:update_crontab', 'Updating crontab tasks')
end
