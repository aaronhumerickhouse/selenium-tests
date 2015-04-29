require_relative '../member_management_base_page'
module MemberManagement
  module Page
    # Page Object for the Review and Pay of Member Management.
    class Review < MemberManagement::Page::BasePage
      page_url /#{MemberManagement::Helper::BaseHelper.get_base_url}\/organizations\/\d*\/cart\/checkout\/review/
      title 'Member Management | Reviews'
      expected_element 'link', {css: 'nav.breadcrumb > ul > li > a'}

      #Payment Information
      text_field(:credit_card_number, css: '#payment_method_acct_num')
      text_field(:credit_card_first_name, css: '#payment_method_fname')
      text_field(:credit_card_last_name, css: '#payment_method_lname')
      unstylized_select(:credit_card_expiration_month, css: '#date_month')
      text_field(:credit_card_expiration_year, css: '#date_year')
      text_field(:credit_card_cvv_code, css: '#payment_method_verification')

      unstylized_select(:payment_method, {css: '#payment_type'})

      button(:submit_order, css: 'div.form-actions input.save')

      #Review Information
      div(:bill_to, css: 'div#billing-information')
      link(:edit_bill_to, css: 'div#billing-information a', index: 1)
      div(:ship_to, css: 'div#shipping-information')
      link(:edit_bill_to, css: 'div#shipping-information a', index: 1)

      shopping_cart_rows(:shopping_cart_rows, css: 'table.mm-table.cart')

      td(:grand_total, css: 'table.cart-summary tr:nth-of-type(1) td')

      # Finds a row in the shopping cart based on its type.
      # @param type [String] The type of item it is, ie Athlete Membership, Coach Membership, Plastic Card
      # @return [ShoppingCartRow] The shopping cart row represented by the type.
      def find_row_by_type(type)
        shopping_cart_rows.each do |row|
          return row if row.type == type
        end
        raise StandardError.new "No row matching the type #{type}."
      end
    end
  end
end
