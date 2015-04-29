require_relative '../base_member_management_helper'
require_relative '../../../pages/member_management/member_initiation/additional_items_page'


module MemberManagement
  module Helper
    #Helper methods for Additional Items
    class AdditionalItems < MemberManagement::Helper::BaseHelper

      # Check the plastic membership card box and continue to next page
      def self.purchase_membership_card_and_save
        additional_items_page = MemberManagement::Page::AdditionalItems.new $browser
        additional_items_page.plastic_membership_card.check
        additional_items_page.save_and_continue.click
      end

      # Don't check the plastic membership card box and continue to next page
      def self.skip_card_purchase_and_save
        additional_items_page = MemberManagement::Page::AdditionalItems.new $browser
        additional_items_page.save_and_continue.click
      end
    end
  end
end
