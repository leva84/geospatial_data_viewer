# frozen_string_literal: true

FactoryBot.define do
  factory :ticket do
    sequence(:request_number) { |n| "RN#{n}" }
    sequence(:sequence_number) { |n| "SN#{n}" }
    request_type { Faker::Lorem.word }
    request_action { Faker::Lorem.word }
    response_due_date_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    primary_service_area_code { Faker::Alphanumeric.alphanumeric(number: 7) }
    additional_service_area_codes { [Faker::Alphanumeric.alphanumeric(number: 7)] }
    well_known_text { File.read("#{ Rails.root }/spec/data/well_known_text_data.txt").chomp }
    excavator { association :excavator, ticket: instance }
  end
end
