class PunkController < ApplicationController
  before_action :authentication_required!, except: [:test_signin]


  def index

    #test


  end

  def show
  end

  def test_signin

        session[:current_user] = true
        session[:current_punk_id] = 1
  end


  def login_to_punk

    #login
    session[:current_user] = true
    session[:current_punk_id] = 1

  end
end
