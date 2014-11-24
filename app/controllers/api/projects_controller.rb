class Api::ProjectsController < ApplicationController
  before_filter :require_signed_in

  def index
    @projects = current_user.projects
    render :index, status: :ok
  end

end
