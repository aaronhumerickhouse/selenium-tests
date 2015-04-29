module MemberManagement
  #Module to hold verification functions to reuse in tests.
  module Verification
    #Module to hold verification functions specific to the confirmation page.
    module Confirmation
      # Verify the contents of a cart row
      # @param data [Hash] The contents to verify
      # @option data [String] :membership_type Optional
      # @option data [String] :member Optional
      # @option data [String] :membership_level Optional
      # @option data [String] :quantity Optional
      # @option data [String] :price Optional
      def verify_confirmation_shopping_cart_row(data={})
        confirmation_page = MemberManagement::Page::Confirmation.new $browser
        row = confirmation_page.find_row_by_type(data[:type])
        @soft_asserts.verify { expect(row.type).to eq data[:type] } if data[:type]
        @soft_asserts.verify { expect(row.description).to eq data[:description] } if data[:description]
        @soft_asserts.verify { expect(row.quantity).to eq data[:quantity] } if data[:quantity]
        @soft_asserts.verify { expect(row.price).to eq data[:price] } if data[:price]
      end

      # Verify the number of items in a cart
      # @param count [Integer] The expected number of rows
      def verify_confirmation_shopping_cart_size(count)
        confirmation_page = MemberManagement::Page::Confirmation.new $browser
        @soft_asserts.verify { expect(confirmation_page.shopping_cart_rows.size).to eq count }
      end

      # Verify the summary totals of a cart
      # @param grand_total [String] The grand total amount for the cart, eg '$25.00'
      # @param payment [String] The payment amount for the cart, eg '$25.00'
      # @param amount_due [String] The amount due for the cart, eg '$0.00'
      def verify_confirmation_shopping_cart_totals(grand_total, payment, amount_due)
        confirmation_page = MemberManagement::Page::Confirmation.new $browser
        @soft_asserts.verify { expect(confirmation_page.grand_total.text).to eq grand_total }
        @soft_asserts.verify { expect(confirmation_page.payment.text).to eq payment }
        @soft_asserts.verify { expect(confirmation_page.amount_due.text).to eq amount_due }
      end

      # Verify the billing and shipping info are the same
      def verify_confirmation_billing_and_shipping_info_same
        confirmation_page = MemberManagement::Page::Confirmation.new $browser
        @soft_asserts.verify { expect(confirmation_page.billing_information.text).to eq confirmation_page.shipping_information.text }
      end
    end
  end
end
