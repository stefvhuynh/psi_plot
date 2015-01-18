# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(6) }
  end

  factory :invalid_user, class: 'User' do
    first_name nil
    last_name nil
    email nil
    password nil
  end
end
