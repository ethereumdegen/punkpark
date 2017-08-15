
window.$ = window.jQuery = global.$ = require('jquery');
var ethUtil =  require('ethereumjs-util');
var CryptoJS = require('crypto-js')


window.addEventListener('load', function() {
  console.log('loading');


  if (typeof web3 == 'undefined') {

    console.log('No web3? You should consider trying MetaMask!')
    // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
    window.web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));



   $("eth-sign-button").hide();
    $(".get-metamask").show();

  } else {


     $("eth-sign-button").show();
      $(".get-metamask").hide();

    window.web3 = new Web3(web3.currentProvider);

    console.log('got eth ')

         var personal = web3.personal;

           console.log(personal)


          jQuery(".eth-sign-button").on('click', function(event) {
            event.preventDefault();
            console.log('trying to sign')

            var text = "Please sign in to Punk Park"


            var msg = ethUtil.bufferToHex(new Buffer(text, 'utf8'));
          //   var msg = '0x1' // hexEncode(text)
            console.log(msg)
            var from = web3.eth.accounts[0];

            var msg_hash = ethUtil.hashPersonalMessage( new Buffer(text, 'utf8') );


          if(typeof from == "undefined")
          {
            alert("Please log in to Metamask")
          }else
          {
            web3.personal.sign(msg, from, function (err, result) {
             if (err) return console.error(err)
             console.log('PERSONAL SIGNED:' + result)


              checkLoginSignature(result,msg_hash)
           });
          }


           //send the expected public key, challenge, and signature to the server via Ajax to sign in

        });



        $("#good_file_input").change(
            function () {
                var reader = new FileReader();



                reader.onloadend = function(evt) {
                    if (evt.target.readyState == FileReader.DONE) { // DONE == 2

                      var wordArray = CryptoJS.lib.WordArray.create(evt.target.result);
                      var uniqueHash = CryptoJS.SHA256(wordArray);


                          setInputFileUniqueHash( uniqueHash.toString() );
                    }
                  };


                  reader.readAsArrayBuffer(this.files[0]);



            }
        );


        $(".new-goods-submit-button").on('click',function(){
          console.log('submitting goood');

          //get hash of the good
          var file_hash = "";



          //execute smart contract func

          var from = web3.eth.accounts[0];
          //web3 call


            let parsed_abi = parseEtherGoodsABI();

            console.log('parsed_abi');
            console.log(parsed_abi);
        })




}

});


function setInputFileUniqueHash(uniqueHash)
{
  $('.unique-hash-preview').html(uniqueHash);
  console.log(uniqueHash)
}


function parseEtherGoodsABI()
{

  return JSON.parse('[ { "constant": false, "inputs": [ { "name": "uniqueHash", "type": "bytes32" }, { "name": "supplyIndex", "type": "uint256" }, { "name": "minSalePriceInWei", "type": "uint256" }, { "name": "toAddress", "type": "address" } ], "name": "offerSupplyForSaleToAddress", "outputs": [], "payable": false, "type": "function" }, { "constant": false, "inputs": [ { "name": "claimPrice", "type": "uint256" }, { "name": "uniqueHash", "type": "bytes32" } ], "name": "setClaimsPrice", "outputs": [], "payable": false, "type": "function" }, { "constant": true, "inputs": [], "name": "name", "outputs": [ { "name": "", "type": "string" } ], "payable": false, "type": "function" }, { "constant": false, "inputs": [ { "name": "uniqueHash", "type": "bytes32" }, { "name": "supplyIndex", "type": "uint256" } ], "name": "buySupply", "outputs": [], "payable": true, "type": "function" }, { "constant": false, "inputs": [ { "name": "to", "type": "address" }, { "name": "uniqueHash", "type": "bytes32" } ], "name": "transferRegistration", "outputs": [], "payable": false, "type": "function" }, { "constant": false, "inputs": [ { "name": "uniqueHash", "type": "bytes32" } ], "name": "claimGood", "outputs": [], "payable": false, "type": "function" }, { "constant": false, "inputs": [ { "name": "uniqueHash", "type": "bytes32" }, { "name": "supplyIndex", "type": "uint256" }, { "name": "minSalePriceInWei", "type": "uint256" } ], "name": "offerSupplyForSale", "outputs": [], "payable": false, "type": "function" }, { "constant": false, "inputs": [ { "name": "uniqueHash", "type": "bytes32" }, { "name": "to", "type": "address" } ], "name": "getSupplyBalance", "outputs": [ { "name": "amount", "type": "uint256" } ], "payable": false, "type": "function" }, { "constant": false, "inputs": [], "name": "EthergoodsMarket", "outputs": [], "payable": true, "type": "function" }, { "constant": false, "inputs": [], "name": "withdraw", "outputs": [], "payable": false, "type": "function" }, { "constant": false, "inputs": [ { "name": "uniqueHash", "type": "bytes32" }, { "name": "supplyIndex", "type": "uint256" } ], "name": "supplyNoLongerForSale", "outputs": [], "payable": false, "type": "function" }, { "constant": false, "inputs": [ { "name": "uniqueHash", "type": "bytes32" }, { "name": "supplyIndex", "type": "uint256" }, { "name": "minPrice", "type": "uint256" } ], "name": "acceptBidForSupply", "outputs": [], "payable": false, "type": "function" }, { "constant": false, "inputs": [ { "name": "enabled", "type": "bool" }, { "name": "uniqueHash", "type": "bytes32" } ], "name": "setClaimsEnabled", "outputs": [], "payable": false, "type": "function" }, { "constant": true, "inputs": [], "name": "standard", "outputs": [ { "name": "", "type": "string" } ], "payable": false, "type": "function" }, { "constant": true, "inputs": [], "name": "symbol", "outputs": [ { "name": "", "type": "string" } ], "payable": false, "type": "function" }, { "constant": true, "inputs": [ { "name": "", "type": "bytes32" } ], "name": "goods", "outputs": [ { "name": "initialized", "type": "bool" }, { "name": "creator", "type": "address" }, { "name": "name", "type": "string" }, { "name": "description", "type": "string" }, { "name": "totalSupply", "type": "uint256" }, { "name": "nextSupplyIndexToSell", "type": "uint256" }, { "name": "uniqueHash", "type": "bytes32" }, { "name": "claimPrice", "type": "uint256" }, { "name": "claimsEnabled", "type": "bool" } ], "payable": false, "type": "function" }, { "constant": false, "inputs": [ { "name": "uniqueHash", "type": "bytes32" }, { "name": "supplyIndex", "type": "uint256" } ], "name": "withdrawBidForSupply", "outputs": [], "payable": false, "type": "function" }, { "constant": false, "inputs": [ { "name": "to", "type": "address" }, { "name": "uniqueHash", "type": "bytes32" }, { "name": "name", "type": "string" }, { "name": "description", "type": "string" }, { "name": "totalSupply", "type": "uint256" }, { "name": "claimPrice", "type": "uint256" } ], "name": "registerNewGood", "outputs": [], "payable": false, "type": "function" }, { "constant": false, "inputs": [ { "name": "uniqueHash", "type": "bytes32" }, { "name": "supplyIndex", "type": "uint256" } ], "name": "enterBidForSupply", "outputs": [], "payable": true, "type": "function" }, { "constant": true, "inputs": [ { "name": "", "type": "address" } ], "name": "pendingWithdrawals", "outputs": [ { "name": "", "type": "uint256" } ], "payable": false, "type": "function" }, { "anonymous": false, "inputs": [ { "indexed": true, "name": "to", "type": "address" }, { "indexed": false, "name": "goodHash", "type": "bytes32" } ], "name": "RegisterGood", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": true, "name": "from", "type": "address" }, { "indexed": true, "name": "to", "type": "address" }, { "indexed": false, "name": "goodHash", "type": "bytes32" } ], "name": "RegistrationTransfer", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": true, "name": "owner", "type": "address" }, { "indexed": false, "name": "enabele", "type": "bool" }, { "indexed": false, "name": "goodHash", "type": "bytes32" } ], "name": "ModifyClaimsEnable", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": true, "name": "owner", "type": "address" }, { "indexed": false, "name": "price", "type": "uint256" }, { "indexed": false, "name": "goodHash", "type": "bytes32" } ], "name": "ModifyClaimsPrice", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": true, "name": "to", "type": "address" }, { "indexed": false, "name": "goodHash", "type": "bytes32" }, { "indexed": false, "name": "supplyIndex", "type": "uint256" } ], "name": "ClaimGood", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": true, "name": "uniqueHash", "type": "bytes32" }, { "indexed": true, "name": "from", "type": "address" }, { "indexed": true, "name": "to", "type": "address" }, { "indexed": false, "name": "amount", "type": "uint256" } ], "name": "TransferSupply", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": true, "name": "uniqueHash", "type": "bytes32" }, { "indexed": true, "name": "supplyIndex", "type": "uint256" }, { "indexed": false, "name": "minValue", "type": "uint256" }, { "indexed": true, "name": "toAddress", "type": "address" } ], "name": "SupplyOffered", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": true, "name": "uniqueHash", "type": "bytes32" }, { "indexed": true, "name": "supplyIndex", "type": "uint256" }, { "indexed": false, "name": "value", "type": "uint256" }, { "indexed": true, "name": "fromAddress", "type": "address" } ], "name": "SupplyBidEntered", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": true, "name": "uniqueHash", "type": "bytes32" }, { "indexed": true, "name": "supplyIndex", "type": "uint256" }, { "indexed": false, "name": "value", "type": "uint256" }, { "indexed": true, "name": "fromAddress", "type": "address" } ], "name": "SupplyBidWithdrawn", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": true, "name": "uniqueHash", "type": "bytes32" }, { "indexed": true, "name": "supplyIndex", "type": "uint256" }, { "indexed": false, "name": "value", "type": "uint256" }, { "indexed": false, "name": "fromAddress", "type": "address" }, { "indexed": true, "name": "toAddress", "type": "address" } ], "name": "SupplyBought", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": true, "name": "uniqueHash", "type": "bytes32" }, { "indexed": true, "name": "supplyIndex", "type": "uint256" }, { "indexed": false, "name": "value", "type": "uint256" }, { "indexed": true, "name": "fromAddress", "type": "address" }, { "indexed": false, "name": "toAddress", "type": "address" } ], "name": "SupplySold", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": true, "name": "uniqueHash", "type": "bytes32" }, { "indexed": true, "name": "supplyIndex", "type": "uint256" } ], "name": "SupplyNoLongerForSale", "type": "event" } ]');
}


function checkLoginSignature(_signature_response_hex,_challenge_digest_hash)
{

  if(typeof _challenge_digest_hash != 'buffer')
  {
    _challenge_digest_hash = Buffer.from(_challenge_digest_hash,'hex')
  }


  var vrs_data = ethUtil.fromRpcSig(_signature_response_hex)


  //message is incorrect length
  var public_key_from_sig = ethUtil.ecrecover(_challenge_digest_hash,vrs_data.v,vrs_data.r,vrs_data.s)
  var public_key_from_sig_hex = public_key_from_sig.toString('hex')
  console.log( public_key_from_sig_hex );



  var address_at_pub_key = ethUtil.publicToAddress(public_key_from_sig);
  var public_address_from_sig_hex = address_at_pub_key.toString('hex');
  console.log( public_address_from_sig_hex );

    console.log( public_address_from_sig_hex );

      console.log('VRS');
      console.log( vrs_data  );

          var vrs_data_integer = {
            v: vrs_data.v.toString(16),
            r: vrs_data.r.toString('hex'),
            s: vrs_data.s.toString('hex')

          }

          console.log( vrs_data_integer );

  var auth_url = "/punk/auth_into_eth_address";

    $.ajax({
    url: auth_url,
    method: "POST",
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    data: {
      signature: _signature_response_hex,
       challenge: _challenge_digest_hash.toString('hex'),
       signature_v: vrs_data_integer.v,
       signature_r: vrs_data_integer.r,
       signature_s: vrs_data_integer.s,

     },
   }).success(function(result) {
      console.log(result)
    }).done(function() {
      console.log("authed in properly ");
      window.location.href = "/";
    });




}
