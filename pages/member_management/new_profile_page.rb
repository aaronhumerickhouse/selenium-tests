require_relative 'member_management_base_page'

module MemberManagement
  module Page
    class NewProfile < MemberManagement::Page::BasePage
      page_url /#{MemberManagement::Helper::BaseHelper.get_base_url}\/organizations\/\d*\/profiles\/new/
      title 'Member Management | Profiles'
      expected_element 'article', {css: 'article.globalNav'}

      #User profile elements
      text_field(:first_name, {id: 'profile_first_name'})
      text_field(:last_name, {id: 'profile_last_name'})
      unstylized_select(:date_of_birth_month, {id: 'profile_date_of_birth_month'})
      unstylized_select(:date_of_birth_day, {id: 'profile_date_of_birth_day'})
      unstylized_select(:date_of_birth_year, {id: 'profile_date_of_birth_year'})
      unstylized_select(:gender, {id: 'profile_gender'})

      #Address elements
      text_field(:email_address, {id: 'profile_email_addresses_attributes_0_address'})
      text_field(:street_address, {id: 'profile_addresses_attributes_0_street_1'})
      text_field(:secondary_address, {id: 'profile_addresses_attributes_0_street_2'})
      text_field(:city, {id: 'profile_addresses_attributes_0_city'})
      unstylized_select(:state, {id: 'profile[addresses_attributes][0]_state_or_province'})
      text_field(:zip_code, {id: 'profile_addresses_attributes_0_zip'})
      unstylized_select(:country, {id: 'profile[addresses_attributes][0]_country'})
      text_field(:phone_number, {id: 'profile_phone_numbers_attributes_0_number'})

      button(:create_profile, {css: 'input.save'})
    end
  end
end
