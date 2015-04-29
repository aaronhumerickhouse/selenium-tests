require_relative '../../helpers/default_watir'

module MemberManagement
  # Module for all Member Management Components
  module Component
    # Class for the Membership component on the Dashboard page
    class DashboardMembership

      # Initializes the membership component methods
      def initialize(selector)
        @selector = selector
      end

      # Returns the membership type.
      # @return [String] The type of membership
      def type
        $browser.element(@selector).h1(css: 'h1').text
      end

      # Returns the membership level.
      # @return [String] The membership level
      def level
        $browser.element(@selector).span(css: 'span').text.split(' - exp ')[0]
      end

      # Returns the membership expiration date.
      # @return [String] The expiration date
      def expiration_date
        $browser.element(@selector).span(css: 'span').text.split(' - exp ')[1].split("\n")[0]
      end

      # Return true if the element is present, false if it isn't
      # @return [Boolean] True if the element is present, false if it isn't present
      def is_upgrade_present?
        get_upgrade_element.present?
      end

      # Click on the Upgrade link if it is present on a membership
      def click_upgrade
        get_upgrade_element.click if is_upgrade_present?
      end

      private
      # Returns the element for the Upgrade link
      def get_upgrade_element
        $browser.element(@selector).link(css: 'span > a')
      end
    end
  end
end

