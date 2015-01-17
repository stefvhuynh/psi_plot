class TwoWayPlot < ActiveRecord::Base
  belongs_to :project

  validates :title, :independent_variable, :moderator_variable, presence: true
  validates :order, uniqueness: { scope: :project }
end
