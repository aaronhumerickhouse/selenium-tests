#Class to include non-page or non-test specific functionality
class Utilities

  #Returns the project_root/screenshots absolute directory
  def self.get_screenshot_directory
      return create_screenshot_directory(get_root_directory)
  end

  #Creates a screenshot directory if it's not already available.
  def self.create_screenshot_directory(root_dir)
    screenshot_dir = root_dir + '/screenshots'
    Dir.mkdir(screenshot_dir) unless Dir.exists?('screenshots')
    return screenshot_dir
  end

  def self.get_root_directory
    rd = Dir.pwd.split('selenium-tests/')[0]
    rd += '/selenium-tests' if !rd.include? 'selenium-tests'
    return rd
  end

  #Creates a screenshot if there was an exception in any test using #create_screenshot
  #
  # *Parameters:*
  # *  +example+ - The example instance created from the test.  This can be found in after (:each)
  def self.create_exception_screenshot(example)
    if example.exception
      $has_errors = true
      Utilities.create_screenshot
    end
  end

  #Creates a screenshot in the project_root/screenshots directory
  #
  # *Parameters:*
  # * *+caller+: Who's calling the method.  Defaults to ''
  def self.create_screenshot(caller='')
    if $browser
      screenshot_name = "screenshot_#{Time.new.inspect}.png"
      screenshot_name.gsub!(':', '-').gsub!(' ', '_')
      directory = Utilities.get_screenshot_directory
      screenshot_path = "#{directory}/#{screenshot_name}"
      $browser.screenshot.save(screenshot_path)

      $LOGGER.error "Screenshot: #{screenshot_path}"
      $LOGGER.error "URL: #{$browser.url}"
      $LOGGER.error "Browser Title: #{$browser.title}"
      screenshot_path
    end
  end

  #Turns a date from the format 24/11/2014 to Nov 24 2014
  #
  # *Parameters:*
  # * +date+ - A string date in the format dd/mm/yyyy
  # *Returns:*
  # * A date in the format Mmm d yyyy
  def self.month_day_year_to_mon_day_year(date)
    date = date.split('/')
    format = (date[1].to_i < 10) ? '%b%e %Y' : '%b %e %Y'
    date = Date.parse("#{date[1]}/#{date[0]}/#{date[2]}")
    return date.strftime(format)
  end

  #Creates a screenshot, flips the $has_errors flag, and raises the exception
  #
  # *Parameters:*
  # * +browser+ - The browser instance in the test
  # * +ex+ - The rescued exception
  def self.general_exception_handling(ex)
    Utilities.create_screenshot
    $has_errors = true
    raise(ex)
  end

  # @return true if the code is being executed on a windows operating system, false otherwise.
  def self.is_windows?
    (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  end

  # @return true if the code is being executed on a mac operating system, false otherwise.
  def self.is_mac?
    (/darwin/ =~ RUBY_PLATFORM) != nil
  end

  # @return true if the code is being executed on a unix operating system, false otherwise.
  def self.is_unix?
    !is_windows?
  end

  # @return true if the code is being executed on a linux operating system, false otherwise.
  def self.is_linux?
    is_unix? and not is_mac?
  end

  # @return true if the driver is firefox, false otherwise.
  def self.is_firefox?
    $browser.driver.browser.to_s.downcase == 'firefox'
  end

  # @return true if the driver is ie, false otherwise.
  def self.is_ie?
    $browser.driver.browser.to_s.downcase == 'ie'
  end

  # @return true if the driver is chrome, false otherwise.
  def self.is_chrome?
    $browser.driver.browser.to_s.downcase == 'chrome'
  end

  # @return true if the driver is safari, false otherwise.
  def self.is_safari?
    $browser.driver.browser.to_s.downcase == 'safari'
  end

  # @return true if the the CI is Jenkins, false otherwise.
  def self.is_jenkins?
    Utilities.get_root_directory.upcase.include? 'JENKINS'
  end


  # @return true if the the CI is Travis, false otherwise.
  def self.is_travis?
    ENV['TRAVIS'] && ENV['TRAVIS'] == 'true'
  end

  # @return true if the the CI is jenkins, false otherwise.
  def self.is_jenkins?
    Utilities.get_root_directory.upcase.include? 'JENKINS'
  end

  # @return true if the driver is Sauce Labs (ENV['DRIVER']), false otherwise.
  def self.is_sauce?
    ENV['DRIVER'] && ENV['DRIVER'].upcase == 'SAUCE'
  end

  # @return true if the test is a Tournament Test.  Used because of Page-Object's dependency on Watir
  def self.is_tournament?
    ENV['SPEC_TYPE'] && ENV['SPEC_TYPE'] == 'TOURNAMENT'
  end


  #Creates a logger
  #
  # *Parameters:*
  # *  +level+ - The logger level, defaults to INFO
  def self.create_logger(level=Logger::INFO)
    logger = Logger.new($stdout)
    logger.datetime_format = '%y-%m-#d %H:%M:%S'
    logger.formatter = proc do |severity, datetime, _, msg|
      format = "[#{severity} - #{datetime}] - #{msg}"
      if ARGV.any? { |arg| arg == 'h' } #HTML output
        "#{format}<br>"
      else
        "\n#{format}\n" #Extra new line due to RSpec's output
      end
    end
    logger.level = level
    return logger
  end
end
