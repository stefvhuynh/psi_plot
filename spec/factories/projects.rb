# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name { Faker::App.name }
    description { Faker::Company.catch_phrase }
    user
    sequence :order do |n|
      n
    end
  end

  factory :invalid_project, class: 'Project' do
    name nil
    description nil
    user_id nil
    order nil
  end
end
