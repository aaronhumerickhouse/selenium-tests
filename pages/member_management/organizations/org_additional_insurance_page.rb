require_relative '../member_management_base_page'

module MemberManagement
  module Page
    # Page Object for the Add Additional Insurance page of Member Management.
    class OrgAdditionalInsurance < MemberManagement::Page::BasePage
      page_url /#{MemberManagement::Helper::BaseHelper.get_base_url}\/organizations\/\d*\/resource_purchase\/custom_object\?after_purchase_path.*/
      title 'Member Management | Informations'
      expected_element 'link', {css: 'nav.breadcrumb > ul > li > a'}

      text_field(:certificate_holder, {id: 'custom_object_values_certificate_holder'})
      text_field(:description_of_certificate_holder, {id: 'custom_object_values_facility_name'})
      text_field(:primary_address, {id: 'custom_object_values_address'})
      text_field(:secondary_address, {id: 'custom_object_values_address_2'})
      text_field(:city, {id: 'custom_object_values_city'})
      stylized_select(:state, {xpath: "//*[@id='custom_object_values_state']"})
      text_field(:zip, {id: 'custom_object_values_zip'})
      text_field(:email, {id: 'custom_object_values_contact_email'})

      button(:add_to_cart, {css: 'div.form-actions input.save'})
    end
  end
end
