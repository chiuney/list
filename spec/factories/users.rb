FactoryBot.define do
  factory :user do
    user_name {"tarou"}
    # sequence => 値の重複を避ける
    sequence(:email) { |number| "tarou#{number}@example.com"}
    password {"password"}
    password_confirmation {"password"}
  end
end
