FactoryBot.define do
  factory :entry do
    date { Date.today }
    thoughts { Faker::Lorem.sentence(word_count: 20) }
    user 
    journal 
  end

  factory :journal do
    user
    is_private { true }
    title { Faker::Lorem.word }
  end

  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "123456" }
    password_confirmation { "123456" }
  end

  
end