FactoryBot.define do
  factory :notification do
    association :recipient, factory: :user
    association :actor, factory: :user

    association :notifiable, factory: :comment

    read_at { nil }

    trait :read do
      read_at { Time.current }
    end
  end
end
