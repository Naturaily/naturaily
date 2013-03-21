Capistrano::Configuration.instance.load do
  after 'deploy:finalize_update', 'common:create_symlinks'

  _cset :symlinks, []

  namespace :common do
    def symlink_cmd(table)
      cmd = ["cd #{release_path}"]

      (table + symlinks).each do |link|
        clean = link[:clean] ? "rm -rf #{release_path}/#{link[:dest]}" : nil
        base = "ln -nfs #{shared_path}/#{link[:source]} #{release_path}/#{(link[:dest] || link[:source])}"

        cmd << clean << base
      end

      cmd.compact.join(" && ")
    end

    task :create_symlinks, :except => {:no_symlink => true} do
      links_table = [
        {source: 'config/database.yml'},
        {source: 'config/unicorn.rb'},
        {source: 'log'},
        {soruce: 'pids', dest: 'tmp/pids', clean: true}
      ]

      run symlink_cmd(links_table)
      logger.trace "Create symlinks. %s" % 'Done.'.green
    end
  end
end
