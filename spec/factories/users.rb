FactoryBot.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email
    password { 'a' * 8 }
  end

  factory :admin, parent: :user do
    role { 'admin' }
  end
end
