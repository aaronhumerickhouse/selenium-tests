require_relative '../member_management_base_page'

module MemberManagement
  module Page
    # Page Object for the Organization Waivers and Policies page of Member Management.
    class OrgWaiversAndPolicies < MemberManagement::Page::BasePage

      page_url /#{MemberManagement::Helper::BaseHelper.get_base_url}\/organizations\/\d*\/resource_purchase\/membership_organization\/add_to_cart/
      title 'Member Management | Add_to_carts'
      expected_element 'link', {css: 'nav.breadcrumb > ul > li > a'}

      # iframe elements
      iframe(:chartered_clubs, {index: 0})

      #Consent form checkbox element
      single_checkbox(:chartered_clubs_checkbox, {css: "input[type='checkbox']", index: 0})

      # Confirm waiver elements
      text_field(:sign_waiver, {id: 'membership_organization_signature'})

      button(:go_back, {css: 'form > div > a.button'})
      button(:add_to_cart, {css: 'form > div > input.save'})
    end
  end
end
