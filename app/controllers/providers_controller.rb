class ProvidersController < ApplicationController
  def new
  end

  def create

    provider = params[:provider]



      auth_hash = request.env['omniauth.auth']

  #  render :text => auth_hash.inspect

     provider: auth_hash['provider'], uid: auth_hash['uid']

     nickname = auth_hash['info']['nickname']
     name = auth_hash['info']['name']
     email = auth_hash['info']['email']
     #image_url = auth_hash['info']['image']
     token = auth_hash['credentials']['token']



    redirect_to '/punk_editor/auth'
  end

  def failure
  end
end
