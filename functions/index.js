const stripe = require('stripe')("sk_test_51Kar8XITdHoTvfpldeXLv8vHO5bSMXUolDEKtIAcsidzOq2MvLP1bWWAOLnFPMfFgePWWNuXeAOPmxbwPzi8140h00wxI7Yh0W");
const functions = require('firebase-functions');

exports.createConnectAccount = functions.https.onRequest((req, res) =>
{
  var data = req.body
  var email = data.email
  var response = {}

  stripe.accounts.create(
    {
      type: 'custom',
      country: 'US',
      requested_capabilities: [
        'transfers',
      ],
      business_type: 'individual',
    },
    ((err, account) => {
      if(err){
        console.log("Couldn't create stripe account: " + err)
        return res.send(err)
      }

      console.log("ACCOUNT: " + account.id)
      response.body = {success: account.id}
      return res.send(response)
    })
  );
});

exports.createStripeAccountLink = functions.https.onRequest((req, res) => {
  var data = req.body
  var accountID = data.accountID

  var response = {}

  stripe.accountLinks.create({
    account: accountID,
    failure_url: 'swipers.live/info.html',
    success_url: 'swipers.live/about.html',
    type: 'custom_account_verification',
    collect: 'eventually_due',
  }, ((err, accountLink) => {
    if(err){
      console.log(err)
      response.body = {failure: err}
      return res.send(response)
    }

    console.log(accountLink.url)
      reponse.body = {success: accountLink.url}
      return res.send(response)
  }));
});
