class ProvidersController < ApplicationController
  def new
  end

  def create

    provider = params[:provider]


    p ' callback for '
    p provider

    auth_hash = request.env['omniauth.auth']

    render :text => auth_hash.inspect
  end

  def failure
  end
end
