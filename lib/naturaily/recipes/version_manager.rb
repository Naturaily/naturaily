Capistrano::Configuration.instance.load do

  def version_manager(manager, options = {})
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
