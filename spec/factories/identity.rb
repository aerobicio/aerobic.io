require 'faker'

FactoryGirl.define do
  factory :identity do
    name Faker::Name.name
    email Faker::Internet.email
  end
end
