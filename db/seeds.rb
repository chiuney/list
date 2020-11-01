# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

100.times do |n|
  name = Faker::Movies::HarryPotter.character
  email = Faker::Internet.email
  password = "password"
  User.create!(user_name: name,
               email: email,
               password: password,
               password_confirmation: password,
               )
end

User.all.each do |user|
  list_name = Faker::Color.color_name
  list_comment = Faker::Color.hex_color
  user.lists.create!(list_name: list_name,
                     list_comment: list_comment,
                    )
end

100.times do |shop|
  shop_name = Faker::Restaurant.name
  Shop.create!(shop_name: shop_name,
               )
end