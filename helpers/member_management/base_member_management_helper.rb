require_relative '../selenium_helper'
require_relative '../../pages/member_management/member_management_base_page'

#Namespace for all MemberManagement classes
module MemberManagement
  #Namespace for all MemberManagement helpers
  module Helper
    # Contains helper methods useful to all MemberManagement helpers.
    class BaseHelper < SeleniumHelper
      # Returns the base_url either defined as an environment variable 'URL' or based in the config.
      def self.get_base_url
        base_url = ENV['URL']
        return base_url ||= DefaultWatir.get_config['member_management'][DefaultWatir.get_environment]['base_url']
      end

      #Retrieves test credit cards
      #@return [Hash] list of credit cards
      def self.credit_cards
        return YAML.load(File.new("#{Utilities.get_root_directory}/resources/member_management/credit_cards.yml"))
      end

      # Retrieves the hash representing basic credentials
      # @param name [String] The name of the user in the config file
      # @return [String] :username
      # @return [String] :password
      def self.get_credentials(name)
        {
            username: DefaultWatir.get_cred_config['staging']['member_management'][name]['username'],
            password: DefaultWatir.get_cred_config['staging']['member_management'][name]['password']
        }
      end

      #Signs out of member management
      def self.sign_out
        page = MemberManagement::Page::BasePage.new $browser
        page.sign_out.click
      end

      # Navigate to info_and_personnel using the 
      def self.navigate_to_info_and_personnel
        page = MemberManagement::Page::BasePage.new $browser
        page.navigation_info_and_personnel.click
      end

      # Navigate to events using the 
      def self.navigate_to_events
        page = MemberManagement::Page::BasePage.new $browser
        page.navigation_events.click
      end

      # Navigate to members using the 
      def self.navigate_to_members
        page = MemberManagement::Page::BasePage.new $browser
        page.navigation_members.click
      end

      # Navigate to organizations using the 
      def self.navigate_to_organizations
        page = MemberManagement::Page::BasePage.new $browser
        page.navigation_organizations.click
      end

      # Navigate to become_a_member using the 
      def self.navigate_to_become_a_member
        page = MemberManagement::Page::BasePage.new $browser
        page.navigation_become_a_member.click
      end

      # Navigate to store_management using the 
      def self.navigate_to_store_management
        page = MemberManagement::Page::BasePage.new $browser
        page.navigation_store_management.click
      end

      # Navigate to reports using the 
      def self.navigate_to_reports
        page = MemberManagement::Page::BasePage.new $browser
        page.navigation_reports.click
      end

      # Navigate to approvals using the 
      def self.navigate_to_approvals
        page = MemberManagement::Page::BasePage.new $browser
        page.navigation_approvals.click
      end

      # Navigate to background_screens using the 
      def self.navigate_to_background_screens
        page = MemberManagement::Page::BasePage.new $browser
        page.navigation_background_screens.click
      end

      # Navigate to audit_history using the 
      def self.navigate_to_audit_history
        page = MemberManagement::Page::BasePage.new $browser
        page.navigation_audit_history.click
      end

      # Navigate to administration using the 
      def self.navigate_to_administration
        page = MemberManagement::Page::BasePage.new $browser
        page.navigation_administration.click
      end

      # Navigate to the dashboard
      def self.navigate_to_dashboard
        page = MemberManagement::Page::BasePage.new $browser
        page.dashboard.click
      end

      #Navigates to the cart and empties it if items are in it
      def self.clear_cart_contents
        page = MemberManagement::Page::BasePage.new $browser
        page.cart.click

        cart_page = MemberManagement::Page::Cart.new $browser
        rows = cart_page.shopping_cart_rows
        cart_page.empty_cart.click if rows.size > 0
      end
    end
  end
end


