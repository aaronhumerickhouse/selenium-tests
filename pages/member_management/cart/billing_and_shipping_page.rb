require_relative '../member_management_base_page'

module MemberManagement
  module Page
    # Page Object for the Dashboard page in Member Management
    class BillingAndShipping < MemberManagement::Page::BasePage

      page_url /#{MemberManagement::Helper::BaseHelper.get_base_url}\/organizations\/\d*\/cart\/checkout\/billing/
      title 'Member Management | Billings'
      expected_element 'link', {css: 'nav.breadcrumb > ul > li > a'}

      # Billing nformation elements
      text_field(:billing_first_name, {id: 'billing_first_name'})
      text_field(:billing_last_name, {id: 'billing_last_name'})
      text_field(:billing_email, {id: 'billing_email'})
      text_field(:billing_phone_number, {id: 'billing_phone'})
      text_field(:billing_street_address, {id: 'billing_street_1'})
      text_field(:billing_secondary_address, {id: 'billing_street_2'})
      text_field(:billing_city, {id: 'billing_city'})
      unstylized_select(:billing_state, {id: 'billing_state_or_province'})
      text_field(:billing_zipcode, {id: 'billing_zip'})
      unstylized_select(:billing_country, {id: 'billing_country'})

      # Shipping information elements
      single_checkbox(:shipping_equal_billing, {id: 'shipping_populate_with_billing'})
      text_field(:shipping_first_name, {id: 'shipping_first_name'})
      text_field(:shipping_last_name, {id: 'shipping_last_name'})
      text_field(:shipping_email, {id: 'shipping_email'})
      text_field(:shipping_phone_number, {id: 'shipping_phone'})
      text_field(:shipping_street_address, {id: 'shipping_street_1'})
      text_field(:shipping_secondary_address, {id: 'shipping_street_2'})
      text_field(:shipping_city, {id: 'shipping_city'})
      unstylized_select(:shipping_state, {id: 'shipping_state_or_province'})
      text_field(:shipping_zipcode, {id: 'shipping_zip'})
      unstylized_select(:shipping_country, {id: 'shipping_country'})

      # Confirm information elements
      button(:go_back, {css: 'div.form-actions a.button'})
      button(:save_and_continue, {css: 'div.form-actions input.save'})
    end
  end
end
