class Api::SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(
      params[:session][:email],
      params[:session][:password]
    )

    if @user
      sign_in!(@user)
      render :show
    else
      render json: { errors: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def destroy
    sign_out!
    render nothing: true, status: :ok
  end

end