require_relative 'base_member_management_helper'
require_relative '../../pages/member_management/dashboard_page'

module MemberManagement
  module Helper
    # Helper for Dashboard page
    class Dashboard < MemberManagement::Helper::BaseHelper
      # Add a new member to an existing profile
      # @param name [String] The profile name
      def self.become_a_member(name)
        find_profile(name).add_member
      end

      # Add a new member to an existing profile, looks for the name starting from the bottom
      # @param name [String] The profile name
      def self.become_a_member_reverse(name)
        find_profile_reverse(name).add_member
      end

      # Find an existing profile
      # @param name [String] The profile name
      # @return [MemberManagement::Component::DashboardProfile] The profile of the name
      def self.find_profile(name)
        dashboard_page = MemberManagement::Page::Dashboard.new $browser
        dashboard_page.all_profiles.each do |profile|
          return profile if profile.name == name
        end
        raise StandardError.new "Profile #{name} was not found on Dashboard."
      end

      # Find an existing profile, starts at the bottom searches up
      # @param name [String] The profile name
      # @return [MemberManagement::Component::DashboardProfile] The profile of the name
      def self.find_profile_reverse(name)
        dashboard_page = MemberManagement::Page::Dashboard.new $browser
        dashboard_page.all_profiles.reverse_each do |profile|
          return profile if profile.name == name
        end
        raise StandardError.new "Profile #{name} was not found on Dashboard."
      end

      # Clicks the Add Profile button on the dashboard page
      def self.add_profile
        dashboard_page = MemberManagement::Page::Dashboard.new $browser
        dashboard_page.add_profile.click
      end

      # Clicks the Upgrade link
      # @param data [Hash] The data used to find the profile and its membership
      def self.click_upgrade(data={})
        profile = MemberManagement::Helper::Dashboard.find_profile(data[:full_name])
        membership = profile.get_membership data[:type]
        membership.click_upgrade
      end
    end
  end
end
