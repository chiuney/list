# frozen_string_literal: true

FactoryBot.define do
  factory :add_shop do
    association :user
    association :shop
  end
end
