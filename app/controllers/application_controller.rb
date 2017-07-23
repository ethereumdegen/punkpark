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
      redirect_to root_path
    end
    format.any { head 401 }
  end
end

before_action :initSessionState

def initSessionState
  @acct_name_short = "----"

  if session[:current_punk_id]
    @acct_name_short = "Punk"+session[:current_punk_id].to_s
    @current_punk = Punk.find_by_id(session[:current_punk_id])
  elsif session[:current_public_address]
    @acct_name_short = "0x"+session[:current_public_address][0..3]
  end
end

def authentication_required!
  session_signed_in || raise(ApplicationNotAuthenticated)
end

def address_required!
  session_has_public_address || raise(ApplicationNotAuthenticated)
end



def session_punk_signed_in
  session[:current_punk_id] != nil
end

def session_signed_in
  session[:current_punk_id] != nil || session[:guest_id] != nil
end

def get_current_punk_id
  session[:current_punk_id]
end

def session_has_public_address
   session[:current_public_address] != nil
end


end
