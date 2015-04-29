require_relative '../../helpers/default_watir'

module MemberManagement
  module Component
    #Component for elements with the class single-checkbox
    class SingleCheckbox
      #Initialize SingleCheckbox component
      #
      #@param selector [Hash] Selector for Watir Element
      def initialize(selector)
        @selector = selector
      end

      # @return [Bool] is the checkbox checked?
      def checked?
        $browser.element(@selector).attribute_value('checked') == 'true'
      end

      # @return [Bool] is the checkbox not checked??
      def not_checked?
        !checked?
      end

      # Checks the checkbox unless it's already checked
      def check
        click unless checked?
      end

      # Unchecks the checkbox unless it's already not checked
      def uncheck
        click unless unchecked?
      end

      # Clicks the checkbox
      def click
        $browser.element(@selector).element(xpath: './../label').click
      end

      # @return [String] the label of the checkbox
      def label
        $browser.element(@selector).element(xpath: './../label').h1.text
        end
    end
  end
end
