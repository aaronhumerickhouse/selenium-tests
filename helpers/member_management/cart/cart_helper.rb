require_relative '../base_member_management_helper'
require_relative '../../../pages/member_management/cart/cart_page'


module MemberManagement
  module Helper
    #Helper methods for Cart
    class Cart < MemberManagement::Helper::BaseHelper
      #Clicks proceed ot checkout
      def self.proceed_to_checkout
        cart_page = MemberManagement::Page::Cart.new $browser
        cart_page.proceed_to_checkout.click
      end
    end
  end
end

