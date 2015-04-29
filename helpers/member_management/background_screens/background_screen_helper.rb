require_relative '../base_member_management_helper'
require_relative '../../../pages/member_management/background_screens/background_screen_page'

module MemberManagement
  module Helper
    #Helper methods for Background Screen
    class BackgroundScreen < MemberManagement::Helper::BaseHelper

      # Approves a background screen for a given name
      # @param name [String] The name of the member to approve
      def self.approve_background_screen(name)
        get_row_with_name(name).tds[5].as[0].click
      end

      # Denies a background screen for a given name
      # @param name [String] The name of the member to deny
      def self.deny_background_screen(name)
        get_row_with_name(name).tds[5].as[1].click
      end

      # Clicks edit for a background screen for a given name
      # @param name [String] The name of the member to edit
      def self.edit_background_screen(name)
        get_row_with_name(name).tds[5].as[2].click
      end

      # Retrieves a row with a specific name
      # @param name [String] The name of the row to get
      # @return [Watir::TableRow] The html element of the row
      def self.get_row_with_name(name)
        background_screen_page = MemberManagement::Page::BackgroundScreen.new $browser
        background_screen_page.get_row_with_name name
      end
    end
  end
end
