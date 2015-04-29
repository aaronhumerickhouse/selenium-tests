require 'net/https'

# Helper methods for Sauce Labs
module SauceHelper

  #Creates a Sauce Labs browser instance.
  #
  # @param test_name [String] The name of a test used to label Sauce Labs jobs.
  #
  # @return [Watir::Browser] A remote driver initiated with config params: resources/config/config.yml.erb.
  def self.setup_sauce_driver(test_name, browser)
    config = DefaultWatir.get_config
    caps = setup_capabilities(config['sauce_labs'], test_name, browser)

    Utilities.is_tournament? ? Watir::Browser.new(:remote, url: config['sauce_labs']['url'], desired_capabilities: caps) : SportNginWatir::Browser.new(:remote, url: config['sauce_labs']['url'], desired_capabilities: caps)
  end

  # Creates the capabilities as defined in Environment variables and resources/config/config.yml.erb.
  #
  # @param config [hash] The sauce_labs configuration from config.yml.erb
  # @param test_name [String] The name of a test used to label Sauce Labs jobs.
  #
  # @return [Selenium::WebDriver::Remote::Capabilities] Remote capabilities for Sauce Labs
  #
  # @example
  #     config = DefaultWatir.get_config
  #     caps = setup_capabilities(config['sauce_labs'], test_name)
  def self.setup_capabilities(config, test_name, browser)
    browser = browser.to_s
    caps = Selenium::WebDriver::Remote::Capabilities.new

    caps['platform'] = config['browsers'][browser]['os']
    caps['browserName'] = config['browsers'][browser]['browser']
    caps['version'] = config['browsers'][browser]['browser_version']

    caps['name'] = test_name
    caps['build'] = ENV['TRAVIS_BUILD_NUMBER'] if ENV['TRAVIS_BUILD_NUMBER']
    caps['tags'] = []
    caps['tags'] << ENV['TRAVIS_BRANCH'] if ENV['TRAVIS_BRANCH']
    caps['tags'] << ENV['TRAVIS_COMMIT_RANGE'] if ENV['TRAVIS_COMMIT_RANGE']

    caps['max_duration'] = config['capabilities']['max_duration']
    caps['record_video'] = config['capabilities']['record_video']
    caps['video_upload_on_pass'] = config['capabilities']['video_upload_on_pass']
    caps['record_screenshots'] = config['capabilities']['record_screenshots']
    caps['record_logs'] = config['capabilities']['record_logs']
    caps['sauce_advisor'] = config['capabilities']['sauce_advisor']
    caps['selenium_version'] = config['capabilities']['selenium_version']
    caps[:javascript_enabled] = config['capabilities']['javascript_enabled']
    return caps
  end

  # Updates the status for the job in Sauce Labs.  Sets it to passed or failed based on has_errors
  #
  # @param session_id [String] The Driver session for the current execution
  # @param has_errors [Boolean] Has the test had any errors?
  def self.update_status(session_id, has_errors)
    config = DefaultWatir.get_config
    status = has_errors ? 'false' : 'true'
    begin
      host = 'saucelabs.com'
      path = "/rest/v1/#{config['sauce_labs']['username']}/jobs/#{session_id}"

      req = Net::HTTP::Put.new(path, {'Content-Type' => 'application/json'})
      req.basic_auth(config['sauce_labs']['username'], config['sauce_labs']['access_key'])
      req.body = "{\"passed\" : #{status}}"

      resp = Net::HTTP.new(host).start {|http| http.request(req)}
      $LOGGER.info "Updating Sauce Job #{session_id} with status #{!has_errors ? 'passed' : 'failed'}.  Response:\n#{resp.message}"
    rescue StandardError => ex
      $LOGGER.info "Failed to update Sauce Job #{session_id} with status #{!has_errors ? 'passed' : 'failed'}.  Response:\n#{resp.inspect}"
      puts ex
      puts ex.backtrace
    end
  end
end

