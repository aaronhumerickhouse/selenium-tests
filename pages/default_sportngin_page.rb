require 'page-object'

class DefaultSportNginPage
  include PageObject
  span(:sign_out, css: 'span.nb-sign-out')
end
