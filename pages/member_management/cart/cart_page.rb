require_relative '../member_management_base_page'

module MemberManagement
  module Page
    # Page Object for the cart page of Member Management.
    class Cart < MemberManagement::Page::BasePage
      page_url /#{MemberManagement::Helper::BaseHelper.get_base_url}\/organizations\/\d*\/cart/
      title 'Member Management | Carts'
      expected_element 'link', {css: 'nav.breadcrumb > ul > li > a'}

      shopping_cart_rows(:shopping_cart_rows, {css: 'table.mm-table.cart'})
      button(:empty_cart, {css: "div.form-actions input[value='Empty Cart']"})
      link(:proceed_to_checkout, {css: 'div.form-actions a.save'})

      td(:grand_total, css: 'table.cart-summary tr:nth-of-type(1) td')

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
