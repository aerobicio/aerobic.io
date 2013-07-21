require 'spec_helper'

describe Identity do
  subject { Identity.create(name: "Gareth Townsend",
                            email: "gareth.townsend@me.com",
                            password: "password",
                            password_confirmation: "password") }

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should ensure_inclusion_of(:email).in_array(Identity::WHITE_LIST) }

  # These tests are marked as pending becuase the white list negates them.
  #
  # When we remove the white listed email requirement we should re-instante
  # these specs.
  it "should allow 'spam+something@gmail.com' for email" do
    pending "The removal of the white listed email requirement"
  end
  it { should_not allow_value("blah").for(:email) }
end
