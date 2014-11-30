class ProjectShare < ActiveRecord::Base

  belongs_to :project
  belongs_to :user

  validates :project, :user, presence: true
  validates :project, uniqueness: { scope: :user }

end
