require_relative '../member_management_base_page'

module MemberManagement
  module Page
    # Page Object for the Organization Choose Variations page of Member Management.
    class OrgChooseVariations < MemberManagement::Page::BasePage

      page_url /#{MemberManagement::Helper::BaseHelper.get_base_url}\/organizations\/\d*\/resource_purchase\/membership_organization\/choose_variation/
      title 'Member Management | Choose_variations'
      expected_element 'link', {css: 'nav.breadcrumb > ul > li > a'}
    end
  end
end
