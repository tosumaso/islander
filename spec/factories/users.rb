FactoryBot.define do
  factory :user do
    name          {"test"}
    email         {"sample@gmail.com"}
    password      {"sample777"}
    password_confirmation {password}
  end
end