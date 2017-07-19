class PunkController < ApplicationController
  before_action :authentication_required!, except: [:test_signin,:auth_into_punk]

require 'secp256k1'
require 'ethereum'
require 'ethereum/utils'

include Ethereum::Secp256k1


#http://www.rubydoc.info/gems/ruby-ethereum/0.9.1/Ethereum/Utils#decode_hex-instance_method

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
    web3_signature_v = params[:signature_v].to_i(16)
    web3_signature_r = params[:signature_r].to_i(16)
    web3_signature_s = params[:signature_s].to_i(16)


    challenge_hash = Ethereum::Utils.decode_hex(params[:challenge] )

    vrs_data = [web3_signature_v,web3_signature_r,web3_signature_s]

    p 'authing into punk'
     p web3_signature

      p challenge_hash
        p vrs_data


        #challenge_hash_bytes =  Utils.int_array_to_bytes


        #https://github.com/cryptape/ruby-ethereum/blob/master/lib/ethereum/special_contract.rb
        #Object {v: 27, r: "0587430e40c767d95f802a39212d0d0565a42b9c3ea7fb8e228f955704aaa12b", s: "60ebe58b8623f0a0824962c5c242a60e9be3e904e39c64be0e0b334b8ec26728"}

    public_key_raw =  Ethereum::Secp256k1.recover_pubkey(challenge_hash, vrs_data , compressed: false)
    p ' raw '
      p public_key_raw

      public_key_hex =  Ethereum::Utils.encode_hex( public_key_raw )

    public_key = Ethereum::PublicKey.new(  public_key_hex)

    verified_public_address = Ethereum::Utils.encode_hex( public_key.to_address )

   p 'authing in with pub addr '
   p verified_public_address



    crypto_punk_id_at_key = 1

    #login
    session[:current_public_address] = verified_public_address
    session[:current_user] = true
    session[:current_punk_id] = 1

    #alert[:flash] = "Logged in to your Punk!"
    #redirect_to :root_path

    respond_to do |format|

      #format.html # show.html.erb
      format.json { render json: {success:true, verified_public_address: verified_public_address }  }

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
