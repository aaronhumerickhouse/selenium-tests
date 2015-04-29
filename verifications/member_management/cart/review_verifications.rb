module MemberManagement
  #Module to hold verification functions to reuse in tests.
  module Verification
    #Module to hold verification functions specific to the review page.
    module Review
      # Verify the contents of a cart row
      # @param data [Hash] The contents to verify
      # @option data [String] :membership_type Optional
      # @option data [String] :member Optional
      # @option data [String] :membership_level Optional
      # @option data [String] :quantity Optional
      # @option data [String] :price Optional
      def verify_review_shopping_cart_row(data={})
        review_page = MemberManagement::Page::Review.new $browser
        row = review_page.find_row_by_type(data[:type])
        @soft_asserts.verify { expect(row.type).to eq data[:type] } if data[:type]
        @soft_asserts.verify { expect(row.description).to eq data[:description] } if data[:description]
        @soft_asserts.verify { expect(row.quantity).to eq data[:quantity] } if data[:quantity]
        @soft_asserts.verify { expect(row.price).to eq data[:price] } if data[:price]
      end

      # Verify the number of items in a cart
      # @param count [Integer] The expected number of rows
      def verify_review_shopping_cart_size(count)
        review_page = MemberManagement::Page::Review.new $browser
        @soft_asserts.verify { expect(review_page.shopping_cart_rows.size).to eq count }
      end

      # Verify the summary totals of a cart
      # @param total [String] The grand total amount for the cart, eg '$25.00'
      def verify_review_shopping_cart_grand_total(total)
        review_page = MemberManagement::Page::Review.new $browser
        @soft_asserts.verify { expect(review_page.grand_total.text).to eq total }
      end

      # Verify the billing and shipping info are the same
      def verify_review_billing_and_shipping_info_same
        review_page = MemberManagement::Page::Review.new $browser
        @soft_asserts.verify { expect(review_page.bill_to.text.split('Bill to:')[1]).to eq review_page.ship_to.text.split('Ship to:')[1] }
      end
    end
  end
end
