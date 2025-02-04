FactoryBot.define do
  factory :lesson do
    title { Faker::Music.album }
    content { Faker::Lorem.paragraphs(number: 3).join("\n\n") }
    association :teacher, factory: :teacher

    trait :assigned do
      association :assigned_to, factory: :student
    end

    factory :assigned_lesson, traits: [:assigned]
  end
end 