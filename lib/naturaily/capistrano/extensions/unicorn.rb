Capistrano::Configuration.instance.load do

  namespace :deploy do
    desc "Restart the master unicorn process"
    task :restart , :roles => :app do
      run "/etc/init.d/unicorn_#{application} restart"
    end

    desc "Start the master unicorn process"
    task :start , :roles => :app do
      run "/etc/init.d/unicorn_#{application} start"
    end

    desc "Stop the master unicorn process"
    task :stop , :roles => :app do
      run "/etc/init.d/unicorn_#{application} stop"
    end
  end

end
