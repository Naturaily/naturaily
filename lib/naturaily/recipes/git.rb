Capistrano::Configuration.instance.load do

  def current_branch
    `git symbolic-ref HEAD 2> /dev/null`.strip.gsub(/^refs\/heads\//, '')
  end

end
