class PagesController < ApplicationController

  def main
    @user = current_user
    render :main
  end

end
