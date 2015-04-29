require_relative '../member_management_base_page'

module MemberManagement
  module Page
    # Page Object for the Donation Page in Member Management
    class Donation < MemberManagement::Page::BasePage
      page_url /#{MemberManagement::Helper::BaseHelper.get_base_url}\/organizations\/\d*\/cart\/checkout/
      title 'Member Management | Donations'
      expected_element 'link', {css: 'nav.breadcrumb > ul > li > a'}

      unstylized_select(:program, css: 'select.custom-select')
      text_field(:amount, css: 'input#donation_amount')
      link(:skip, css: 'div.form-actions a.button')
      button(:save_and_continue, css: 'div.form-actions input.save')
    end
  end
end
