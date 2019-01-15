# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

User.create!(fullname:  "Kowa Jia Liang",
             username: "kowa1229",
             email: "jlkowa1229@gmail.com",
             password:              "123123",
             password_confirmation: "123123")

99.times do |n|
  fullname  = Faker::Name.name
  username  = "example-#{n+1}"
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(fullname:  fullname,
               username: username,
               email: email,
               password:              password,
               password_confirmation: password)
end