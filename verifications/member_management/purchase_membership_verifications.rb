require_relative 'cart/cart_verifications'
require_relative 'cart/review_verifications'
require_relative 'cart/confirmation_verifications'
require_relative 'membership_initiation/choose_membership_level_verifications'
require_relative 'dashboard_verifications'

module MemberManagement
  module Verification
    #Module to hold all verifications for the purchase membership process
    module PurchaseMembership
      include MemberManagement::Verification::Cart
      include MemberManagement::Verification::Confirmation
      include MemberManagement::Verification::Review
      include MemberManagement::Verification::ChooseMembershipLevel
      include MemberManagement::Verification::Dashboard
    end
  end
end
