def create_registered_account
  @password = 123456789
  @identity = FactoryGirl.create(:identity,
                                 password: @password,
                                 password_confirmation: @password)
  @name = @identity.name
end

def login(password = @password)
  visit sign_in_path
  fill_in(I18n.t("sessions.new.auth_key"), with: @identity.email)
  fill_in :password, with: password

  click_button(I18n.t("sessions.new.submit"))
end
