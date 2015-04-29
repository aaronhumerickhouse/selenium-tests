require_relative '../member_management_base_page'

module MemberManagement
  module Page
    # Page Object for the choose membership page of Member Management.
    class CreateProfile < MemberManagement::Page::BasePage

      page_url /#{MemberManagement::Helper::BaseHelper.get_base_url}\/organizations\/\d*\/membership_initiation\/create_profile/
      title 'Member Management | Create_profiles'
      expected_element 'article', {css: 'article.globalNav'}

      #User profile elements
      unstylized_select(:profile_type, {id: 'profile_select'})
      text_field(:first_name, {id: 'uberprofile_first_name'})
      text_field(:last_name, {id: 'uberprofile_last_name'})
      unstylized_select(:date_of_birth_month, {id: 'uberprofile_date_of_birth_2i'})
      unstylized_select(:date_of_birth_day, {id: 'uberprofile_date_of_birth_3i'})
      unstylized_select(:date_of_birth_year, {id: 'uberprofile_date_of_birth_1i'})
      stylized_select(:gender, {xpath: "//*[@id='uberprofile_gender']"})

      #Address elements
      text_field(:email_address, {id: 'uberprofile_email'})
      text_field(:street_address, {id: 'uberprofile_street_1'})
      text_field(:secondary_address, {id: 'uberprofile_street_2'})
      text_field(:city, {id: 'uberprofile_city'})
      unstylized_select(:state, {id: 'uberprofile_state_or_province'})
      text_field(:zip_code, {id: 'uberprofile_zip'})
      unstylized_select(:country, {id: 'uberprofile_country'})
      text_field(:phone_number, {id: 'uberprofile_phone'})

      #Parent/Guardian elements
      text_field(:parent_one_first_name, {id: 'uberprofile_parent_1_first_name'})
      text_field(:parent_one_last_name, {id: 'uberprofile_parent_1_last_name'})
      text_field(:parent_one_email, {id: 'uberprofile_parent_1_email'})

      text_field(:parent_two_first_name, {id: 'uberprofile_parent_2_first_name'})
      text_field(:parent_two_last_name, {id: 'uberprofile_parent_2_last_name'})
      text_field(:parent_two_email, {id: 'uberprofile_parent_2_email'})

      #Additional Information elements
      stylized_select(:grade_in_school, {xpath: "//*[@id='uberprofile_membership_custom_objects_attributes_0_values_grade_in_school']"})
      text_field(:approximate_weight, {id: 'uberprofile_membership_custom_objects_attributes_0_values_approx_weight'})

      #Save and Continue element
      button(:save_and_continue, {name: 'commit'})

      unstylized_selects(:selects, {css: 'div.custom-select-container select'} )
    end
  end
end

