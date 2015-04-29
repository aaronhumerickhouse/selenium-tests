require_relative '../utilities/soft_asserts'
require_relative '../utilities/utilities'
require_relative '../spec/spec_helper'
require_relative 'sauce_helper'

require 'sportngin-watir-webdriver'
require 'watir-webdriver'
require 'rspec'
require 'yaml'
require 'logger'
require 'json'
require 'erb'

# Each Watir Spec should extend this class.  This holds all the information needed to run Watir Tests
class DefaultWatir
  include SauceHelper

  # Returns a browser instance.  The instance will be Sauce labs if ENV['DRIVER'].upcase == 'SAUCE', otherwise it will be a local instance.
  #
  # @param test_name [String] The name of a test used to label Sauce Labs jobs.
  #
  # @return [Watir::Browser] A local or remote driver initiated with the browser defined in the environment variable BROWSER or defaults to firefox.
  def self.initiate_browser(test_name)
    browser = ENV['BROWSER'] ? ENV['BROWSER'].to_sym : :firefox

    if Utilities.is_sauce?
      SauceHelper.setup_sauce_driver(test_name, browser)
    else
      Utilities.is_tournament? ? Watir::Browser.new(browser) : SportNginWatir::Browser.new(browser)
    end
  end

  def self.get_cred_config
    return YAML.load(File.new("#{Utilities.get_root_directory}/resources/config/cred_config.yml"))
  end

  def self.get_config
    return YAML.load(ERB.new(File.read("#{Utilities.get_root_directory}/resources/config/config.yml.erb")).result)
  end

  def self.get_default_username
    return get_cred_config[get_environment]['non_third_north']['username']

  end

  def self.get_default_password
    return get_cred_config[get_environment]['non_third_north']['password']
  end

  def self.get_third_north_username
    return get_cred_config[get_environment]['third_north']['username']

  end

  def self.get_third_north_password
    return get_cred_config[get_environment]['third_north']['password']
  end

  def self.get_environment
    return ENV['ENVIRONMENT'] ? ENV['ENVIRONMENT'] : 'staging'
  end

end
