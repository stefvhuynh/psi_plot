class Project < ActiveRecord::Base
  belongs_to :user
  has_many :project_shares
  has_many :two_way_plots
  has_many :shared_users, through: :project_shares

  validates :name, :order, :user, presence: true
  validates :order, uniqueness: { scope: :user_id }
  validates :description, length: { maximum: 150 }

  def all_plots
    two_way_plots.order(:order)
  end
end
