module MemberManagement
  module Component
    # Class for shopping cart rows in Member Management
    class ShoppingCartRow

      # Selector will be element described by TABLE.mm-table.cart
      def initialize(selector)
        @selector = selector
      end

      # @return The entire Item value
      def item
        $browser.element(@selector).td(index: 0).div(css: 'div > div:nth-child(2)').text
      end

      # @return The membership type, ie: Athlete Membership
      def type
        $browser.element(@selector).td(index: 0).div(css: 'div > div:nth-child(2)').h1.text
      end

      # @return The name of the member the membership is for
      def description
        $browser.element(@selector).td(index: 0).div(css: 'div > div:nth-child(2)').h2.text
      end

      # @return The number of memberships for this type
      def quantity
        initial = $browser.element(@selector).td(index: 1).input(css: 'div > div >input')
        if initial.exist?
          initial.value
        else
          $browser.element(@selector).td(index: 1).text
        end
      end

      # Remove the membership
      def remove
        $browser.element(@selector).td(index: 1).a(css: 'div > div:nth-child(2) a').click
      end

      # @return The price of the membership
      def price
        $browser.element(@selector).td(index: 2).text
      end
    end
  end
end
