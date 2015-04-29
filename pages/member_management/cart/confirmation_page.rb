require_relative '../member_management_base_page'
module MemberManagement
  module Page
    # Page Object for the confirmation page of Member Management.
    class Confirmation < MemberManagement::Page::BasePage
      page_url /#{MemberManagement::Helper::BaseHelper.get_base_url}\/organizations\/\d*\/cart\/checkout\/confirmation/
      title 'Member Management | Confirmations'
      expected_element 'link', {css: 'nav.breadcrumb > ul > li > a'}

      #Order
      link(:print_card, css: 'a.button.save')

      #Billing & Shipping
      div(:billing_information, id: 'billing-information')
      div(:shipping_information, id: 'shipping-information')

      #Cart
      shopping_cart_rows(:shopping_cart_rows, css: 'table.mm-table.cart')

      #Cart summary
      cart_summary_css = 'table.cart-summary'
      td(:grand_total, css: "#{cart_summary_css} tr:nth-of-type(1) td")
      td(:payment, css: "#{cart_summary_css} tr:nth-of-type(2) td")
      td(:amount_due, css:"#{cart_summary_css} tr:nth-of-type(3) td")

      # Finds a row in the shopping cart based on its type.
      # @param type [String] The type of item it is, ie Athlete Membership, Coach Membership, Plastic Card
      # @return [ShoppingCartRow] The shopping cart row represented by the type.
      def find_row_by_type(type)
        shopping_cart_rows.each do |row|
          return row if row.type == type
        end
        raise StandardError.new "Row with type #{type} not found."
      end
    end
  end
end
