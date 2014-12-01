class Api::ProjectSharesController < ApplicationController
  before_filter :require_signed_in

  def create
    if Project.exists?(id: params[:project_id], user_id: current_user.id)
      @project_share = ProjectShare.new(project_share_params)

      if @project_share.save
        render :show, status: :ok
      else
        render nothing: true, status: :unprocessable_entity
      end
    else
      render nothing: true, status: :not_found
    end
  end

  def destroy
    render :show, status: :ok
  end

  private

  def project_share_params
    params.require(:project_share).permit(:project_id, :user_id)
  end
end