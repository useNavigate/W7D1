class ApplicationController < ActionController::Base
  # skip_before_action :verify_authenticity_token

  # helper_method :current_user, :logged_in? #gives us access to these methods in the view files

  def login(user)
    #session = hash // [:session_token] => key
    session[:session_token] = user.reset_session_token!
    # everytime when a user logs in, it generate new token
  end
end
