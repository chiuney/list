# frozen_string_literal: true

FactoryBot.define do
  factory :list_shop do
    association :list
    association :shop
  end
end
