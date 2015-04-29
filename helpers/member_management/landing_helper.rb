require_relative 'base_member_management_helper'
require_relative '../user_service/onboarding/sign_in_helper'
require_relative '../../pages/member_management/landing_page'

module MemberManagement
  module Helper
    #Helper methods for Landing Page
    class Landing < MemberManagement::Helper::BaseHelper
      # Signs a user in to member management
      # @param username [String] Username to login with
      # @param password [String] Password to login with
      def self.sign_in(username, password)
        UserService::Helper::SignIn.sign_in username, password
      end
    end
  end
end
