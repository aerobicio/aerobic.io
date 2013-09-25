def create_registered_account
  $switch_board.activate_sign_up
  @password = 123456789
  @identity = FactoryGirl.build(:identity,
                                 password: @password,
                                 password_confirmation: @password)
  @name = @identity.name
  sign_up(@name, @identity.email)
  $switch_board.deactivate_sign_up
end

def register_another_member
  sign_out
  @original_identity = @identity
  create_registered_account
  sign_in
end

def sign_in(password = @password)
  visit sign_in_path
  fill_in(I18n.t("sessions.new.auth_key"), with: @identity.email)
  fill_in :password, with: password

  click_button(I18n.t("sessions.new.submit"))
end

def sign_out
  click_link(I18n.t("sign_out"))
end
