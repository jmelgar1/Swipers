
const functions = require('firebase-functions');
const admin = require('firebase-admin');

// Set your secret key. Remember to switch to your live secret key in production.
// See your keys here: https://dashboard.stripe.com/apikeys
const stripe = require('stripe')('sk_test_51Kar8XITdHoTvfpldeXLv8vHO5bSMXUolDEKtIAcsidzOq2MvLP1bWWAOLnFPMfFgePWWNuXeAOPmxbwPzi8140h00wxI7Yh0W');
const account = stripe.accounts.create({type: 'express'});

//Change these values, need to create website
const accountLink = stripe.accountLinks.create({
  account: 'acct_1032D82eZvKYlo2C',
  refresh_url: 'https://example.com/reauth',
  return_url: 'https://example.com/reauth',
  type: 'account_onboarding',
});
