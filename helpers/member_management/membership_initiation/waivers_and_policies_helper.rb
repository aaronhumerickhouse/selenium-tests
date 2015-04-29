require_relative '../base_member_management_helper'
require_relative '../../../pages/member_management/member_initiation/waivers_and_policies_page'


module MemberManagement
  module Helper
    #Helper methods for Waivers and Policies
    class WaiversAndPolicies < MemberManagement::Helper::BaseHelper

      # Read, accept and sign the waivers
      # @param signature [String] The signature used to sign the waivers
      def self.accept_and_sign_policies(signature)
        waivers_page = MemberManagement::Page::WaiversAndPolicies.new $browser

        waivers_page.safe_sport_policy.wait_until_present
        $browser.execute_script("$('iframe.cke_wysiwyg_frame')[0].contentWindow.scrollTo(0,10000)")
        waivers_page.safe_sport_policy_checkbox.check

        waivers_page.consent_waiver.wait_until_present
        $browser.execute_script("$('iframe.cke_wysiwyg_frame')[1].contentWindow.scrollTo(0,10000)")
        waivers_page.consent_waiver_checkbox.check

        waivers_page.sign_waiver.value = signature
        waivers_page.add_to_cart.click
      end
    end
  end
end
