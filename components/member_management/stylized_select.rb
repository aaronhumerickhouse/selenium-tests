require_relative '../../helpers/default_watir'
require_relative 'selectize_dropdown'

module MemberManagement
  module Component
    # Class for the styled select components on the Create Profile page
    class StylizedSelect

      # Initializes the create profile component
      # Retrieved by the id of select.selectized
      # @param selector [Hash] selector must be XPath selector
      def initialize(selector)
        @selector = selector

        if selector[:xpath]
          @dropdown = MemberManagement::Component::SelectizeDropdown.new(xpath: "#{@selector[:xpath]}/../div[contains(@class,'selectize-control')]/div[contains(@class, 'selectize-dropdown')]")
          @selectize_input = $browser.element(@selector).div(xpath: "./../div[contains(@class,'selectize-control')]/div[contains(@class, 'selectize-input')]")
        else
          raise StandardError.new 'Selector must be in the form of XPath'
        end
      end

      # Returns the text showing in the drop down
      # @return [String] The text of the value shown in the drop down
      def value
        if @selectize_input.text == ''
          @selectize_input.input.attribute_value('placeholder')
        else
          @selectize_input.div.text
        end
      end

      # Selects a value in the drop down
      # @param str_or_rx [String, Regexp] Select the value specified
      def select_value(str_or_rx)
        @selectize_input.click
        @dropdown.select_value(str_or_rx)
      end

      # Checks to see if the correct value is shown
      # @param str_or_rx [String, Regexp] true if value = text, false if value doesn't match text
      def selected?(str_or_rx)
        value == str_or_rx
      end

      # Selects the text in the drop down
      # @param str_or_rx [String, Regexp] Select the text shown in the drop down
      def select_text(str_or_rx)
        @selectize_input.click
        @dropdown.select_text(str_or_rx)
      end

      # Verifies that the drop down is enabled
      # @return [Boolean] true if profile is current user > false if profile is not current user
      def enabled?
        !disabled?
      end

      # Verifies that the drop down is disabled
      # @return [Boolean] true if profile is not current user > false if profile is user
      def disabled?
        @selectize_input.attribute_value("class").include?("disabled")
      end

      # Checks if an element is present (exist and visible)
      # @return [Boolean] Is the element present?
      def present?
        exists? && visible?
      end

      # Checks if an element exists
      # @return [Boolean] Is the element exists?
      def exists?
        @selectize_input.exists?
      end

      # Checks if an element is visible
      # @return [Boolean] Is the element visible?
      def visible?
        @selectize_input.visible?
      end
    end
  end
end

