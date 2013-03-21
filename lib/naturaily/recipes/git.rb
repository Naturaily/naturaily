Capistrano::Configuration.instance.load do

  def current_branch
    branch = `git symbolic-ref HEAD 2> /dev/null`.strip.gsub(/^refs\/heads\//, '')
    logger.trace "Deploying branch #{branch.red}"
    branch
  end

end
