Capistrano::Configuration.instance.load do
  after 'deploy:finalize_update', 'common:create_symlinks'

  _cset :symlinks, []
  _cset :shared_children, %w(public/system log tmp/pids pids config)

  pretty_log('deploy:update_code', 'Updating base code')
  pretty_log('bundle:install', 'Updating bundle')
  pretty_log('common:create_symlinks', 'Creating symlinks')
  pretty_log('deploy:assets:precompile', 'Updating assets')
  pretty_log('deploy:cleanup', 'Cleaning up')

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
      common_symlinks = [
        {source: 'config/database.yml'},
        {source: 'log'},
        {soruce: 'pids', dest: 'tmp/pids', clean: true}
      ]

      run symlink_cmd(common_symlinks)
      logger.trace "Create symlinks. %s" % 'Done.'.green
    end
  end
end
