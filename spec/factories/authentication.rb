FactoryGirl.define do
  factory :authentication do
    provider "identity"
    uid "12345678"

    user
  end
end
