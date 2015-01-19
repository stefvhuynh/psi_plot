class TwoWayPlot < ActiveRecord::Base
  belongs_to :project

  validates :title, :independent_variable, :moderator_variable,
    :dependent_variable, :independent_coefficient, :moderator_coefficient,
    :interaction_coefficient, :intercept, :independent_mean, :independent_sd,
    :moderator_mean, :moderator_sd, :order, :project, presence: true
  validates :order, uniqueness: { scope: :project }
end
