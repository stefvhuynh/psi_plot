class Api::TwoWayPlotsController < ApplicationController
  before_filter :require_signed_in

  def create
    project_id = params[:two_way_plot][:project_id]

    if Project.exists?(id: project_id, user_id: current_user.id)
      @two_way_plot = TwoWayPlot.new(two_way_plot_params)

      if @two_way_plot.save
        render :show, status: :ok
      else
        render json: { errors: @two_way_plot.errors.full_messages },
          status: :unprocessable_entity
      end
    else
      render nothing: true, status: :not_found
    end
  end

  private

  def two_way_plot_params
    params.require(:two_way_plot).permit(
      :title,
      :independent_variable,
      :moderator_variable,
      :dependent_variable,
      :independent_coefficient,
      :moderator_coefficient,
      :interaction_coefficient,
      :intercept,
      :independent_mean,
      :independent_sd,
      :moderator_mean,
      :moderator_sd,
      :order,
      :project_id
    )
  end
end
