require_relative '../../../helpers/member_management/purchase_membership_helpers'
require_relative '../../../verifications/member_management/purchase_membership_verifications'
require_relative '../../../utilities/faker_data'

include MemberManagement::Verification::PurchaseMembership
include FakerData

describe 'An existing adult member', :mm_smoke do
  before :all do
    begin
      @basic_user = MemberManagement::Helper::BaseHelper.get_credentials('adult_athlete')
      @member_data = person(adult: true, city: 'Minneapolis', state: 'Minnesota', zip_code: '55413', country: 'United States of America')

      # Sign in
      $browser.goto MemberManagement::Helper::BaseHelper.get_base_url
      MemberManagement::Helper::Landing.sign_in @basic_user[:username], @basic_user[:password]
    rescue => ex
      $has_errors = true
      raise ex
    end
  end

  it 'is able to purchase a new athlete membership' do
    # Create a Profile with Athlete membership
    MemberManagement::Helper::Dashboard.become_a_member_reverse('Selenium AdultAthlete')
    MemberManagement::Helper::ChooseMembership.choose_athlete_membership_type
    MemberManagement::Helper::CreateProfile.create_new_profile_under_this_account(get_profile_data(@member_data))

    # Select Membership and Club, Skip card purchase, Sign Policies
    MemberManagement::Helper::ChooseMembershipLevel.choose_membership_level_and_club('Open License', 'Minnesota Gophers')
    MemberManagement::Helper::AdditionalItems.skip_card_purchase_and_save
    MemberManagement::Helper::WaiversAndPolicies.accept_and_sign_policies('Automation')

    # Verify Cart Contents
    verify_cart_shopping_cart_size(1)
    verify_cart_shopping_cart_grand_total('$50.00')
    verify_cart_shopping_cart_row(type: 'Athlete Membership', description: "#{@member_data[:full_name]} - Open License", quantity: '1', price: '50.00')

    # Make Purchase without donation
    MemberManagement::Helper::Cart.proceed_to_checkout
    MemberManagement::Helper::Donation.skip_making_donation
    MemberManagement::Helper::BillingAndShipping.populate_same_billing_and_shipping_information_save(get_billing_information(@member_data))

    # Verify Cart
    verify_review_shopping_cart_size(1)
    verify_review_shopping_cart_grand_total('$50.00')
    verify_review_shopping_cart_row(type: 'Athlete', description: 'Open License', quantity: '1', price: '50.00')
    verify_review_billing_and_shipping_info_same

    # Add payment information and purchase
    MemberManagement::Helper::Review.populate_credit_card_information_and_continue(get_credit_information(@member_data, MemberManagement::Helper::Review.credit_cards['approved'], 'June', '2060', '252'))

    # Verify purchased membership information
    verify_confirmation_shopping_cart_size(1)
    verify_confirmation_shopping_cart_totals('$50.00', '$50.00', '$0.00')
    verify_confirmation_shopping_cart_row(type: 'Athlete Membership', description: 'Open License', quantity: '1', price: '50.00')
    verify_confirmation_billing_and_shipping_info_same

    # Verify the new profile and membership are present on Dashboard
    MemberManagement::Helper::Confirmation.navigate_to_dashboard
    verify_new_membership(full_name: @member_data[:full_name], type: 'Athlete', level: 'Open License', expiration_date: '08-31-2015', upgrade: false)
  end

  after :all do
    #TODO delete
    # Clear cart if not clear
    MemberManagement::Helper::BaseHelper.clear_cart_contents
  end
end
