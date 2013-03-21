Capistrano::Configuration.instance.load do

  _cset(:thin_pid) {"#{shared_path}/pids/private_pub_thin.pid"}
  _cset(:thin_log) {"#{shared_path}/log/private_pub.log"}
  _cset(:thin_config) {"#{current_path}/config/private_pub_thin.yml"}

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
      run "cd #{deploy_to}/current && bundle exec rackup private_pub.ru -s thin -E #{rails_env} --pid #{current_path}/tmp/pids/faye.pid -D"
    end

    desc "Stop private pub/faye process"
    task :stop do
      run "kill -9 `cat #{deploy_to}/current/tmp/pids/faye.pid`"
    end
  end


  # NOTE: SSL support
  namespace :thin do
    desc "Restart private pub process"
    #FIXME: should check how to solve this problem
    task :restart do
      # run "cd #{deploy_to}/current && RAILS_ENV=production bundle exec thin -P #{thin_pid} -l #{thin_log} -C #{thin_config} -d restart"
      stop
      start
    end

    desc "Start private pub process"
    task :start do
      run "cd #{deploy_to}/current && RAILS_ENV=#{rails_env} bundle exec thin -P #{thin_pid} -l #{thin_log} -C #{thin_config} -d start"
    end

    desc "Stop private pub process"
    task :stop do
      run "cd #{deploy_to}/current && RAILS_ENV=#{rails_env} bundle exec thin -P #{thin_pid} -l #{thin_log} -C #{thin_config} -d stop"
    end
  end

end
