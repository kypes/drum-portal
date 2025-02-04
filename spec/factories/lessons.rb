FactoryBot.define do
  factory :lesson do
    sequence(:title) { |n| "Lesson #{n}" }
    content { "# Lesson Content\n\nThis is a sample lesson content with markdown." }
    youtube_url { "https://www.youtube.com/watch?v=example" }
    association :teacher, factory: [:user, :teacher]
    association :assigned_to, factory: [:user, :student]

    trait :assigned do
      association :assigned_to, factory: :student
    end

    factory :assigned_lesson, traits: [:assigned]
  end
end 