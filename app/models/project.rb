class Project < ActiveRecord::Base

  belongs_to :user

  validates :name, :order, :user_id, presence: true
  validates :order, uniqueness: { scope: :user_id }
  validates :description, length: { maximum: 150 }

end
