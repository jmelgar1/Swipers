/*
const functions = require('firebase-functions');
const admin = require('firebase-admin');
const express = require("express");
const session = require("express-session");
const app = express();
const port = process.env.PORT || 5832;

// Set your secret key. Remember to switch to your live secret key in production.
// See your keys here: https://dashboard.stripe.com/apikeys
const stripe = require('stripe')('sk_test_51Kar8XITdHoTvfpldeXLv8vHO5bSMXUolDEKtIAcsidzOq2MvLP1bWWAOLnFPMfFgePWWNuXeAOPmxbwPzi8140h00wxI7Yh0W');

app.use(express.static(process.env.STATIC_DIR));

app.use(
  session({
    secret: "348rm349qmwroeifmweifasofmawu39",
    resave: false,
    saveUninitialized: true,
  })
);
/*
app.get("/", (req, res) => {
  const path = resolve("/index.html");
  res.sendFile(path);
});

app.post("/onboard-user", async (req, res) => {
  try {
    const account = await stripe.accounts.create({
      type: 'express',
    });

    req.session.accountID = account.id;

    const accountLink = await stripe.accountLinks.create({
      account: account.id,
      refresh_url: 'https://swipers.live/html/refresh.html',
      return_url: 'https://swipers.live/html/return.html',
      type: 'account_onboarding',
});

  res.redirect(303, accountLink.url);
} catch (err) {
  res.status(500).send({
    error: err.message,
    });
  }
});

app.get("/onboard-user/refresh", async (req, res) => {
  if (!req.session.accountID) {
    res.redirect("/");
    return;
  }

  try {
    const { accountID } = req.session;
    const origin = `${req.secure ? "https://" : "https://"}${req.headers.host}`;

    const accountLink = await stripe.accountLinks.create({
      type: "account_onboarding",
      account: account.id,
      refresh_url: `${origin}/onboard-user/refresh`,
      return_url: `${origin}/success.html`,
    });

    res.redirect(303, accountLink.url);
  } catch (err) {
    res.status(500).send({
      error: err.message,
    });
  }
});

//Setting up payment endpoint.
app.post('/payment-sheet', async (req, res) => {
  //Use an existing Customer ID if this is a returning customer.
  const customer = await stripe.customers.create();
  const ephemeralKey = await stripe.ephemeralKeys.create(
    {customer: customer.id},
    {apiVersion: '2020-08-27'}
  );
  const paymentIntent = await stripe.paymentIntents.create({
    amount: 1099,
    currency: 'usd',
    customer: customer.id,
    automatic_payment_methods: {
      enabled: true,
    },
    application_fee_amount: 123,
    transfer_data: {
      destination: 'connected account id',
    },
  });

  res.json({
    paymentIntent: paymentIntent.client_secret,
    ephemeralKey: ephemeralKey.secret,
    customer: customer.id,
    publishableKey: 'pk_test_51Kar8XITdHoTvfpl54Bkhz1HQ5gYue2bMMa5FLgCPtqnuPAMW7rLvhMGEef4vctonNdFq5BQtD2ttuAFlqTGX1cY00EMd2y4Jg'
  });
});
*/
