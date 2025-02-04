FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password123' }
    password_confirmation { 'password123' }
    points { 0 }

    trait :teacher do
      role { 'teacher' }
    end

    trait :student do
      role { 'student' }
    end

    factory :teacher, traits: [:teacher]
    factory :student, traits: [:student]
  end
end 