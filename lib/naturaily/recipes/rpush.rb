Capistrano::Configuration.instance.load do
  after 'deploy:stop', 'rpush:stop'
  after 'deploy:start', 'rpush:start'
  after 'deploy:restart', 'rpush:restart'

  _cset(:rpush_pid) {"#{current_path}/tmp/pids/rpush.pid"}

  pretty_log('rpush:reload', 'Reloading rpush daemon')
  pretty_log('rpush:start', 'Starting rpush daemon')
  pretty_log('rpush:stop', 'Stoping rpush daemon')

  namespace :rpush do
    desc "Manual restart rpush daemon"
    task :restart do
      stop
      start
    end

    desc "Reload rpush daemon"
    task :reload do
      run "kill -HUP `cat #{rpush_pid}`"
    end

    desc "Start rpush daemon"
    task :start do
      run "cd #{current_path} && bundle exec rpush #{rails_env} -p #{rpush_pid}"
    end

    desc "Stop rpush daemon"
    task :stop do
      run "if [ -f #{rpush_pid} ]; then kill -9 `cat #{rpush_pid}`; fi"
    end

  end
end
