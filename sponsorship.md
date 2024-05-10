---
layout: default.html
title: Sponsorship
---

# Sponsorship

You can now help fund the Servo project by [sponsoring us on GitHub](https://github.com/sponsors/servo) or [Open Collective](https://opencollective.com/servo).

<aside class="_note">

Note that we will stop accepting donations [on LFX](https://crowdfunding.lfx.linuxfoundation.org/projects/servo) soon.
Any funds left over will also be transferred to the Servo project, but recurring donations will be cancelled, so if you would like to continue your recurring donation, please do so on GitHub or Open Collective.
</aside>

Both one-time and monthly donations are appreciated, and over 80% of the amount will go directly towards improving Servo.
The way the funds are used is decided in public via the Technical Steering Committee, but to give you a sense of scale…

- at **100 USD/month**, we can cover the costs of our website and other core infrastructure
- at **1,000 USD/month**, we can set up dedicated servers for faster Windows and macOS builds, better test coverage and reliability, and new techniques like fuzzing and performance testing
- at **10,000 USD/month**, we can sponsor a developer to make Servo their top priority

<div class="hero is-info is-small">
  <div class="hero-body">
    <p class="subtitle">
      If your organization is interested in sponsoring Servo's development or the implementation of a particular feature, reach out to us at <a href="mailto:join@servo.org">join@servo.org</a>.
    </p>
  </div>
</div>
<br>

## Servo Project Fund

The purpose of the Servo Project Fund is to raise, budget, and spend funds in support of the Servo Project.

The Fund is governed by the Directed Fund’s Governing Board at the Linux Foundation Europe. The Board is composed of Members, together with representation from the Linux Foundation Europe and the Technical Steering Committee.

There are currently no members of the Linux Foundation Europe Directed Fund’s Governing Board.

If your organization is interested in becoming a member, please contact us at <join@servo.org> or enroll at the [Linux Foundation member enrollment page](https://enrollment.lfx.linuxfoundation.org/?project=servo).

## Donation fees

The fees for donations on Open Collective depend on how much you donate in a single transaction, and what payment method you use:

- Donating at least **5 USD** at a time ensures that **over 80%** goes to Servo
- Donating at least **50 USD** at a time ensures that **over 90%** goes to Servo
- Donating with Stripe is almost always better for Servo than donating with PayPal

| Fees for... | 5 USD | 10 USD | 20 USD | 50 USD | 100 USD | 1000 USD |
|---|---|---|---|---|---|---|
| Stripe (ACH) |
| Stripe (card, USA) |
| Stripe (card, international) |
| Stripe (card, worst case) |
| PayPal (USA) |
| PayPal (international) |

The exact fees for donations on GitHub Sponsors are still being worked out with GitHub, but we’ll post them here once we know.

<script>
  const hostFee = x => 0.04 * x;
  const fees = {
    // Stripe for USA merchants
    // <https://stripe.com/us/pricing>
    // - > Payments > Bank debits and transfers (for ACH)
    // - > Payments > Cards and wallets (for card)
    //   - plus “international cards” (for international)
    //   - plus “currency conversion” too (for worst case)
    //   - no “manually entered cards”
    "Stripe (ACH)": x => 30 + 0.008 * x,
    "Stripe (card, USA)": x => 30 + 0.029 * x,
    "Stripe (card, international)": x => 30 + (0.029 + 0.015) * x,
    "Stripe (card, worst case)": x => 30 + (0.029 + 0.015 + 0.01) * x,
    // PayPal for USA merchants
    // <https://www.paypal.com/us/webapps/mpp/merchant-fees#statement-2>
    // > Commercial Transaction Rates
    // - > Fixed fee for commercial transactions (based on currency received) > US dollar
    // - plus > Standard rate for receiving domestic transactions > PayPal Guest Checkout
    //   - currently same as “PayPal Checkout”
    // - plus > Additional percentage-based fee for international commercial transactions
    //   (for international)
    "PayPal (USA)": x => 49 + 0.0349 * x,
    "PayPal (international)": x => 49 + (0.0349 + 0.015) * x,
  };
  function updateOpenCollectiveTable() {
    const table = document.querySelector("table");
    const exampleDonations = [...table.rows[0].cells].slice(1)
      .map(x => parseInt(x.textContent, 10) * 100);
    for (const row of [...table.rows].slice(1)) {
      const paymentProcessor = row.cells[0].textContent;
      for (const [i, donation] of exampleDonations.entries()) {
        const fee = fees[paymentProcessor](donation) + hostFee(donation);
        const net = donation - fee;
        const feeText = (Math.ceil(fee) / 100).toFixed(2);
        const netText = (Math.ceil(net) / 100).toFixed(2);
        const feePercentText = (100 * fee / donation).toFixed(1);
        const netPercentText = (100 * net / donation).toFixed(1);
        const netClass = net / donation >= 0.9 ? "_net _net90" : "_net";
        row.cells[i + 1].innerHTML = `
          <span class="_fee">− ${feeText} (${feePercentText}%)</span>
          <br><strong class="${netClass}">= ${netText} (${netPercentText}%)</strong>
        `;
      }
    }
  }
  updateOpenCollectiveTable();
</script>

<style>
  ._note {
    margin: 1em 1em;
    border-left: 1px solid;
    padding-left: 1em;
    opacity: 0.75;
  }
  ._fee {
    opacity: 0.75;
  }
  ._net {
    opacity: 0.75;
  }
  ._net90 {
    opacity: 1;
    color: #42BF64;
  }
</style>
