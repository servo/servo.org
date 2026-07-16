---
layout:     post
tags:       blog
title:      "June in Servo: and more!"
date:       2026-07-31
summary:    ao!! wrrrrao!!
categories:
---

[**Servo 0.4.0**](https://github.com/servo/servo/releases/tag/v0.4.0) contains all of the changes we landed in May, which came out to yet another record **558 commits** (April: 534, May: 391).
For security fixes, see [**§ Security**](#security).

## New contributors

A special thanks to the following people for landing their first patch in Servo:

- Deepam Goyal (@Deepam02, #44836)
- Mark (@Mark-Boger, #45486)
- Mr SheerLuck (@MrSheerluck, #45557)
- Psychpsyo (Cameron) (@Psychpsyo, #45494)
- TusharSariya (@TusharSariya, #43663)
- Adam Sharif (@adamsharifc, #45551)
- Akash Ravikumar (@ak4shravikumar, #45736)
- Sean Cunneen (@alexcat3, #45419)
- Abdul Wahab Melethil Shibu (@cychronex-labs, #45880)
- darkdragon-001 (@darkdragon-001, #45267)
- Frédéric Wang Nélar (@fred-wang, #45834)
- fxzjshm (@fxzjshm, #45285)
- Piyush Gupta (@guptapiyush16, #45845)
- Ivo Murrell (@ivomurrell, #45645)
- rhit-kapilaar (@rhit-kapilaar, #45556)
- sahvx655-wq (@sahvx655-wq, #45510)
- Kagami Sascha Rosylight (@saschanaz, #45731)
- shangguanmachine-dot (@shangguanmachine-dot, #45310)
- Glenn Skrzypczak (@skyz1, #45471)
- Oskar Steiger (@steigeo, #45416)
- Veyndan Stuart (@veyndan, #45326)

Interested in helping build a web browser?
Take a look at our [curated list](https://starters.servo.org) of issues that are good for new contributors!

## Donations

<!--
7681.89/month total donations
- 3470.90/month opencollective
- 4065.00/month github
- 35 donors 145.99/month thanks.dev
-->

Thanks again for your generous support!
We are now receiving **7681 USD/month** (+0.2% from May) in recurring donations.
This helps us cover the cost of our **[speedy](https://ci0.servo.org) [CI](https://ci1.servo.org) [and](https://ci2.servo.org) [benchmarking](https://ci3.servo.org) [servers](https://ci4.servo.org)**, one of our latest **[Outreachy interns](https://www.outreachy.org/alums/2026-05/#:~:text=Servo)**, and funding **[maintainer work]({{ '/blog/2025/09/17/your-donations-at-work-funding-jdm/' | url }})** that helps more people contribute to Servo.

Servo is also on [thanks.dev](https://thanks.dev), and already **35 GitHub users** (same as May) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

We now have [**sponsorship tiers**]({{ '/blog/2025/11/21/sponsorship-tiers/' | url }}) that allow you or your organisation to donate to the Servo project with public acknowlegement of your support.
If you’re interested in this kind of sponsorship, please contact us at [join@servo.org](mailto:join@servo.org).

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; right: calc(100% - 100% * 7681 / 10000); padding-right: 0.5em;"><strong>7681</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 7681 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="7681" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

Use of donations is decided transparently via the Technical Steering Committee’s public **[funding request process](https://github.com/servo/project/blob/main/FUNDING_REQUEST.md)**, and active proposals are tracked in [servo/project#187](https://github.com/servo/project/issues/187).
For more details, head to our [Sponsorship page]({{ '/sponsorship/' | url }}).

<style>
    kbd {
        background: #00000020;
        margin: 0 0.125rem;
        padding: 0.125rem;
        border-radius: 0.25rem;
    }
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

<script>
    (function makeVideoPlayersClickable() {
        addEventListener("toggle", event => {
            const details = event.target.closest("details");
            if (!details?.open) {
                return;
            }
            const video = details.querySelector("video");
            if (!video) {
                return;
            }
            if (video.fastSeek) {
                video.fastSeek(0);
            } else {
                video.currentTime = 0;
            }
            video.play();
        }, true);
    })();
</script>
