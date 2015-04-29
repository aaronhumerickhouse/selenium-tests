require_relative '../member_management_base_page'

module MemberManagement
  module Page
    # Page Object for the choose membership page of Member Management.
    class ChooseMembership < MemberManagement::Page::BasePage

      page_url /#{MemberManagement::Helper::BaseHelper.get_base_url}\/organizations\/\d*\/membership_initiation\/choose_membership/
      title 'Member Management | Choose_memberships'
      expected_element 'link', {css: 'a.button.key', index: 0}

      link(:athlete_add_membership, {id: 'add-athlete'})
      link(:coach_add_membership, {id: 'add-coach'})
      link(:official_add_membership, {id: 'add-official'})
      link(:high_performance_leader_add_membership, {id: 'add-high-performance-leader'})
      link(:booster_club_add_membership, {id: 'add-booster-club_membership'})
      link(:basic_user_add_membership, {id: 'add-basic-user'})
    end
  end
end

