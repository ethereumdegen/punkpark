class ParkController < ApplicationController

  before_action :authentication_required!, except:[:root,:landing]
 
  def root
    p ' hellooooo'

    p session_signed_in
      p session_signed_in


    if session_has_public_address

        if session_signed_in
          render 'home'
        else
          redirect_to select_punk_path
        end

    else
        render 'landing'

    end


  end

  def landing

  end


  def home


  end


end
