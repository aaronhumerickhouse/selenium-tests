require_relative '../member_management_base_page'

module MemberManagement
  module Page
    # Page Object for the Additional Items page in Member Management
  class AdditionalItems < MemberManagement::Page::BasePage
      page_url /#{MemberManagement::Helper::BaseHelper.get_base_url}\/organizations\/\d*\/membership_initiation\/additional_item/
      title 'Member Management | Additional_items'
      expected_element 'link', {css: 'nav.breadcrumb > ul > li > a'}

      link(:go_back, css: 'div.form-actions > a')
      button(:save_and_continue, css: 'div.form-actions > input')

      single_checkbox(:plastic_membership_card, xpath: "//h1[contains(text(), 'Plastic Membership Card')]/../../input")
    end
  end
end
