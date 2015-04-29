require 'faker'

#Module for Faker Data
module FakerData

  #Array of Grades
  GRADES = %w(Pre-Kindergarten Kindergarten 1st\ Grade 2nd\ Grade 3rd\ Grade 4th\ Grade 5th\ Grade 6th\ Grade 7th\ Grade 8th\ Grade H.S.\ Freshman H.S.\ Sophomore H.S.\ Junior H.S.\ Senior College\ Red\ Shirt\ Freshman College\ Freshman College\ Sophomore College\ Junior College\ Senior Not\ Applicable)

  # Returns a hash of a faker person with address
  # @param opts [Hash] Make sure has specific data
  # @option opts [String] :city
  # @option opts [String] :zip_code
  # @option opts [String] :zip
  # @option opts [String] :postcode
  # @option opts [String] :state_abbr
  # @option opts [String] :state
  # @option opts [String] :country
  # @option opts [Boolean] :adult
  #
  # @return [String] :first_name
  # @return [String] :last_name
  # @return [String] :prefix
  # @return [String] :suffix
  # @return [String] :title
  # @return [String] :email
  # @return [String] :username
  # @return [String] :password
  # @return [String] :phone_number
  # @return [String] :cell_phone
  # @return [Hash] :address
  # @return [Integer] :grade
  # @return [Integer] :weight
  def person(opts = {adult: false})
    person = {}
    person[:first_name] = Faker::Name.first_name
    person[:last_name] = Faker::Name.last_name
    person[:full_name] = "#{person[:first_name]} #{person[:last_name]}"
    person[:gender] = rand(2) == 1 ? 'Male' : 'Female'
    person[:prefix] = Faker::Name.prefix
    person[:suffix] = Faker::Name.suffix
    person[:title] = Faker::Name.title
    person[:email_address] = Faker::Internet.safe_email
    person[:username] = Faker::Internet.user_name
    person[:password] = Faker::Internet.password
    person[:phone_number] = Faker::PhoneNumber.phone_number
    person[:cell_phone] = Faker::PhoneNumber.cell_phone
    person[:address] = address(opts.except(:adult))
    person[:birthday] = opts[:adult] ? date_between_dates(Date.today.prev_year(50), Date.today.prev_year(19)) : date_between_dates(Date.today.prev_year(17), Date.today.prev_year(13))
    person[:grade] = opts[:adult] ? GRADES[rand(6) + 13] : GRADES[rand(14) - 1]
    person[:weight] = rand(190) + 40
    person
  end

  #Returns a hash of an address
  # @param opts [Hash] Make sure has specific data
  # @option opts [String] :city
  # @option opts [String] :zip_code
  # @option opts [String] :zip
  # @option opts [String] :postcode
  # @option opts [String] :state_abbr
  # @option opts [String] :state
  # @option opts [String] :country
  #
  # @return [String] :city
  # @return [String] :street_name
  # @return [String] :street_address
  # @return [String] :secondary_address
  # @return [String] :building_number
  # @return [String] :zip_code
  # @return [String] :zip
  # @return [String] :postcode
  # @return [String] :time_zone
  # @return [String] :street_suffix
  # @return [String] :city_suffix
  # @return [String] :city_prefix
  # @return [String] :state_abbr
  # @return [String] :state
  # @return [String] :country
  # @return [String] :latitude
  # @return [String] :longitude
  def address(opts = {})
    address = {}

    address[:city] = opts[:city] if opts[:city]
    address[:state] = opts[:state] if opts[:state]
    address[:state_abbr] = opts[:state_abbr] if opts[:state_abbr]
    address[:zip_code] = opts[:zip_code] if opts[:zip_code]
    address[:zip] = opts[:zip] if opts[:zip]
    address[:postcode] = opts[:postcode] if opts[:postcode]
    address[:country] = opts[:country] if opts[:country]


    address[:city] = Faker::Address.city unless opts[:city]
    address[:street_name] = Faker::Address.street_name
    address[:street_address] = Faker::Address.street_address
    address[:secondary_address] = Faker::Address.secondary_address
    address[:building_number] = Faker::Address.building_number
    address[:zip_code] = Faker::Address.zip_code unless opts[:zip_code]
    address[:zip] = Faker::Address.zip unless opts[:zip]
    address[:postcode] = Faker::Address.postcode unless opts[:postcode]

    address[:time_zone] = Faker::Address.time_zone
    address[:street_suffix] = Faker::Address.street_suffix
    address[:city_suffix] = Faker::Address.city_suffix
    address[:city_prefix] = Faker::Address.city_prefix
    address[:state_abbr] = Faker::Address.state_abbr unless opts[:state_abbr]
    address[:state] = Faker::Address.state unless opts[:state]
    address[:country] = Faker::Address.country unless opts[:country]
    address[:latitude] = Faker::Address.latitude
    address[:longitude] = Faker::Address.longitude
    address
  end

  # Returns a random date in the future.  The max given by the amount of days
  # @param days [Integer] The limit in future days
  # @return [Date] A random date
  def future_date(days)
    Faker::Date.forward(days)
  end

  # Returns a random date in the past.  The max given by the amount of days
  # @param days [Integer] The limit in past days
  # @return [Date] A random date
  def past_date(days)
    Faker::Date.backward(days)
  end

  # Returns a random date between two dates.
  # @param first [Date] The earliest desired date
  # @param last [Date] The latest desired date
  # @return [Date] A random date
  def date_between_dates(first, last)
    Faker::Date.between(first, last)
  end

  # Creates a hash for profile data
  # @param profile_data [Hash]
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
  # @return [String] :first_name
  # @return [String] :last_name
  # @return [Date] :birthday
  # @return [String] :gender
  # @return [String] :email_address
  # @return [String] :street_address
  # @return [String] :secondary_address
  # @return [String] :city
  # @return [String] :state
  # @return [String] :zip
  # @return [String] :country
  # @return [String] :phone_number
  # @return [String] :parent_one_first_name
  # @return [String] :parent_one_last_name
  # @return [String] :parent_one_email
  # @return [String] :parent_two_first_name
  # @return [String] :parent_two_last_name
  # @return [String] :parent_two_email
  # @return [Integer] :grade
  # @return [Integer] :weight
  def get_profile_data(profile_data, parent_one={}, parent_two={})
    {
        :first_name => profile_data[:first_name],
        :last_name => profile_data[:last_name],
        :birthday => profile_data[:birthday],
        :gender => profile_data[:gender],
        :email_address => profile_data[:email_address],

        :street_address => profile_data[:address][:street_address],
        :secondary_address => profile_data[:address][:secondary_address] ? profile_data[:address][:secondary_address] : nil,
        :city => profile_data[:address][:city],
        :state => profile_data[:address][:state],
        :zip => profile_data[:address][:zip_code],
        :country => profile_data[:address][:country],
        :phone_number => profile_data[:phone_number],

        :parent_one_first_name => !parent_one.empty? ? parent_one[:first_name] : nil,
        :parent_one_last_name => !parent_one.empty? ? parent_one[:last_name] : nil,
        :parent_one_email => !parent_one.empty? ? parent_one[:email_address] : nil,

        :parent_two_first_name => !parent_two.empty? ? parent_two[:first_name] : nil,
        :parent_two_last_name => !parent_two.empty? ? parent_two[:last_name] : nil,
        :parent_two_email => !parent_two.empty? ? parent_two[:email_address] : nil,

        :grade => profile_data[:grade],
        :weight => profile_data[:weight]
    }
  end

  # Creates a hash of billing information
  # @param data [Hash] Billing information
  # @option data [String] :first_name
  # @option data [String] :last_name
  # @option data [String] :email_address
  # @option data [String] [:address][:street_address]
  # @option data [String] [:address][:secondary_address]
  # @option data [String] [:address][:city]
  # @option data [String] [:address][:state]
  # @option data [String] [:address][:zip_code]
  # @option data [String] [:address][:phone_number]
  # @option data [String] :[:address][:country]
  # @option data [String] :phone_number
  # @return [String] :first_name
  # @return [String] :last_name
  # @return [String] :email_address
  # @return [String] :street_address
  # @return [String] :secondary_address
  # @return [String] :city
  # @return [String] :state
  # @return [String] :zip
  # @return [String] :country
  # @return [String] :phone_number
  def get_billing_information(data)
    {
        :first_name => data[:first_name],
        :last_name => data[:last_name],
        :email_address => data[:email_address],

        :street_address => data[:address][:street_address],
        :secondary_address => data[:address][:secondary_address],
        :city => data[:address][:city],
        :state => data[:address][:state],
        :zip => data[:address][:zip_code],
        :country => data[:address][:country],
        :phone_number => data[:phone_number]
    }
  end

  # Creates a credit information hash
  # @param member [Hash]
  #  @option member [String] :first_name
  #  @option member [String] :last_name
  # @param credit_number [String] The credit card number
  # @param expiration_month [String] The month for expiration, eg 'January'
  # @param expiration_year [String] The year for expiration, eg '2050'
  # @param cvv [String] the cvv, eg '123'
  # @return [String] :first_name
  # @return [String] :last_name
  # @return [String] :credit_card_number
  # @return [String] :expiration_month
  # @return [String] :expiration_year
  # @return [String] :cvv_code
  def get_credit_information(member, credit_number, expiration_month, expiration_year, cvv)
    {
        :first_name => member[:first_name],
        :last_name => member[:last_name],
        :credit_card_number => credit_number,
        :expiration_month => expiration_month,
        :expiration_year => expiration_year,
        :cvv_code => cvv
    }
  end
end
