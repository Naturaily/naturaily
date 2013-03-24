# encoding: utf-8
Capistrano::Configuration.instance.load do
  STDOUT.sync

  OUTPUT_LENGTH = 40

  logger.level = Capistrano::Logger::IMPORTANT

  @custom_output = true

  # spinner stuff
  @spinner_running = false
  @chars = ['|', '/', '-', '\\']
  @spinner = Thread.new do
    loop do
      unless @spinner_running
        Thread.stop
      end
      print @chars[0]
      sleep(0.1)
      print "\b"
      @chars.push @chars.shift
    end
  end

  def start_spinner
    @spinner_running = true
    @spinner.wakeup
  end

  def stop_spinner
    @spinner_running = false
    print "\b"
  end

  on :exit do
    if @spinner_running
      stop_spinner()
      puts "✔".green
    end
  end

  def pretty_log(task, title, options = {})
    dots = OUTPUT_LENGTH - title.length

    return unless @custom_output

    before task do
      if @spinner_running
        stop_spinner()
        puts "✔".green
      end

      print "---> #{title + '.' * dots}"
      start_spinner()
    end
  end

  log_formatter [
    {match: /transaction\:.*/, color: :hide, level: 1, priority: -10 },
    {match: /executing `.*/, color: :hide, level: 0, priority: -5},
    {match: /triggering load callbacks/, color: :hide, level: 0, priority: 5}
  ]

end
