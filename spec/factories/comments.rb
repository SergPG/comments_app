FactoryBot.define do
  factory :comment do
    body { "Hello world" }
    association :user
  end
end
