require_relative '../base_member_management_helper'
require_relative '../../../pages/member_management/member_initiation/create_profile_page'


module MemberManagement
  module Helper
    # Helper methods for Create Profile
    class CreateProfile < MemberManagement::Helper::BaseHelper

      # Create a new profile under an existing account
      # @param data [Hash] The data used to populate the profile
      # @option profile_data [String] :first_name
      # @option profile_data [String] :last_name
      # @option profile_data [Date] :birthday
      # @option profile_data [String] :gender
      # @option profile_data [String] :email_address
      # @option profile_data [String] :[:address][:street_address]
      # @option profile_data [String] :[:address][:secondary_address]
      # @option profile_data [String] :[:address][:city]
      # @option profile_data [String] :[:address][:state]
      # @option profile_data [String] :[:address][:zip_code]
      # @option profile_data [String] :[:address][:country]
      # @option profile_data [String] :phone_number
      # @param parent_one [Hash]
      # @option parent_one [String] :first_name
      # @option parent_one [String] :last_name
      # @option parent_one [String] :email_address
      # @param parent_two [Hash]
      # @option parent_two [String] :first_name
      # @option parent_two [String] :last_name
      # @option parent_two [String] :email_address
      def self.create_new_profile_under_this_account(data={})
        select_profile('Create a new profile under this account')
        populate_profile(data)
        save_and_continue
      end

      # Clicks save and continue
      def self.save_and_continue
        create_profile_page = MemberManagement::Page::CreateProfile.new $browser
        create_profile_page.save_and_continue.click
      end

      # Select the profile type from the profile type drop down
      # @param type [String] The type of profile being used
      def self.select_profile(type)
        create_profile_page = MemberManagement::Page::CreateProfile.new $browser
        create_profile_page.profile_type.select_text(type)
      end

      # The data used to populate the profile
      # @param data [Hash] The data used to populate the profile
      # @option profile_data [String] :first_name
      # @option profile_data [String] :last_name
      # @option profile_data [Date] :birthday
      # @option profile_data [String] :gender
      # @option profile_data [String] :email_address
      # @option profile_data [String] :[:address][:street_address]
      # @option profile_data [String] :[:address][:secondary_address]
      # @option profile_data [String] :[:address][:city]
      # @option profile_data [String] :[:address][:state]
      # @option profile_data [String] :[:address][:zip_code]
      # @option profile_data [String] :[:address][:country]
      # @option profile_data [String] :phone_number
      # @param parent_one [Hash]
      # @option parent_one [String] :first_name
      # @option parent_one [String] :last_name
      # @option parent_one [String] :email_address
      # @param parent_two [Hash]
      # @option parent_two [String] :first_name
      # @option parent_two [String] :last_name
      # @option parent_two [String] :email_address
      def self.populate_profile(data={})
        create_profile_page = MemberManagement::Page::CreateProfile.new $browser
        create_profile_page.first_name.set data[:first_name] if data[:first_name]
        create_profile_page.last_name.set data[:last_name] if data[:last_name]

        create_profile_page.date_of_birth_month.select_value data[:birthday].month.to_s if data[:birthday]
        create_profile_page.date_of_birth_day.select_text data[:birthday].day.to_s if data[:birthday]
        create_profile_page.date_of_birth_year.select_text data[:birthday].year.to_s if data[:birthday]
        create_profile_page.gender.select_text data[:gender] if data[:gender]

        create_profile_page.email_address.set data[:email_address] if data[:email_address]

        create_profile_page.street_address.set data[:street_address] if data[:street_address]
        create_profile_page.secondary_address.set data[:secondary_address] if data[:secondary_address]
        create_profile_page.city.set data[:city] if data[:city]
        create_profile_page.state.select_text data[:state] if data[:state]
        create_profile_page.zip_code.set data[:zip] if data[:zip]
        create_profile_page.country.select_text data[:country] if data[:country]

        create_profile_page.phone_number.set data[:phone_number] if data[:phone_number]

        create_profile_page.parent_one_first_name.set data[:parent_one_first_name] if data[:parent_one_first_name]
        create_profile_page.parent_one_last_name.set data[:parent_one_last_name] if data[:parent_one_last_name]
        create_profile_page.parent_one_email.set data[:parent_one_email] if data[:parent_one_email]

        create_profile_page.parent_two_first_name.set data[:parent_two_first_name] if data[:parent_two_first_name]
        create_profile_page.parent_two_last_name.set data[:parent_two_last_name] if data[:parent_two_last_name]
        create_profile_page.parent_two_email.set data[:parent_two_email] if data[:parent_two_email]

        create_profile_page.grade_in_school.select_text data[:grade] if (data[:grade] && create_profile_page.grade_in_school.present?)
        create_profile_page.approximate_weight.set data[:weight] if (data[:weight] && create_profile_page.approximate_weight.present?)
      end

      # Add parent and guardian information to a profile
      # @param data [Hash] The data used to populate the profile
      def self.add_parent_guardian_information_and_save(data={})
        populate_parent_guardian_profile(data)
        save_and_continue
      end

      # The data used to populate the profile
      # @param data [Hash] The data used to populate the profile
      def self.populate_parent_guardian_profile(data={})
        create_profile_page = MemberManagement::Page::CreateProfile.new $browser
        create_profile_page.parent_one_first_name.set data[:parent_one_first_name] if data[:parent_one_first_name]
        create_profile_page.parent_one_last_name.set data[:parent_one_last_name] if data[:parent_one_last_name]
        create_profile_page.parent_one_email.set data[:parent_one_email] if data[:parent_one_email]

        create_profile_page.parent_two_first_name.set data[:parent_two_first_name] if data[:parent_two_first_name]
        create_profile_page.parent_two_last_name.set data[:parent_two_last_name] if data[:parent_two_last_name]
        create_profile_page.parent_two_email.set data[:parent_two_email] if data[:parent_two_email]

        create_profile_page.grade_in_school.select_text data[:grade] if (data[:grade] && create_profile_page.grade_in_school.present?)
        create_profile_page.approximate_weight.set data[:weight] if (data[:weight] && create_profile_page.approximate_weight.present?)

      end
    end
  end
end
