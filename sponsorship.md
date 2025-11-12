---
layout: default.html
title: Sponsorship
---

<div class="inner-container subpage-content">

<div id="sponsor-intro">

<h1> {{ title }} </h1>

You can now help fund the Servo project by [sponsoring us on GitHub](https://github.com/sponsors/servo), [Open Collective](https://opencollective.com/servo) and [thanks.dev](https://thanks.dev/).

Both one-time and monthly donations are appreciated, and over 80% of the amount will go directly towards improving Servo.
To give you a sense of scale…

- at **100 USD/month**, we can cover the costs of our website and other core infrastructure
- at **1,000 USD/month**, we can set up dedicated servers for faster Windows and macOS builds, better test coverage and reliability, and new techniques like fuzzing and performance testing
- at **10,000 USD/month**, we can sponsor a developer to make Servo their top priority

Use of donations is decided transparently via the Technical Steering Committee’s public **[funding request process](https://github.com/servo/project/blob/main/FUNDING_REQUEST.md)**, and active proposals are tracked in [servo/project#187](https://github.com/servo/project/issues/187).

<p class="subtitle">
  If your organization is interested in sponsoring Servo's development or the implementation of a particular feature, reach out to us at <a href="mailto:join@servo.org">join@servo.org</a>.
</p>

</div>

<div id="sponsorship-tiers">

## Sponsorship Tiers

- **Platinum: 10,000 USD/month**
- **Gold: 5,000 USD/month**
- **Silver: 1,000 USD/month**
- **Bronze: 100 USD/month**

Sponsors in the Bronze tier and above will be acknowledged on [servo.org](https://servo.org/) with **their logo or name**.

<p class="subtitle">
  If you are interested in sponsoring the Servo project through one of these tiers, please contact us at <a href="mailto:join@servo.org">join@servo.org</a>.
</p>

A few clarifications:
- The donations should come with no obligations to the project (i.e no strings attached).
- The Servo project doesn't endorse the sponsors that appear at [servo.org](https://servo.org/).
- The Servo project reserves the right to reject sponsors.

</div>

<div id="project-fund">

## Servo Project Fund

The purpose of the Servo Project Fund is to raise, budget, and spend funds in support of the Servo Project.

The Fund is governed by the Directed Fund’s Governing Board at the Linux Foundation Europe. The Board is composed of Members, together with representation from the Linux Foundation Europe and the Technical Steering Committee.

There are currently no members of the Linux Foundation Europe Directed Fund’s Governing Board.

If your organization is interested in becoming a member, please contact us at <join@servo.org> or enroll at the [Linux Foundation member enrollment page](https://enrollment.lfx.linuxfoundation.org/?project=servo).

</div>

<div id="donations">

## Donation fees

Donating via GitHub Sponsors is better for Servo than donating via Open Collective.
**96%** of the amount you donate goes to Servo, unless you are sponsoring us on behalf of a GitHub organization, where a fee will be added on top of the amount during checkout.
Either way, **over 90%** goes to Servo.

<figure class="_donation_fees" id="_github_sponsors_fees">

| Fees for sponsoring... | 5 USD | 10 USD | 20 USD | 50 USD | 100 USD | 1000 USD |
|---|---|---|---|---|---|---|
| as an individual on GitHub |
| on behalf of a GitHub org |
</figure>

The fees for donations on Open Collective depend on how much you donate in a single transaction, and what payment method you use:

- Donating at least **5 USD** at a time ensures that **over 80%** goes to Servo
- Donating at least **50 USD** at a time ensures that **over 90%** goes to Servo
- Donating with Stripe is almost always better for Servo than donating with PayPal

<figure class="_donation_fees" id="_open_collective_fees">

| Fees for... | 5 USD | 10 USD | 20 USD | 50 USD | 100 USD | 1000 USD |
|---|---|---|---|---|---|---|
| Stripe (ACH) |
| Stripe (card, USA) |
| Stripe (card, international) |
| Stripe (card, worst case) |
| PayPal (USA) |
| PayPal (international) |
</figure>



<script>
  const hostFee = x => 0.04 * x;
  const donorCheckoutSurcharges = {
    "as an individual on GitHub": x => 0,
    "on behalf of a GitHub org": x => 0.06 * x,
  };
  const paymentProcessorFees = {
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
  function updateGithubSponsorsTable() {
    const table = document.querySelector("#_github_sponsors_fees table");
    const exampleDonations = [...table.rows[0].cells].slice(1)
      .map(x => parseInt(x.textContent, 10) * 100);
    for (const row of [...table.rows].slice(1)) {
      const donor = row.cells[0].textContent;
      for (const [i, donation] of exampleDonations.entries()) {
        const surcharge = donorCheckoutSurcharges[donor](donation);
        const total = donation + surcharge;
        const fee = surcharge + hostFee(donation); // not hostFee(total)!
        const net = total - fee;
        const totalText = (Math.ceil(total) / 100).toFixed(2);
        const feeText = (Math.ceil(fee) / 100).toFixed(2);
        const netText = (Math.ceil(net) / 100).toFixed(2);
        const feePercentText = (100 * fee / total).toFixed(1);
        const netPercentText = (100 * net / total).toFixed(1);
        const totalClass = surcharge > 0 ? "_total _has_surcharge" : "_total";
        const netClass = net / total >= 0.96 ? "_net _net96" : "_net";
        row.cells[i + 1].innerHTML = `
          <span class="${totalClass}">${totalText}</span>
          <br><span class="_fee">− ${feeText} (${feePercentText}%)</span>
          <br><strong class="${netClass}">= ${netText} (${netPercentText}%)</strong>
        `;
      }
    }
  }
  function updateOpenCollectiveTable() {
    const table = document.querySelector("#_open_collective_fees table");
    const exampleDonations = [...table.rows[0].cells].slice(1)
      .map(x => parseInt(x.textContent, 10) * 100);
    for (const row of [...table.rows].slice(1)) {
      const paymentProcessor = row.cells[0].textContent;
      for (const [i, donation] of exampleDonations.entries()) {
        const fee = paymentProcessorFees[paymentProcessor](donation) + hostFee(donation);
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
  updateGithubSponsorsTable();
  updateOpenCollectiveTable();
</script>
</div>

<style>

  ._note {
    margin: 1em 1em;
    border-left: 1px solid;
    padding-left: 1em;
    opacity: 0.75;
  }
  ._donation_fees {
    overflow-x: auto;
  }
  ._donation_fees table {
    width: max-content;
    max-width: 100%;
  }
  ._donation_fees tr > *:not(#specificity) {
    text-align: left;
  }
  ._donation_fees tr > *:nth-child(1) {
    /* Freeze the first cell of each row. */
    position: sticky;
    left: 0;
    /* Hide other cells that overlap when scrolling. */
    background:lch(91 8.22 196.44);
    z-index: 1;
  }
  ._total {
    opacity: 0.75;
  }
  ._has_surcharge {
    opacity: 1;
    color: #FAAE30;
  }
  ._fee {
    opacity: 0.75;
  }
  ._net {
    opacity: 0.75;
  }
  ._net96, ._net90 {
    opacity: 1;
    color: #42BF64;
  }
</style>
