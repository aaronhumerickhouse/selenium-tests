require_relative '../selenium_helper'
require_relative '../../pages/user_service/login_page'

class LoginHelper < SeleniumHelper
  #Navigates to a URL and logs into HQ.
  #
  # *Parameters:*
  # *  +browser+ - The browser to run the method in
  #
  #===== Safari Note
  #<em>Because Safari doesn't have profiles, need to skip logging in, login is cached.</em>
  def self.login(username=DefaultWatir.get_default_username, password=DefaultWatir.get_default_password)
    $LOGGER.info "Logging in as #{username}"
    login_page = LoginPage.new $browser
    login_page.username = username
    login_page.password = password
    login_page.sign_in
  end

  def self.ensure_on_login(base_url)
    login_page = LoginPage.new($browser)
    unless login_page.username_element.element.exist? #for browsers without profiles
      $LOGGER.info 'Login page not present, signing out'
      login_page.sign_out_element.click
      $browser.goto base_url
      $browser.wait_until {login_page.username_element.element.exist?}
    end
  end
end


module UserService
  module Helper
    #User Service Login Helpers
    class Login
      # Logs into sitebuilder
      #@param username [String] Username
      #@param password [String] User's password
      def self.login(username=DefaultWatir.get_default_username, password=DefaultWatir.get_default_password)
        $LOGGER.info "Logging in as #{username}"
        login_page = UserService::Page::Login.new $browser
        login_page.username.set username
        login_page.password.set password
        login_page.login.click
      end
    end
  end
end
