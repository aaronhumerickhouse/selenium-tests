require_relative '../../helpers/default_watir'
require_relative 'dashboard_membership'

module MemberManagement
  module Component
    # Class for the Profile component on the Dashboard page
    class DashboardProfile

      # Initializes the dashboard profile component
      def initialize(selector)
        @selector = selector
      end

      # Returns the name of the member used in the profile.
      # @return [String] The name of the member used in the profile
      def name
        $browser.element(@selector).h1(css: 'h1').text
      end

      # Returns the gender of the member used in the profile.
      # # @return [String] The gender of the member used in the profile
      def gender
        $browser.element(@selector).span(css: 'span').text.split(', ')[0]
      end

      # Returns the age of the member used in the profile.
      # @return [String] The age of the member used in the profile
      def age
        $browser.element(@selector).span(css: 'span').text.split(', ')[1]
      end

      # Clicks the 'Add New' link in a profile
      def click_add_new
        add_new = $browser.element(@selector).link(text: 'Add New')
        add_new.click
      end

      # Clicks the 'Become a Member' link in a profile
      def click_become_a_member
        add_new = $browser.element(@selector).link(text: 'Become a Member')
        add_new.click
      end

      # Does the profile have memberships?
      # @return [Boolean] true if memberships > 0 else false
      def has_memberships?
        how_many_memberships? > 0
      end

      # Returns the amount of memberships a profile has.
      # @return [Integer] The amount of memberships a profile has.
      def how_many_memberships?
        $browser.element(@selector).divs(css: 'div.dashboard-membership').size
      end

      # Returns all memberships under a profile
      # @return [DashboardMembership Array, nil] An array of DashboardMembership objects or nil if none found
      def get_memberships
        return nil unless has_memberships?

        parent_css = "div.profile-list > div:nth-of-type(#{@selector[:index] + 1})"
        profile_css = @selector[:css]
        membership_css = 'div.dashboard-membership'
        new_selector = "#{parent_css} #{profile_css} #{membership_css}"

        (0..how_many_memberships? - 1).collect { |index| MemberManagement::Component::DashboardMembership.new(css: new_selector, index: index) }
      end

      # Finds a specific membership of a member
      # @param type [String] The type of membership, ie 'Official'
      # @return [DashboardMembership] The membership that matches the type
      def get_membership(type)
        memberships = get_memberships
        memberships.each do |membership|
          return membership if membership.type == type
        end
        raise StandardError.new "Membership type #{type} not found for member #{name}"
      end

      # Clicks Add New or Become a Member
      def add_member
        become_member = $browser.element(@selector).link(text: 'Become a Member')
        become_member.click if become_member.exist?

        add_new = $browser.element(@selector).link(text: 'Add New')
        add_new.click if add_new.exist?
      end
    end
  end
end

