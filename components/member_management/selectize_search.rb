require_relative '../../helpers/default_watir'
require_relative 'selectize_dropdown'

module MemberManagement
  module Component
    #Component for elements with class selectize-control.search
    class SelectizeSearch
      #Initializer for Selectize Search
      #
      #@param selector [Hash] the selector MUST be a css or xpath selector
      def initialize(selector)
        @selector = selector
        if selector[:css]
          @dropdown = MemberManagement::Component::SelectizeDropdown.new(css: "#{@selector[:css]} div.selectize-dropdown")
        elsif selector[:xpath]
          @dropdown = MemberManagement::Component::SelectizeDropdown.new(xpath: "#{@selector[:xpath]}//div[contains(@class, 'selectize-dropdown')]")
        else
          raise StandardError.new 'Selector must be in the form of CSS or XPath'
        end
      end

      # Enters a value in the search box
      #
      # @param text [String] The string to search for
      def search(text)
        $browser.element(@selector).text_field.value = text
      end

      # Selects the given text in the dropdown
      #
      # @param text [String] The text to select
      def select(text)
        @dropdown.select_text text
      end

      # @return [String Array] The values present in the active dropdown
      def values
        @dropdown.values
      end
    end
  end
end

