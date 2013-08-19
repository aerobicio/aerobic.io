require 'spec_helper'

describe Identity do
  subject { Identity.create(name: "Gareth Townsend",
                            email: "gareth.townsend@me.com",
                            password: "password",
                            password_confirmation: "password") }

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }

  it { should allow_value("spam+something@gmail.com").for(:email) }
  it { should_not allow_value("blah").for(:email) }
end
