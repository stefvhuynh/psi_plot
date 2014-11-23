class Project < ActiveRecord::Base

  belongs_to :user

  validates :name, :user_id, presence: true
  validates :description, length: { maximum: 150 }

end
