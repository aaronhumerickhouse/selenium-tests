require_relative '../member_management_base_page'

module MemberManagement
  module Page
    # Page Object for the Organization Additional Information page of Member Management.
    class OrgAdditionalInformation < MemberManagement::Page::BasePage

      page_url /#{MemberManagement::Helper::BaseHelper.get_base_url}\/organizations\/\d*\/resource_purchase\/membership_organization\/custom_object_information/
      title 'Member Management | Custom_object_informations'
      expected_element 'link', {css: 'nav.breadcrumb > ul > li > a'}

      # Club Information
      text_field(:approximate_coach_count, {id: 'membership_organization_custom_objects_attributes_0_values_approximate_coach_count'})
      text_field(:approximate_athlete_count, {id: 'membership_organization_custom_objects_attributes_0_values_approximate_athlete_count'})
      text_field(:athlete_ages, {id: 'membership_organization_custom_objects_attributes_0_values_athlete_ages'})
      stylized_select(:months_of_operation, {xpath: "//*[@id='membership_organization_custom_objects_attributes_0_values_months_of_operation']"})
      stylized_select(:beach_percentage, {xpath: "//*[@id='membership_organization_custom_objects_attributes_0_values_beach_percentage']"})
      stylized_select(:folkstyle_percentage, {xpath: "//*[@id='membership_organization_custom_objects_attributes_0_values_folkstyle_percentage']"})
      stylized_select(:freestyle_percentage, {xpath: "//*[@id='membership_organization_custom_objects_attributes_0_values_freestyle_percentage']"})
      stylized_select(:grappling_percentage, {xpath: "//*[@id='membership_organization_custom_objects_attributes_0_values_grappling_percentage']"})
      stylized_select(:greco_percentage, {xpath: "//*[@id='membership_organization_custom_objects_attributes_0_values_greco_percentage']"})
      stylized_select(:sombo_percentage, {xpath: "//*[@id='membership_organization_custom_objects_attributes_0_values_sombo_percentage']"})
      stylized_select(:place_on_the_mat_list, {xpath: "//*[@id='membership_organization_custom_objects_attributes_0_values_place_on_the_mat_com_list']"})

      button(:save_and_continue, {css: 'div.form-actions input.save'})
    end
  end
end
