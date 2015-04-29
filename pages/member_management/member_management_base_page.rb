require_relative '../generic_base_page'
require_relative '../../helpers/member_management/base_member_management_helper'
require_relative '../../components/member_management/dashboard_membership'
require_relative '../../components/member_management/dashboard_profile'
require_relative '../../components/member_management/unstylized_select'
require_relative '../../components/member_management/stylized_select'
require_relative '../../components/member_management/selectize_dropdown'
require_relative '../../components/member_management/single_checkbox'
require_relative '../../components/member_management/selectize_search'
require_relative '../../components/member_management/shopping_cart_row'

module MemberManagement
  # Namespace for all MemberManagement Pages.
  module Page
    # The base page for Member Management.  Common elements, like headers and footers, will be included here.
    class BasePage < GenericBasePage
      NAV = 'navigation-'
      link(:navigation_info_and_personnel, id: "#{NAV}info-and-personnel")
      link(:navigation_events, id: "#{NAV}events")
      link(:navigation_members, id: "#{NAV}members")
      link(:navigation_organizations, id: "#{NAV}organizations")
      link(:navigation_become_a_member, id: "#{NAV}become-a-member")
      link(:navigation_store_management, id: "#{NAV}store-management")
      link(:navigation_reports, id: "#{NAV}reports")
      link(:navigation_approvals, id: "#{NAV}approvals")
      link(:navigation_background_screens, id: "#{NAV}background-checks")
      link(:navigation_audit_history, id: "#{NAV}audit-history")
      link(:navigation_administration, id: "#{NAV}administration")
      link(:dashboard, title: 'Dashboard')
      link(:cart, title: 'Cart')
      link(:sign_out, css: 'a.sign-out')

      ##################################### MEMBER MANAGEMENT COMPONENT INITIATION #####################################

      # For each dashboard_membership() defined in the page object these methods are added:
      # * <name> - Returns the dashboard_membership
      # @param element_name [String] The desired name for the new dashboard_membership.
      # @param selector [Hash] The selector for the new dashboard_membership.
      def self.dashboard_membership(element_name, selector)
        define_method element_name.to_s do
          MemberManagement::Component::DashboardMembership.new(selector)
        end
      end

      # For each dashboard_memberships() defined in the page object these methods are added:
      # * <name> - Returns the dashboard_memberships
      # @param element_name [String] The desired name for the new dashboard_memberships.
      # @param selector [Hash] The selector for the new dashboard_memberships.
      def self.dashboard_memberships(element_name, selector)
        define_method element_name.to_s do
          found_elements = @browser.elements(selector)
          (0..found_elements.size - 1).collect { |index| MemberManagement::Component::DashboardMembership.new(css: selector[:css], index: index) }
        end
      end

      # For each dashboard_profile() defined in the page object these methods are added:
      # * <name> - Returns the dashboard_profile
      # @param element_name [String] The desired name for the new dashboard_profile.
      # @param selector [Hash] The selector for the new dashboard_profile.
      def self.dashboard_profile(element_name, selector)
        define_method element_name.to_s do
          MemberManagement::Component::DashboardProfile.new(selector)
        end
      end


      # For each dashboard_profiles() defined in the page object these methods are added:
      # * <name> - Returns an array of dashboard_profiles
      # @param element_name [String] The desired name for the new dashboard_profiles.
      # @param selector [Hash] The selector for the new dashboard_profiles.
      def self.dashboard_profiles(element_name, selector)
        define_method element_name.to_s do
          found_elements = @browser.elements(selector)
          (0..found_elements.size - 1).collect { |index| MemberManagement::Component::DashboardProfile.new(css: selector[:css], index: index) }
        end
      end

      # For each unstylized_select() defined in the page object these methods are added:
      # * <name> - Returns the unstylized_select
      # @param element_name [String] The desired name for the new unstylized_select.
      # @param selector [Hash] The selector of the select element the selector is designed around.
      def self.unstylized_select(element_name, selector)
        define_method element_name.to_s do
          MemberManagement::Component::UnstylizedSelect.new(selector)
        end
      end

      # For each unstylized_selects() defined in the page object these methods are added:
      # * <name> - Returns an array unstylized_selects
      # @param element_name [String] The desired name for the new unstylized_select.
      # @param selector [Hash] The selector of the select element the selector is designed around.
      def self.unstylized_selects(element_name, selector)
        define_method element_name.to_s do
          found_elements = @browser.elements(selector)
          (0..found_elements.size - 1).collect { |index| MemberManagement::Component::UnstylizedSelect.new(css: selector[:css], index: index) }
        end
      end

      # For each stylized_select() defined in the page object these methods are added:
      # * <name> - Returns the stylized_select
      # @param element_name [String] The desired name for the new stylized_select.
      # @param selector [Hash] The selector of the select element the selector is designed around.
      def self.stylized_select(element_name, selector)
        define_method element_name.to_s do
          MemberManagement::Component::StylizedSelect.new(selector)
        end
      end

      # For each stylized_selects() defined in the page object these methods are added:
      # * <name> - Returns an array stylized_selects
      # @param element_name [String] The desired name for the new stylized_select.
      # @param selector [Hash] The selector of the select element the selector is designed around.
      def self.stylized_selects(element_name, selector)
        define_method element_name.to_s do
          found_elements = @browser.elements(selector)
          (0..found_elements.size - 1).collect { |index| MemberManagement::Component::StylizedSelect.new(css: selector[:css], index: index) }
        end
      end

      # For each selectize_dropdown() defined in the page object these methods are added:
      # * <name> - Returns the selectize_dropdown
      # @param element_name [String] The desired name for the new selectize_dropdown.
      # @param selector [Hash] The selector of the select element the selector is designed around.
      def self.selectize_dropdown(element_name, selector)
        define_method element_name.to_s do
          MemberManagement::Component::SelectizeDropdown.new(selector)
        end
      end

      # For each selectize_dropdowns() defined in the page object these methods are added:
      # * <name> - Returns the selectize_dropdowns
      # @param element_name [String] The desired name for the new selectize_dropdowns.
      # @param selector [Hash] The selector of the select element the selector is designed around.
      def self.selectize_dropdowns(element_name, selector)
        define_method element_name.to_s do
          found_elements = @browser.elements(selector)
          (0..found_elements.size - 1).collect { |index| MemberManagement::Component::SelectizeDopdown.new(css: selector[:css], index: index) }
        end
      end

      # For each single_checkbox() defined in the page object these methods are added:
      # * <name> - Returns the single_checkbox
      # @param element_name [String] The desired name for the new single_checkbox.
      # @param selector [Hash] The selector of the input element of the checkbox.
      def self.single_checkbox(element_name, selector)
        define_method element_name.to_s do
          MemberManagement::Component::SingleCheckbox.new(selector)
        end
      end

      # For each single_checkboxes() defined in the page object these methods are added:
      # * <name> - Returns the single_checkboxes
      # @param element_name [String] The desired name for the new single_checkboxes.
      # @param selector [Hash] The selector of the input element of the checkbox.
      def self.single_checkboxes(element_name, selector)
        define_method element_name.to_s do
          found_elements = @browser.elements(selector)
          (0..found_elements.size - 1).collect { |index| MemberManagement::Component::SingleCheckbox.new(css: selector[:css], index: index) }
        end
      end

      # For each selectize_search() defined in the page object these methods are added:
      # * <name> - Returns the selectize_search
      # @param element_name [String] The desired name for the new selectize_search.
      # @param selector [Hash] The selector of the select element the selector is designed around.
      def self.selectize_search(element_name, selector)
        define_method element_name.to_s do
          MemberManagement::Component::SelectizeSearch.new(selector)
        end
      end

      # For each selectize_searches() defined in the page object these methods are added:
      # * <name> - Returns the selectize_searches
      # @param element_name [String] The desired name for the new selectize_searches.
      # @param selector [Hash] The selector of the select element the selector is designed around.
      def self.selectize_searches(element_name, selector)
        define_method element_name.to_s do
          found_elements = @browser.elements(selector)
          (0..found_elements.size - 1).collect { |index| MemberManagement::Component::SelectizeSearch.new(css: selector[:css], index: index) }
        end
      end

      # For each shopping_cart_row() defined in the page object these methods are added:
      # * <name> - Returns the shopping_cart_row
      # @param element_name [String] The desired name for the new shopping_cart_row.
      # @param selector [Hash] The selector of the shopping_cart_row.
      def self.shopping_cart_row(element_name, selector)
        define_method element_name.to_s do
          MemberManagement::Component::ShoppingCartRow.new(selector)
        end
      end

      # For each shopping_cart_rows() defined in the page object these methods are added:
      # * <name> - Returns the shopping_cart_rows
      # @param element_name [String] The desired name for the new shopping_cart_rows.
      # @param selector [Hash] The selector of the table the rows are in.
      def self.shopping_cart_rows(element_name, selector)
        define_method element_name.to_s do
          found_elements = @browser.elements(css: "#{selector[:css]} tbody tr")
          (0..found_elements.size - 1).collect { |index| MemberManagement::Component::ShoppingCartRow.new(css: "#{selector[:css]} tbody tr", index: index) }
        end
      end
      ################################### END MEMBER MANAGEMENT COMPONENT INITIATION ###################################



      #elements common across MULTIPLE mm pages

      #header

      #footer

      #navigation
    end
  end
end
