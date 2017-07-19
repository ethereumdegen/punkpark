class ParkController < ApplicationController

  before_action :authentication_required!, except:[:root,:home]



  def root
    if session_signed_in
      render 'home'
    else
      render 'landing'
    end
  end

  def landing

  end


  def home


  end


end
