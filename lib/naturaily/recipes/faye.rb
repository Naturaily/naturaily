Capistrano::Configuration.instance.load do
  _cset(:faye_pid) {"#{shared_path}/pids/private_pub_thin.pid"}
  _cset(:faye_log) {"#{shared_path}/log/private_pub.log"}

  _cset(:ssl_config) {"#{current_path}/config/private_pub_thin.yml"}

  pretty_log('faye:stop', 'Stoping faye daemon')
  pretty_log('faye:start', 'Starting faye daemon')

  pretty_log('faye:ssl:stop', 'Stoping faye daemon with SSL support')
  pretty_log('faye:ssl:start', 'Starting faye daemon with SSL support')

  # NOTE: staging configuration
  namespace :faye do
    desc "Restart private pub process"
    #FIXME: should check how to solve this problem
    task :restart do
      stop
      start
    end


    desc "Start private pub/faye process"
    task :start do
      run "cd #{deploy_to}/current && bundle exec rackup private_pub.ru -s thin -E #{rails_env} --pid #{faye_pid} -D"
    end

    desc "Stop private pub/faye process"
    task :stop do
      run "kill -9 `cat #{faye_pid}`"
    end


    # NOTE: SSL support
    namespace :ssl do
      desc "Restart private pub process"
      #FIXME: should check how to solve this problem
      task :restart do
        stop
        start
      end

      desc "Start private pub process"
      task :start do
        run "cd #{deploy_to}/current && RAILS_ENV=#{rails_env} bundle exec thin -P #{faye_pid} -l #{faye_log} -C #{ssl_config} -d start"
      end

      desc "Stop private pub process"
      task :stop do
        run "cd #{deploy_to}/current && RAILS_ENV=#{rails_env} bundle exec thin -P #{faye_pid} -l #{faye_log} -C #{ssl_config} -d stop"
      end
    end
  end

end
