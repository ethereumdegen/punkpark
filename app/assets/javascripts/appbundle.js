
window.$ = window.jQuery = global.$ = require('jquery');
var ethUtil =  require('ethereumjs-util');



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


            var msg = ethUtil.bufferToHex(new Buffer(text, 'utf8'))
          //   var msg = '0x1' // hexEncode(text)
            console.log(msg)
            var from = web3.eth.accounts[0]

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



}

});


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
