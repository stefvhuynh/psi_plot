class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  helper_method :current_user, :signed_in?
  after_filter :set_csrf_token

  def sign_in!(user)
    session[:token] = user.reset_session_token!
    @current_user = user
  end

  def sign_out!
    current_user.reset_session_token!
    @current_user = nil
    session[:token] = nil
  end

  def signed_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:token])
  end

  private

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

  def set_csrf_token
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def require_signed_in
    render nothing: true, status: :unauthorized unless signed_in?
  end
end
