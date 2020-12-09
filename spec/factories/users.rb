FactoryBot.define do
  factory :user do
    user_name {"tarou"}
    # sequence => 値の重複を避ける
    sequence(:email) { |number| "tarou#{number}@example.com"}
    password {"password"}
    password_confirmation {"password"}

    trait :invalid do
      user_name {nil}
    end
  end

  factory :jirou, class: User do
    user_name {"jirou"}
    email {"jirou@example.com"}
    password {"password"}
    password_confirmation {"password"}
  end

  factory :saburou, class: User do
    user_name {"saburou"}
    email {"saburou@example.com"}
    password {"password"}
    password_confirmation {"password"}
  end
end
