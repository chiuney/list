# frozen_string_literal: true

FactoryBot.define do
  factory :list do
    list_name { 'list_name' }
    association :user

    trait :invalid do
      list_name { nil }
    end
  end

  factory :pre_list, class: List do
    list_name { 'pre_list' }
    association :user
  end

  factory :updated_list, class: List do
    list_name { 'updated_list' }
    association :user
  end
end
