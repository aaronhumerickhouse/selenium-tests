require_relative '../../helpers/default_watir'

module MemberManagement
  module Component
    class SelectizeDropdown

      # The initializer for a SelectizeDropdown
      #
      # @selector [HASH] The element selector
      def initialize(selector)
        @selector = selector
      end

      # Clicks the selection given by text
      #
      # @param text [String] The main value of a dropdown option to select (before any newline)
      def select_text(text)
        input = $browser.element(@selector)
        css = 'div.selectize-dropdown-content > div'

        $browser.wait_until { input.div(css: css).present? }
        dropdowns = input.divs(css: css)

        dropdowns.each do |element|
          value = element.text
          value = element.text.split("\n")[0] if value.include? "\n"
           if value == text
             element.click
             return
           end
        end
        raise StandardError.new "Text #{text} was not found in the dropdown."
      end

      # Clicks the selection given by value
      # @param value [String] The data attribute of the option to select.
      def select_value(value)
        wait_until_visible
        $browser.element(@selector).divs(css: 'div.selectize-dropdown-content > div').each do |element|
          found_value = element.attribute_value('data-value')
          if found_value == value
            element.click
            return
          end
        end
        raise StandardError.new "Value #{value} was not found in the dropdown."
      end

      # Returns an array of the main name of the dropdown values
      #
      # @return [String Array] The main name of the dropdown values
      def values
        wait_until_visible
        $browser.element(@selector).divs(css: 'div.selectize-dropdown-content > div').map do |element|
          value = element.text
          value.split("\n")[0] if value.include? "\n"
        end
      end

      private
      # Waits until the element given by @selector is visible
      def wait_until_visible
        $browser.wait_until { $browser.element(@selector).visible? }
      end
    end
  end
end
