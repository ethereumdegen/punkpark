class ParkController < ApplicationController

  before_action :authentication_required!, except: :home


  def home
  end


end
