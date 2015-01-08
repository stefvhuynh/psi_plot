class Api::ProjectsController < ApplicationController
  before_filter :require_signed_in

  def index
    @projects = current_user.projects
    render :index, status: :ok
  end

  def show
    @project = Project.find_by(id: params[:id], user_id: current_user.id)

    if @project
      render :show, status: :ok
    else
      render nothing: true, status: :forbidden
    end
  end

  def create
    @project = current_user.projects.build(project_params)

    if @project.save
      render :show, status: :ok
    else
      render json: { errors: @project.errors.full_messages },
        status: :unprocessable_entity
    end
  end

  def update
    @project = Project.find_by(id: params[:id], user_id: current_user.id)

    if @project
      if @project.update(project_params)
        render :show, status: :ok
      else
        render nothing: true, status: :unprocessable_entity
      end
    else
      render nothing: true, status: :not_found
    end
  end

  def destroy
    @project = Project.find_by(id: params[:id], user_id: current_user.id)

    if @project
      if @project.destroy
        render :show, status: :ok
      else
        render nothing: true, status: :unprocessable_entity
      end
    else
      render nothing: true, status: :not_found
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :order, :description)
  end
end
