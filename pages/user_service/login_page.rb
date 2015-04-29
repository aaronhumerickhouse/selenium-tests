require_relative '../default_sportngin_page'

# Holds Variables and Methods specific to the Login Page of Tourney
class LoginPage < DefaultSportNginPage
  text_field(:username, :id => 'user_login')
  text_field(:password, :id => 'user_password')
  button(:sign_in, :value => 'Sign in')
  button(:login, :value => 'Login')
  paragraph(:failed_notification_text, :css => 'div.notification.roadblock p')
end

require_relative 'user_service_base_page'
module UserService
  module Page
    #User Service Login
    class Login < UserService::Page::BasePage
      text_field(:username, :id => 'user_login')
      text_field(:password, :id => 'user_password')
      button(:login, :value => 'Login')
    end
  end
end
