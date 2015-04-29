require_relative '../user_service_base_helper'
require_relative '../../../pages/user_service/onboarding/sign_in_page'

module UserService
  module Helper
    class SignIn < UserService::Helper::BaseHelper
      def self.sign_in(username, password)
        page = UserService::Page::SignIn.new $browser

        page.username.value = username
        page.password.value = password
        page.sign_in.click
      end
    end
  end
end
