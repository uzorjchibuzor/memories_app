FactoryBot.define do
  factory :journal do
    user
    is_private { true }
    title { Faker::Lorem.word }
  end

  factory :user do
    name { Faker::Name.name }
  end

  
end