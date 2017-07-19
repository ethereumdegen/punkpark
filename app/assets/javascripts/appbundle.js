
window.$ = window.jQuery = global.$ = require('jquery');
var eth_utils =  require('ethereumjs-util');



window.addEventListener('load', function() {
  console.log('loading');


  if (typeof web3 == 'undefined') {

    console.log('No web3? You should consider trying MetaMask!')
    // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
    window.web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));


  } else {


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

            web3.personal.sign(msg, from, function (err, result) {
             if (err) return console.error(err)
             console.log('PERSONAL SIGNED:' + result)


           });

           //send the expected public key, challenge, and signature to the server via Ajax to sign in







        });



}

});
