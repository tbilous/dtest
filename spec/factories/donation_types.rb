FactoryBot.define do
  factory :donation_type do
    name { Faker::Name.first_name }
  end
end
