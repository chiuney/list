FactoryBot.define do
  factory :list do
    list_name {"list_name"}

    association :user
  end
end
