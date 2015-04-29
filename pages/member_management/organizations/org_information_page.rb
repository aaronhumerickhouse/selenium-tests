require_relative '../member_management_base_page'

module MemberManagement
  module Page
    # Page Object for the Membership Organization page of Member Management.
    class OrganizationInformation < MemberManagement::Page::BasePage

      page_url /#{MemberManagement::Helper::BaseHelper.get_base_url}\/organizations\/\d*\/(resource_purchase\/membership_organization|organizations\/new)/
      title /Member Management | (Informations|Membership_organizations)/
      expected_element 'link', {css: 'nav.breadcrumb > ul > li > a'}

      # Organization information
      text_field(:name, id: 'membership_organization_name')
      text_field(:primary_address, id: 'membership_organization_address_attributes_street_1')
      text_field(:secondary_address, id: 'membership_organization_address_attributes_street_2')
      text_field(:city, id: 'membership_organization_address_attributes_city')
      unstylized_select(:country, id: 'membership_organization[address_attributes]_country')
      unstylized_select(:state, id: 'membership_organization[address_attributes]_state_or_province')
      text_field(:zip, id: 'membership_organization_address_attributes_zip')
      text_field(:phone, id: 'membership_organization_phone_number_attributes_number')
      text_field(:fax, id: 'membership_organization_fax_number_attributes_number')
      text_field(:email, id: 'membership_organization_email_address_attributes_address')
      text_field(:website, id: 'membership_organization_website_url')
      selectize_search(:primary_contact, css: 'div.selectize-control.search')
      div(:parent_organization, css: 'div.selectize-input.disabled.locked > div.item')
      button(:save_and_continue, css: 'div.form-actions input.save')

      # Super Admin only fields
      selectize_search(:parent_organization_active, {css: 'div.selectize-control.search.single'})
      button(:save_information, {css: 'div.form-actions input.save'})
      single_checkbox(:membership_organization_published, {id: 'membership_organization_published'})
    end
  end
end

