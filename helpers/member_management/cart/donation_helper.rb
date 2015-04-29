require_relative '../base_member_management_helper'
require_relative '../../../pages/member_management/cart/donation_page'


module MemberManagement
  module Helper
    #Helper methods for Donation
    class Donation < MemberManagement::Helper::BaseHelper

      # Choose Donation program and amount to donate
      # @param program [String] The program to donate to
      # @param amount [String] The amount to donate
      def self.make_a_donation_and_continue(program, amount)
        donation_page = MemberManagement::Page::Donation.new $browser
        donation_page.program.select_text(program)
        donation_page.amount.value = amount
        donation_page.save_and_continue.click
      end

      # Skip making a donation
      def self.skip_making_donation
        donation_page = MemberManagement::Page::Donation.new $browser
        donation_page.skip.click
      end
    end
  end
end
