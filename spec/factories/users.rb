FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:name) { |n| "User #{n}" }
    password { 'password123' }
    role { :student }

    trait :teacher do
      role { :teacher }
    end

    trait :student do
      role { :student }
    end

    factory :teacher, traits: [:teacher]
    factory :student, traits: [:student]
  end
end 