require_relative '../member_management_base_page'

module MemberManagement
  module Page
    # Page Object for the Background Check page in Member Management
    class BackgroundScreen < MemberManagement::Page::BasePage

      link(:reload_data, css: 'aside a.button', index: 0)
      link(:add_background_screen, css: 'aside a.button', index: 1)

      # Form
      text_field(:first_name, id: 'first_name')
      text_field(:last_name, id: 'last_name')
      text_field(:membership_number, id: 'membership_number')
      stylized_select(:status, xpath: "//select[@id='status']")
      unstylized_select(:completed_after_year, xpath: "//select[@id='completed_after_year']")
      unstylized_select(:completed_after_month, xpath: "//select[@id='completed_after_month']")
      unstylized_select(:completed_after_day, xpath: "//select[@id='completed_after_day']")
      unstylized_select(:completed_before_year, xpath: "//select[@id='completed_before_year']")
      unstylized_select(:completed_before_month, xpath: "//select[@id='completed_before_month']")
      unstylized_select(:completed_before_day, xpath: "//select[@id='completed_before_day']")
      text_field(:notes, id: 'response')
      button(:search, css: 'input.save')
      trs(:rows, css: 'table.mm-table tbody tr')


      # Table

      # Retreives a row with a specific name
      # @param name [String] The name of the row to get
      # @return [Watir::TableRow] The html element of the row
      def get_row_with_name(name)
        rows.each do |row|
          return row if row.tds[0].a.text == name
        end
        raise StandardError.new "Row with the name #{name} was not found."
      end


    end
  end
end
