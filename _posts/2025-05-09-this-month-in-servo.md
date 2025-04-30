---
layout:     post
tags:       blog
title:      "This month in Servo: and more!"
date:       2025-05-09
summary:    ao!! wrrrrao!!
categories:
---

<!--
- donations
    - 1954.40/month opencollective
    - 2710.00/month github
    - 24 donors thanks.dev
- ai policy
- wpt
    - dashboard now has subtests
    - `fromDate = "2025-03-10"`
    - `toDate = "2025-04-30"`
-->

<!--
wpt dashboard analysis
>>> top deltas (score, pp):
/content-security-policy/ (50.9pp to 53.5%)
/trusted-types/ (47.2pp to 47.2%)
/css/css-text/ (17.9pp to 65.3%)
/css/css-sizing/ (10.3pp to 62.8%)
/streams/ (8.2pp to 18.8%)
/css/cssom/ (6.6pp to 72.2%)
All WPT tests (5.6pp to 62.0%)
/shadow-dom/ (5.2pp to 52.1%)
/css/CSS2/box-display/ (4.4pp to 92.2%)
/css/css-align/ (4.0pp to 72.7%)
/css/ (3.1pp to 69.2%)
/css/css-grid/ (3.1pp to 44.3%)
/css/css-flexbox/ (2.0pp to 78.4%)
/css/css-position/ (1.0pp to 52.8%)
/css/CSS2/tables/ & /css/css-tables/ (0.2pp to 92.2%)
/css/CSS2/positioning/ (0.2pp to 94.5%)
/css/CSS2/ (0.1pp to 85.0%)
/css/CSS2/linebox/ (0.0pp to 96.9%)
/css/CSS2/abspos/ (0.0pp to 98.2%)
/css/CSS2/floats/ (0.0pp to 91.5%)
/css/CSS2/floats-clear/ (0.0pp to 93.9%)
/css/CSS2/margin-padding-clear/ (0.0pp to 99.0%)
/css/CSS2/normal-flow/ (0.0pp to 96.5%)
/gamepad/ (0.0pp to 70.8%)
/WebCryptoAPI/ (0.0pp to 39.2%)
/webxr/ (0.0pp to 55.8%)
>>> top deltas (subtests, pp):
/shadow-dom/ (70.0pp to 77.9%)
/trusted-types/ (57.8pp to 57.8%)
/content-security-policy/ (54.0pp to 54.8%)
/streams/ (31.9pp to 68.1%)
/css/css-text/ (20.4pp to 57.6%)
/css/CSS2/linebox/ (5.5pp to 84.8%)
All WPT tests (4.6pp to 87.4%)
/css/CSS2/box-display/ (4.4pp to 92.2%)
/css/css-sizing/ (3.5pp to 72.9%)
/css/cssom/ (3.3pp to 84.7%)
/css/css-flexbox/ (3.1pp to 62.7%)
/css/css-grid/ (2.7pp to 44.3%)
/css/ (2.6pp to 63.0%)
/css/css-align/ (2.2pp to 80.0%)
/css/CSS2/ (0.6pp to 86.6%)
/css/CSS2/tables/ & /css/css-tables/ (0.3pp to 87.2%)
/css/css-position/ (0.2pp to 62.9%)
/css/CSS2/positioning/ (0.2pp to 94.5%)
/css/CSS2/abspos/ (0.0pp to 96.6%)
/css/CSS2/floats/ (0.0pp to 87.8%)
/css/CSS2/floats-clear/ (0.0pp to 92.2%)
/css/CSS2/margin-padding-clear/ (0.0pp to 99.0%)
/css/CSS2/normal-flow/ (0.0pp to 96.2%)
/gamepad/ (0.0pp to 93.0%)
/WebCryptoAPI/ (0.0pp to 60.7%)
/webxr/ (0.0pp to 64.0%)
-->

## Donations

Thanks again for your generous support!
We are now receiving **4664 USD/month** (+6.8% over February) in recurring donations.
This helps cover the cost of our [self-hosted](https://ci0.servo.org) [CI](https://ci1.servo.org) [runners](https://ci2.servo.org) and [Outreachy](https://www.outreachy.org/) internships.

Servo is also on [thanks.dev](https://thanks.dev), and already **24 GitHub users** (+3 over February) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 4664 / 10000); padding-left: 0.5em;"><strong>4664</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 4664 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="4664" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

As always, use of these funds will be decided transparently in the Technical Steering Committee.
For more details, head to our [Sponsorship page]({{ '/sponsorship/' | url }}).

<style>
    ._correction {
        max-width: 33em;
        margin: 1em auto;
        border-bottom: 1px solid;
        padding-bottom: 1em;
    }
    ._note {
        margin: 1em 1em;
        border-left: 1px solid;
        padding-left: 1em;
        opacity: 0.75;
    }
</style>
