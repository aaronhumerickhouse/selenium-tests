require_relative '../member_management_base_page'

module MemberManagement
  module Page
    # Page Object for the choose membership page of Member Management.
    class ChooseMembershipLevel < MemberManagement::Page::BasePage

      page_url /#{MemberManagement::Helper::BaseHelper.get_base_url}\/organizations\/\d*\/membership_initiation\/choose_membership_level/
      title 'Member Management | Choose_membership_levels'
      expected_element 'link', {css: 'nav.breadcrumb > ul > li > a'}

      selectize_search(:search, {css: 'div.select-MembershipOrganization'})
      text_field(:search_clubs, {css: 'div.select-MembershipOrganization input'})
      selectize_dropdown(:club_dropdown, {css: 'div.select-MembershipOrganization div.selectize-dropdown'})
      single_checkboxes(:membership_checkboxes, {css: 'input.single-checkbox'})

      # Athlete Memberships
      single_checkbox(:open_license, {xpath: "//h1[contains(text(), 'Open License')]/../../../input"})
      single_checkbox(:athlete_membership, {xpath: "//h1[contains(text(), 'Athlete Membership')]/../../../input"})
      single_checkbox(:limited_athlete_membership, {xpath: "//h1[contains(text(), 'Limited Folkstyle Athlete Membership')]/../../../input"})
      single_checkbox(:full_athlete_membership, {xpath: "//h1[contains(text(), 'Full Athlete Membership')]/../../../input"})
      single_checkbox(:high_performance_athlete_membership, {xpath: "//h1[contains(text(), 'High Performance Athlete Membership')]/../../../input"})
      single_checkbox(:upgrade_limited_to_full, {xpath: "//h1[contains(text(), 'Athlete Upgrade (Limited to Full)')]/../../../input"})
      single_checkbox(:upgrade_limited_to_high_performance, {xpath: "//h1[contains(text(), 'Athlete Upgrade (Limited to High Performance)')]/../../../input"})
      single_checkbox(:upgrade_full_to_high_performance, {xpath: "//h1[contains(text(), 'Athlete Upgrade (Full to High Performance)')]/../../../input"})

      # Coach Memberships
      single_checkbox(:coach_membership_one_year, {xpath: "//h1[contains(text(), '1 Year')]/../../../input"})
      single_checkbox(:coach_membership_two_year, {xpath: "//h1[contains(text(), '2 Year')]/../../../input"})

      # Official Memberships
      single_checkbox(:official_license_one_year, {xpath: "//h1[contains(text(), '1 Year')]/../../../input"})
      single_checkbox(:official_license_two_year, {xpath: "//h1[contains(text(), '2 Year')]/../../../input"})

      # High Performance Leader Memberships
      single_checkbox(:high_performance_leader_one_year, {xpath: "//h1[contains(text(), '1-Year')]/../../../input"})
      single_checkbox(:high_performance_leader_two_year, {xpath: "//h1[contains(text(), '2-Year')]/../../../input"})

      # Booster Club Memberships
      single_checkbox(:booster_club_membership_basic, {xpath: "//h1[contains(text(), 'Basic')]/../../../input"})
      single_checkbox(:booster_club_membership_bronze, {xpath: "//h1[contains(text(), 'Bronze')]/../../../input"})
      single_checkbox(:booster_club_membership_silver, {xpath: "//h1[contains(text(), 'Silver')]/../../../input"})
      single_checkbox(:booster_club_membership_gold, {xpath: "//h1[contains(text(), 'Gold')]/../../../input"})

      # Show Description
      h2(:show_description, {class: 'description-toggler'})

      # Club Selection
      stylized_select(:select_your_club, {xpath: "./../div[contains(@class,'selectize-control')]/div[contains(@class, 'selectize-input')]"})

      # Confirm action elements
      link(:go_back, {css: 'div.form-actions > a'})
      button(:start_background_screen, {css: 'form.button_to input.save'})
      button(:save_and_continue, {css: 'div.form-actions > input'})

      # @return [Boolean] True if a background screen is required
      def is_background_screening_required_present?
        start_background_screen.present? && start_background_screen.value == 'Start Background Screen'
      end

    end
  end
end
