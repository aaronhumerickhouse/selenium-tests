require_relative 'member_management_base_page'

module MemberManagement
  module Page
    # Page Object for the Dashboard page in Member Management
    class Dashboard < MemberManagement::Page::BasePage

      page_url /#{MemberManagement::Helper::BaseHelper.get_base_url}\/organizations\/\d*\/dashboard/
      title 'Member Management | Dashboard'
      expected_element 'span', {css: 'div.user-bar > nav > ul > li > a > span', index: 1} #Dashboard text on navbar

      dashboard_profile(:first_profile, {css: 'div.dashboard-profile', index: 0})
      dashboard_membership(:first_membership, {css: 'div.dashboard-membership', index: 0})

      dashboard_profiles(:all_profiles, {css: 'div.dashboard-profile'})
      dashboard_memberships(:all_memberships, {css: 'div.dashboard-membership'})

      link(:add_profile, {css: 'a.button.right'})
    end
  end
end

