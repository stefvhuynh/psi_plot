# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :two_way_plot do
    title { Faker::Company.catch_phrase }
    independent_variable { Faker::Hacker.noun }
    moderator_variable { Faker::Hacker.noun }
    dependent_variable { Faker::Hacker.noun }
    independent_coefficient { rand }
    moderator_coefficient { rand }
    interaction_coefficient { rand }
    intercept { rand }
    independent_mean { rand }
    independent_sd { rand }
    moderator_mean { rand }
    moderator_sd { rand }
    sequence :order do |n|
      n
    end
    project
  end

  factory :invalid_two_way_plot, parent: :two_way_plot do
    title nil
    independent_name nil
    moderator_name nil
    dependent_name nil
    independent_coefficient nil
    moderator_coefficient nil
    interaction_coefficient nil
    intercept nil
    independent_mean nil
    independent_sd nil
    moderator_mean nil
    moderator_sd nil
    order nil
    project_id nil
  end
end
