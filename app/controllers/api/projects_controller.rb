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

end
