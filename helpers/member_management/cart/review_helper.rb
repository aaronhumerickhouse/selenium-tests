require_relative '../base_member_management_helper'
require_relative '../../../pages/member_management/cart/review_page'


module MemberManagement
  module Helper
    #Helper methods for Review
    class Review < MemberManagement::Helper::BaseHelper

      # Select the method of payment
      # @param method [String] The payment name used to pay the bill
      def self.select_payment_method(method)
        review_page = MemberManagement::Page::Review.new $browser
        
      end

      # Create credit card profile data and submit the order
      # @param data [Hash] The data used to populate the credit card profile
      def self.populate_credit_card_information_and_continue(data={})
        review_page = MemberManagement::Page::Review.new $browser

        $browser.window(:title => 'Member Management | Reviews').use
        review_page.credit_card_number.click
        review_page.credit_card_number.set data[:credit_card_number] if data[:credit_card_number]
        review_page.credit_card_number.send_keys(:tab)

        review_page.credit_card_first_name.set data[:first_name] if data[:first_name]
        review_page.credit_card_last_name.set data[:last_name] if data[:last_name]
        review_page.credit_card_expiration_month.select_text data[:expiration_month] if data[:expiration_month]
        review_page.credit_card_expiration_year.set data[:expiration_year] if data[:expiration_year]
        review_page.credit_card_cvv_code.set data[:cvv_code] if data[:cvv_code]

        review_page.submit_order.click
      end
    end
  end
end
