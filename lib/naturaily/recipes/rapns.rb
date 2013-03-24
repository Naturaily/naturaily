Capistrano::Configuration.instance.load do
  after 'deploy:stop', 'rapns:stop'
  after 'deploy:start', 'rapns:start'
  after 'deploy:restart', 'rapns:restart'

  _cset(:rapns_pid) {"#{current_path}/tmp/pids/rapns.pid"}

  pretty_log('rapns:reload', 'Reloading rapns daemon')
  pretty_log('rapns:start', 'Starting rapns daemon')
  pretty_log('rapns:stop', 'Stoping rapns daemon')

  namespace :rapns do
    desc "Manual restart rapns daemon"
    task :restart do
      stop
      start
    end

    desc "Reload rapns daemon"
    task :reload do
      run "kill -HUP `cat #{rapns_pid}`"
    end

    desc "Start rapns daemon"
    task :start do
      run "cd #{current_path} && bundle exec rapns #{rails_env} -p #{rapns_pid}"
    end

    desc "Stop rapns daemon"
    task :stop do
      run "if [ -f #{rapns_pid} ]; then kill -9 `cat #{rapns_pid}`; fi"
    end

  end
end
