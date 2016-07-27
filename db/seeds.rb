User.destroy_all
Wiki.destroy_all

5.times do
  User.create!(
  email:    Faker::Internet.email,
  password: "password"
  )
end

users = User.all

50.times do
  Wiki.create!(
    user:   users.sample,
    title:  Faker::Hipster.sentence,
    body:   Faker::Hipster.paragraph
  )
end
