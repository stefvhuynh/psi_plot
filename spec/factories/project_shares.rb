# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project_share do
    project
    user
  end

  factory :invalid_project_share, parent: :project_share do
    project_id nil
    user_id nil
  end
end
