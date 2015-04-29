require_relative '../base_member_management_helper'
require_relative '../../../pages/member_management/member_initiation/choose_membership_level_page'

module MemberManagement
  module Helper
    #Helper methods for Choose Membership Level
    class ChooseMembershipLevel < MemberManagement::Helper::BaseHelper

      # Select membership level and club
      # @param level [String] The membership level being purchased
      # @param club [String] The club the user wants to be a member of
      def self.choose_membership_level_and_club(level, club)
        select_membership_level(level)
        select_membership_club(club)
        choose_membership_level_page = MemberManagement::Page::ChooseMembershipLevel.new $browser
        choose_membership_level_page.save_and_continue.click
      end

      # Select a club to become a member of
      # @param club [String] The club the user wants to be a member of
      def self.select_membership_club(club)
        choose_membership_level_page = MemberManagement::Page::ChooseMembershipLevel.new $browser
        choose_membership_level_page.search_clubs.value = club
        choose_membership_level_page.search_clubs.click # Necessary for Selenium to focus on the search box
        choose_membership_level_page.club_dropdown.select_text(club)

      end

      # Find and select a membership level
      # @param level [String] The membership level being purchased
      def self.select_membership_level(level)
        choose_membership_level_page = MemberManagement::Page::ChooseMembershipLevel.new $browser
        choose_membership_level_page.membership_checkboxes.each do |checkbox|
           checkbox.check if checkbox.label.include?(level)
           return
        end
        raise StandardError.new "Membership #{level} was not found on the page."
      end

      # Clicks start background screen
      def self.start_background_screen
        choose_membership_level_page = MemberManagement::Page::ChooseMembershipLevel.new $browser
        choose_membership_level_page.start_background_screen.click
      end

      #Attaches to TC logiQ popup, closes it, attaches to Member Management | Choose_membership_levels
      def self.close_background_screen_popup
        $browser.window(:title => 'TC logiQ, Inc. - The Employment Services Specialists').use
        $browser.window.close
        $browser.window(:title => 'Member Management | Choose_membership_levels').use

      end
    end
  end
end
