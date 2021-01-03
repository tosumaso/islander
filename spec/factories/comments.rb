FactoryBot.define do
  factory :comment do
    content { "test content" }
    association :user
    association :map
  end
end