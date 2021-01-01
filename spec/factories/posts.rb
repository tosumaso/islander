FactoryBot.define do
  factory :post do
    content         {"test content"}
    evaluation_id   {2}
    association :user
    association :map
  end
end
