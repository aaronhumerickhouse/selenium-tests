require_relative '../user_service_base_page'

module UserService
  module Page
    class SignIn < UserService::Page::BasePage
      page_url /https:\/\/user.stage.ngin-staging.com/
      title 'Sport Ngin'
      expected_element 'input', {id: 'user_login'}

      text_field(:username, id: 'user_login')
      text_field(:password, id: 'user_password')
      input(:sign_in, css: 'div.form-actions > input')
      #input(:sign_in, css: 'form footer input')
    end
  end
end
