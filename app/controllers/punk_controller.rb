class PunkController < ApplicationController
  before_action :authentication_required!, except: [:select_punk, :punk_signin,:auth_into_punk]
  before_action :address_required!, only:[:select_punk]

require 'rlp'
require 'secp256k1'
require 'ethereum'
require 'ethereum/constant'
require 'ethereum/secp256k1'
require 'ethereum/fast_rlp'
require 'ethereum/utils'
require 'ethereum/public_key'
require 'ethereum/base_convert'
require 'ethereum/address'

include Ethereum::FastRLP
include Ethereum::Constant
include Ethereum::Utils
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


    public_key_raw =  Ethereum::Secp256k1.recover_pubkey(challenge_hash, vrs_data , compressed: false)


    public_key_hex =  Ethereum::Utils.encode_hex( public_key_raw )

    public_key = Ethereum::PublicKey.new(  public_key_hex)

    verified_public_address = Ethereum::Utils.encode_hex( public_key.to_address )

     p 'authing in with pub addr '
     p verified_public_address


    crypto_punk_id_at_key = 1

    #login
    session[:current_public_address] = verified_public_address


    #alert[:flash] = "Logged in to your Punk!"
    #redirect_to :root_path

    respond_to do |format|

      #format.html # show.html.erb
      format.json { render json: {success:true, verified_public_address: verified_public_address }  }

     end

  end


  #if the user has an address and no punk id then go here to pick one moetal kombat style
  def select_punk

    @current_public_address = session[:current_public_address]


    client = Ethereum::IpcClient.new("#{ENV['HOME']}/.ethereum/geth.ipc")




  #  init = Ethereum::Initializer.new("app/assets/contracts/CryptoPunksMarket.sol", client)
  #  init.build_all
  #  crypto_punks_market_instance.as("0xb47e3cd837dDF8e4c57F05d70Ab865de6e193BBB")

  #  contract = Ethereum::Contract.create(file: "app/assets/contracts/CryptoPunksMarket.sol", address: "0xb47e3cd837dDF8e4c57F05d70Ab865de6e193BBB ")

  abi = File.read("app/assets/contracts/CryptoPunksMarket.abi")
    contract = Ethereum::Contract.create(client: client, name: "CryptoPunksMarket", address: "0xb47e3cd837dDF8e4c57F05d70Ab865de6e193BBB", abi: abi)

    #contract.call.get("performer") # => "Black Eyed Peas"
    punk_one_address =  contract.call.punk_index_to_address(100)
     p 'address of punk 1 '
    p punk_one_address

    #need to use CALL to get the punks at this address
    @owned_punk_id_array = []



  end


  def login_punk
    #again make sure that the users session public address can access this punk

    #session[:current_user] = true
    session[:current_punk_id] = 1
  end


  def logout_punk
    session[:current_public_address] = nil

    session[:current_punk_id] = nil

    redirect_to root_path
  end

end
