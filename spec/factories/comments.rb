FactoryBot.define do
  factory :comment do
    sequence(:content) { |n| "Comment #{n} content" }
    association :user
    association :lesson

    trait :from_teacher do
      association :user, factory: :teacher
    end

    trait :from_student do
      association :user, factory: :student
    end

    factory :teacher_comment, traits: [:from_teacher]
    factory :student_comment, traits: [:from_student]
  end
end 