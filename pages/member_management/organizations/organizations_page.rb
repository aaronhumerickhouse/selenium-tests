require_relative '../member_management_base_page'

module MemberManagement
  module Page
    # Page Object for the Organization page of Member Management.
    class Organizations < MemberManagement::Page::BasePage

      page_url /#{MemberManagement::Helper::BaseHelper.get_base_url}\/organizations\/\d*\/organizations/
      title 'Member Management | Membership_organizations'
      expected_element 'link', {css: 'nav.breadcrumb > ul > li > a'}

      link(:add_organization, {css: 'a.button.right.key'})

      # Search criteria
      text_field(:name, {id: 'name_query'})
      text_field(:city, {id: 'city_query'})
      unstylized_select(:state_province, {id: 'state_query_'})
      unstylized_select(:country, {id: 'country_query_'})
      stylized_select(:status, {xpath: "//*[@id='status']"})
      text_field(:organization_id, {id: 'organization_number'})
      button(:search, {css: 'div.form-actions input.save'})

      # Organization table
      organization_table_css = 'table.mm-table'
      td(:organization_name, css: "#{organization_table_css} tbody tr td:nth-of-type(1)")
      td(:organization_email, css: "#{organization_table_css} tbody tr td:nth-of-type(2)")
      td(:organization_phone, css: "#{organization_table_css} tbody tr td:nth-of-type(3)")
      td(:organization_city, css: "#{organization_table_css} tbody tr td:nth-of-type(4)")
      td(:organization_state_province, css: "#{organization_table_css} tbody tr td:nth-of-type(5)")
    end
  end
end
