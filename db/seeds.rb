require 'faker'

user = User.create(
  first_name: 'Charlie',
  last_name: 'Brown',
  email: 'charlie@peanuts.com',
  password: 'password'
)

10.times do |n|
  Project.create(
    name: Faker::App.name,
    order: n + 1,
    description: Faker::Company.catch_phrase,
    user_id: user.id
  )
end
