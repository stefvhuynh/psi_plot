class TwoWayPlot < ActiveRecord::Base
  belongs_to :project

  validates :title, :independent_name, :moderator_name, presence: true
  validates :order, uniqueness: { scope: :project }
end
