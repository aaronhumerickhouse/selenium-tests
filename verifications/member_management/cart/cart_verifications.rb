module MemberManagement
  module Verification
    #Module to hold verification functions specific to the cart page.
    module Cart
      # Verify the contents of a cart row
      # @param data [Hash] The contents to verify
      # @option data [String] :type Optional
      # @option data [String] :description Optional
      # @option data [String] :quantity Optional
      # @option data [String] :price Optional
      def verify_cart_shopping_cart_row(data={})
        cart_page = MemberManagement::Page::Cart.new $browser
        row = cart_page.find_row_by_type(data[:type])
        @soft_asserts.verify { expect(row.type).to eq data[:type] } if data[:type]
        @soft_asserts.verify { expect(row.description).to eq data[:description] } if data[:description]
        @soft_asserts.verify { expect(row.quantity).to eq data[:quantity] } if data[:quantity]
        @soft_asserts.verify { expect(row.price).to eq data[:price] } if data[:price]
      end

      # Verify the number of items in a cart
      # @param count [Integer] The expected number of rows
      def verify_cart_shopping_cart_size(count)
        cart_page = MemberManagement::Page::Cart.new $browser
        @soft_asserts.verify { expect(cart_page.shopping_cart_rows.size).to eq count }
      end

      # Verify the grand total of a cart
      # @param total [String] The dollar amount for the cart, eg '$25.00'
      def verify_cart_shopping_cart_grand_total(total)
        cart_page = MemberManagement::Page::Cart.new $browser
        @soft_asserts.verify { expect(cart_page.grand_total.text).to eq total }
      end
    end
  end
end
