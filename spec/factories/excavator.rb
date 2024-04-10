# frozen_string_literal: true

FactoryBot.define do
  factory :excavator do
    company_name { Faker::Company.name }
    crew_on_site { Faker::Name.name }
    address { Faker::Address.full_address }
    ticket
  end
end
