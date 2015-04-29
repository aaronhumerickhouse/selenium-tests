require_relative '../member_management_base_page'

module MemberManagement
  module Page
    # Page Object for the Waivers & Policies page of Member Management.
    class WaiversAndPolicies < MemberManagement::Page::BasePage

      page_url /#{MemberManagement::Helper::BaseHelper.get_base_url}\/organizations\/\d*\/membership_initiation\/review_item/
      title 'Member Management | Review_items'
      expected_element 'link', {css: 'nav.breadcrumb > ul > li > a'}

    # iframe elements
      iframe(:safe_sport_policy, {index: 0})
      iframe(:consent_waiver, {index: 1})

      #Consent form checkboxes elements
      single_checkbox(:safe_sport_policy_checkbox, {css: "input[type='checkbox']", index: 0})
      single_checkbox(:consent_waiver_checkbox, {css: "input[type='checkbox']", index: 1})

      # Confirm waiver elements
      text_field(:sign_waiver, {id: 'membership_signature'})

      button(:go_back, {css: 'form > div > a.button'})
      button(:add_to_cart, {css: 'form > div > input.save'})
    end
  end
end

