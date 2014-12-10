class Api::ProjectSharesController < ApplicationController
  before_filter :require_signed_in

  def create
    project_id = params[:project_share][:project_id]

    if Project.exists?(id: project_id, user_id: current_user.id)
      @project_share = ProjectShare.new(project_share_params)

      if @project_share.save
        render :show, status: :ok
      else
        render json: { errors: @project_share.errors.full_messages },
          status: :unprocessable_entity
      end
    else
      render nothing: true, status: :not_found
    end
  end

  def destroy
    @project_share = ProjectShare.find(params[:id])

    if @project_share.project.user_id == current_user.id
      if @project_share.destroy
        render :show, status: :ok
      else
        render json: { errors: @project_share.errors.full_messages },
          status: :unprocessable_entity
      end
    else
      render nothing: true, status: :forbidden
    end
  end

  private

  def project_share_params
    params.require(:project_share).permit(:project_id, :user_id)
  end

end
