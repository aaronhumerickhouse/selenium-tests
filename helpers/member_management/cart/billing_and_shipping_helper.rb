require_relative '../base_member_management_helper'
require_relative '../../../pages/member_management/cart/billing_and_shipping_page'


module MemberManagement
  module Helper
    #Helper methods for Billing and Shipping
    class BillingAndShipping < MemberManagement::Helper::BaseHelper

      # The data used to populate the billing profile
      # @param data [Hash] The data used to populate the billing profile
      def self.populate_billing_information(data={})
        billing_and_shipping_page = MemberManagement::Page::BillingAndShipping.new $browser
        billing_and_shipping_page.billing_first_name.set data[:first_name] if data[:first_name]
        billing_and_shipping_page.billing_last_name.set data[:last_name] if data[:last_name]
        billing_and_shipping_page.billing_email.set data[:email_address] if data[:email_address]
        billing_and_shipping_page.billing_phone_number.set data[:phone_number] if data[:phone_number]
        billing_and_shipping_page.billing_street_address.set data[:street_address] if data[:street_address]
        billing_and_shipping_page.billing_secondary_address.set data[:secondary_address] if data[:secondary_address]
        billing_and_shipping_page.billing_city.set data[:city] if data[:city]
        billing_and_shipping_page.billing_state.select_text data[:state] if data[:state]
        billing_and_shipping_page.billing_zipcode.set data[:zip] if data[:zip]
        billing_and_shipping_page.billing_country.select_text data[:country] if data[:country]
      end

      # The data used to populate the billing profile
      # @param data [Hash] The data used to populate the profile and check Shipping is equal to Billing
      def self.populate_same_billing_and_shipping_information_save(data={})
        populate_billing_information(data)
        billing_and_shipping_page = MemberManagement::Page::BillingAndShipping.new $browser
        billing_and_shipping_page.shipping_equal_billing.check
        billing_and_shipping_page.save_and_continue.click
      end
    end
  end
end

