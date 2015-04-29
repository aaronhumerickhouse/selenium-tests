module MemberManagement
  #Module to hold verification functions to reuse in tests.
    module Verification
      #Module to hold verification functions specific to the dashboard page.
        module Dashboard

          def verify_new_profile(index, data={})
            #TODO
            dashboard_page = MemberManagement::Page::Dashboard.new $browser
            profile = dashboard_page.all_profiles[index]
            profile.get_memberships
            # @soft_asserts.verify { expect(profile.name).to eq data[:name] } if data[:name]
            # @soft_asserts.verify { expect(profile.gender).to eq data[:gender] } if data[:gender]
            # @soft_asserts.verify { expect(profile.age).to eq data[:age] } if data[:age]
          end

          # Verifies a user has the correct membership
          # @param data [Hash] Data to verify
          # @option data [String] :full_name
          # @option data [String] :type
          # @option data [String] :level
          # @option data [String] :expiration_date
          # @option data [Boolean] :upgrade
          def verify_new_membership(data={})
            #find user profile
            profile = MemberManagement::Helper::Dashboard.find_profile(data[:full_name])

            #find membership
            membership = profile.get_membership data[:type]

            #verify data
            @soft_asserts.verify { expect(membership.type).to eq data[:type] } if data[:type]
            @soft_asserts.verify { expect(membership.level).to eq data[:level] } if data[:level]
            @soft_asserts.verify { expect(membership.expiration_date).to eq data[:expiration_date] } if data[:expiration_date]
            @soft_asserts.verify { expect(membership.is_upgrade_present?).to eq data[:upgrade] } if data[:upgrade]
          end
        end
    end
end
