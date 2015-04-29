require_relative '../base_member_management_helper'
require_relative '../../../pages/member_management/member_initiation/choose_membership_page'


module MemberManagement
  module Helper
    #Helper methods for Choose Membership
    class ChooseMembership < MemberManagement::Helper::BaseHelper

      # Clicks the Add Membership link for Athlete on the Choose Membership page
      def self.choose_athlete_membership_type
        choose_membership_page = MemberManagement::Page::ChooseMembership.new $browser
        choose_membership_page.athlete_add_membership.click
      end

      # Clicks the Add Membership link for Official on the Choose Membership page
      def self.choose_official_membership_type
        choose_membership_page = MemberManagement::Page::ChooseMembership.new $browser
        choose_membership_page.official_add_membership.click
      end

      # Clicks the Add Membership link for HPL on the Choose Membership page
      def self.choose_hpl_membership_type
        choose_membership_page = MemberManagement::Page::ChooseMembership.new $browser
        choose_membership_page.high_performance_leader_add_membership.click
      end

      # Clicks the Add Membership link for coach on the Choose Membership page
      def self.choose_coach_membership_type
        choose_membership_page = MemberManagement::Page::ChooseMembership.new $browser
        choose_membership_page.coach_add_membership.click
      end
    end
  end
end
