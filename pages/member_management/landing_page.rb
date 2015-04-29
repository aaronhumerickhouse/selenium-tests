require_relative 'member_management_base_page'
require 'erb'
include ERB::Util

module MemberManagement
  module Page
    # Page Object for the landing page of Member Management.
    class Landing < MemberManagement::Page::BasePage
      page_url /https:\/\/user.stage.ngin-staging.com\/onboarding\/.*redirect_uri=#{url_encode(MemberManagement::Helper::BaseHelper.get_base_url)}.*/
      title 'Sport Ngin'
      expected_element 'link', {id: 'onboarding-start-here'}

      link(:start_here, {id: 'onboarding-start-here'})
      link(:register_here, {id: 'onboarding-register-here'})
      link(:sign_in, {id: 'onboarding-sign-in'})
      link(:get_help, {id: 'onboarding-get-help-here'})
    end
  end
end

