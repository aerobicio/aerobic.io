require 'ostruct'
require 'faker'

def create_registered_account(name = Faker::Name.name)
  $switch_board.activate_sign_up
  @password = '123456789'
  @name = name
  @email = Faker::Internet.email
  @identity = OpenStruct.new(name: @name, email: @email)

  sign_up(@name, @email)
  $switch_board.deactivate_sign_up
end

def sign_in(password = @password)
  visit sign_in_path
  fill_in(I18n.t('sessions.new.auth_key'), with: @identity.email)
  fill_in :password, with: password

  click_button(I18n.t('sessions.new.submit'))
end

def sign_out
  click_link(I18n.t('sign_out'))
end
