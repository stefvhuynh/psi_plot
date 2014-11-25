# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name { Faker::App.name }
    description { Faker::Company.catch_phrase }
    user_id 1
    sequence :order do |n|
      n
    end
  end

  factory :invalid_project, parent: :project do
    name nil
    description nil
    user_id nil
    order nil
  end
end
