module AuthenticationHelpers
  def sign_in(user)
    request.session[:token] = user.session_token
  end

  def sign_out
    request.session[:token] = nil
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelpers
end
