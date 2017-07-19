class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



  ApplicationNotAuthenticated = Class.new(StandardError)

rescue_from ApplicationNotAuthenticated do
  respond_to do |format|
    format.json { render json: { errors: [message: "401 Not Authorized"] }, status: 401 }
    format.html do
      flash[:notice] = "Not Authorized to access this page, plese log in"
      redirect_to new_session_path
    end
    format.any { head 401 }
  end
end

def authentication_required!
  session[:current_user] || raise(ApplicationNotAuthenticated)
end


end
