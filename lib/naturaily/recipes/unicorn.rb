Capistrano::Configuration.instance.load do

  pretty_log('deploy:restart', 'Restarting unicorn master process')
  pretty_log('deploy:start', 'Starting unicorn master process')
  pretty_log('deploy:stop', 'Stoping unicorn master process')

  namespace :deploy do
    desc "Restart the master unicorn process"
    task :restart , :roles => :app do
      run "BUNDLE_GEMFILE=#{current_path}/Gemfile /etc/init.d/unicorn_#{application} restart"
    end

    desc "Start the master unicorn process"
    task :start , :roles => :app do
      run "BUNDLE_GEMFILE=#{current_path}/Gemfile /etc/init.d/unicorn_#{application} start"
    end

    desc "Stop the master unicorn process"
    task :stop , :roles => :app do
      run "BUNDLE_GEMFILE=#{current_path}/Gemfile /etc/init.d/unicorn_#{application} stop"
    end
  end

end
