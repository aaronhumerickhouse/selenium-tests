require_relative '../../helpers/default_watir'

module MemberManagement
  module Component
    # Class for the Profile component on the Create Profile page
    class UnstylizedSelect

      # Initializes the create profile component
      def initialize(selector)
        @selector = selector
      end

      # Returns the text showing in the drop down
      # @return [String] The text of the value shown in the drop down
      def value
        $browser.element(@selector).div(xpath: "./../div[@class='custom-select-display']").text
      end

      # Selects a value in the drop down
      # @param str_or_rx [String, Regexp] Select the value specified
      def select_value(str_or_rx)
        select.select_value(str_or_rx)
      end

      # Checks to see if the correct value is shown
      # @param str_or_rx [String, Regexp] true if value = text, false if value doesn't match text
      def selected?(str_or_rx)
        select.selected?(str_or_rx)
      end

      # Selects the text in the drop down
      # @param str_or_rx [String, Regexp] Select the text shown in the drop down
      def select_text(str_or_rx)
        select.select(str_or_rx)
      end

      # Verifies that the drop down is enabled
      # @return [Boolean] true if profile is current user > false if profile is not current user
      def enabled?
        !select.disabled?
      end

      # Verifies that the drop down is disabled
      # @return [Boolean] true if profile is not current user > false if profile is user
      def disabled?
        select.disabled?
      end

      private
      def select
        $browser.select(@selector)
      end
    end
  end
end

