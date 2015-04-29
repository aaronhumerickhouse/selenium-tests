require_relative '../member_management_base_page'

module MemberManagement
  module Page
    # Page Object for the New Organization > Additional Items page of Member Management.
    class OrgAdditionalItems < MemberManagement::Page::BasePage
      page_url /#{MemberManagement::Helper::BaseHelper.get_base_url}\/organizations\/\d*\/resource_purchase\/membership_organization\/additional_item/
      title 'Member Management | Additional_items'
      expected_element 'link', {css: 'nav.breadcrumb > ul > li > a'}

      link(:add, {css: 'div.field > a'})
      button(:save_and_continue, {css: 'div.form-actions input.save'})

    end
  end
end
