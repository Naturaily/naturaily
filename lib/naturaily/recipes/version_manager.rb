Capistrano::Configuration.instance.load do

  _cset :version_manager, [:rbenv]

  on :start, only: :deploy do
    set_version_manager
  end

  def set_version_manager
    manager, options = self.version_manager

    case manager
    when :rbenv
      _cset :default_environment, {'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"}
    when :rvm
      require 'rvm/capistrano'

      _cset(:rvm_type, options[:type]) if options[:type]
      _cset(:rvm_ruby_string, options[:version]) if options[:version]
    end
  end

end
