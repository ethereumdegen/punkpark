class PunkController < ApplicationController
  before_action :authentication_required!, except: [:test_signin]

require 'secp256k1'
require 'ethereum'

include Ethereum::Secp256k1
#include Ethereum::Utils


  def index

    #test


  end

  def show
  end

  def test_signin

        session[:current_user] = true
        session[:current_punk_id] = 1
  end


  def auth_into_punk

    web3_signature = params[:signature]

    challenge_hash = params[:challenge]

    p 'authing into punk'
     p web3_signature


  #  public_key_raw =  Secp256k1.recover_pubkey(challenge_hash, signatureToVRS(web3_signature) , compressed: false)

  #  public_key = PublicKey.new(raw: public_key_raw)

  #  public_address = public_key.to_address

  #  p 'authing in with pub addr '
  #  p public_address

  # ASSUME THAT THIS ALL WORKED 

    crypto_punk_id_at_key = 1

    #login
    session[:current_user] = true
    session[:current_punk_id] = 1

    #alert[:flash] = "Logged in to your Punk!"
    #redirect_to :root_path

    respond_to do |format|

      #format.html # show.html.erb
      format.json { render json: "successfully authed login" }

     end

  end


  def signatureToVRS(signature)

    p 'siggy is '
    p signature

    signature_array = []
    sting_array = signature.each_char.map(&:to_s)
    string_array.split(',').each do |char|
      signature_array << char
    end

    # signature_ints = [0] * 64

    v = signature_array[1]
    r = Ethereum::Utils.big_endian_to_int signature_array[0][0,32]
    s = Ethereum::Utils.big_endian_to_int signature_array[0][32,32]

    return [v,r,s]
  end

end
