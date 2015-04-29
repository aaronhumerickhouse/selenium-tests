require_relative '../../../pages/member_management/member_initiation/choose_membership_level_page'

module MemberManagement
  module Verification
    # Verifications for the Choose Membership Level page
    module ChooseMembershipLevel
      # Verifies that the background screen process starts with the popup of TC logiQ
      def verify_background_screen_starts
        $browser.window(:title => 'TC logiQ, Inc. - The Employment Services Specialists').use
        @soft_asserts.verify { expect($browser.title).to eq 'TC logiQ, Inc. - The Employment Services Specialists' }
      end

      def verify_background_screen_is_present
        choose_membership_level = MemberManagement::Page::ChooseMembershipLevel.new $browser
        @soft_asserts.verify { expect(choose_membership_level.start_background_screen.present?).to be true }
      end

      # Verifies that the upgrade memberships are present
      def verify_upgrade_memberships(data={})
        choose_membership_level = MemberManagement::Page::ChooseMembershipLevel.new $browser

        @soft_asserts.verify { expect(choose_membership_level.upgrade_limited_to_full.label).to eq data[:type]}
        @soft_asserts.verify { expect(choose_membership_level.upgrade_limited_to_high_performance.label).to eq data[:type2]}
      end
    end
  end
end

