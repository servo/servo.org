---
layout:     post
tags:       blog
title:      "This year in Servo: over 1000 pull requests and beyond"
date:       2023-12-18
summary:    "Reflections on Servo’s progress in 2023: contributor stats, new features, layout improvements, WPT pass rates, and plans for next year."
categories:
---

Servo is well and truly back.

<figure class="_figr _default"><a href="{{ '/img/blog/recap-2023-contributors.png' | url }}"><img src="{{ '/img/blog/recap-2023-contributors.png' | url }}"
    alt="Pie chart: 12% by non-Igalia reviewers, 39% by Igalia reviewers, 5% by non-reviewer Igalians, 7% by neither, 37% by bots"></a>
<figcaption>Contributors to <a href="https://github.com/servo/servo">servo/servo</a> in 2023.</figcaption></figure>

<span class="_floatmin"></span>
This year, to date, we’ve had **53 unique contributors** (+140% over 22 last year), landing **1037 pull requests** (+382% over 215) and 2485 commits (+375% over 523), and that’s just in [our main repo](https://github.com/servo/servo)!

Individual contributors are important for the health of the project, and of the pull requests made by humans (rather than our [friendly](https://github.com/servo-wpt-sync) [bots](https://github.com/dependabot)), 30% were by people outside Igalia, 18% were by non-reviewers, and over 10% were made by people who were neither.

Servo now supports offscreen rendering, now has experimental WebGPU support (`--pref dom.webgpu.enabled`), and is now listed on [wpt.fyi](https://wpt.fyi) (click <span style="font-variant-caps: all-small-caps;">Edit</span> to add Servo).

[Our new layout engine]({{ '/blog/2023/04/13/layout-2013-vs-2020/' | url }}) is now proving its strengths, with support for iframes, floats, stacking context improvements, inline layout improvements, margin collapsing, ‘position: sticky’, ‘min-width’ and ‘min-height’, ‘max-width’ and ‘max-height’, ‘align-content’, ‘justify-content’, ‘white-space’, ‘text-indent’, ‘text-align: justify’, [‘outline’ and ‘outline-offset’]({{ '/blog/2023/05/31/adding-support-for-outline-properties/' | url }}), and ‘filter: drop-shadow()’.

<figure class="_figl _default" style="clear: both;"><a href="{{ '/img/blog/recap-2023-wpt.png' | url }}"><img src="{{ '/img/blog/recap-2023-wpt.png' | url }}"
    alt="Bar chart: 17% + 64pp in floats, 18% + 55pp in floats-clear, 63% + 15pp in key CSS2 tests, 80% + 14pp in abspos, 34% + 14pp in CSS position module, 67% + 13pp in margin-padding-clear, 49% + 13pp in CSSOM, 51% + 10pp in all CSS tests, 49% + 6pp in all WPT tests"></a>
<figcaption style="max-width: 25em; margin: 0 auto;">Pass rates in parts of the <a href="https://web-platform-tests.org">Web Platform Tests</a> with our new layout engine, showing the improvement we’ve made since the <a href="{{ '/blog/2023/07/20/servo-web-platform-tests/' | url }}">start of our data</a> in April 2023.</figcaption></figure>

<span class="_floatmin" style="clear: right;"></span>
[Floats are notoriously tricky](https://github.com/dbaron/inlines-and-floats), to the point we found them [impossible to implement correctly](https://github.com/servo/servo/wiki/Servo-Layout-Engines-Report) in our legacy layout engine, but thanks to the move from eager to opportunistic parallelism, they are now supported fairly well.
Whereas legacy layout was only ever able to reach 53.9% in the floats tests and 68.2% in floats-clear, we’re now at **82.2% in floats** (+28.3pp over legacy) and **73.3% in floats-clear** (+5.1pp over legacy).

[Acid1](http://acid1.acidtests.org) now passes in the new layout engine, and we’ve also surpassed legacy layout in the **CSS2 abspos (by 50.0pp)**, CSS2 positioning (by 6.5pp), and CSS Position (by 4.4pp) test suites, while making big strides in others, like the **CSSOM tests (+13.1pp)** and key parts of the **CSS2 test suite (+15.8pp)**.

<span class="_floatmin" style="clear: both;"></span>
Next year, our funding will go towards maintaining Servo (thanks to LF Europe), releasing nightlies on Android (LF Europe), finishing our integration with Tauri (NLNet), and implementing tables and better support for floats and non-Latin text (NLNet).

There’s a lot more we would like to do, so if you or a company you know are interested in sponsoring the development of an embeddable, independent, memory-safe, modular, parallel web rendering engine, we want to hear from you!
Head over to [our LFX crowdfunding page](https://crowdfunding.lfx.linuxfoundation.org/projects/servo), or email [join@servo.org](mailto:join@servo.org) for enquiries.

In a decade that many people feared would become the nadir of browser engine diversity, we hope we can help change that with Servo.

<!--
pull request data
$ tools/list-pull-requests.sh servo/servo '2022-.*' | tee 2022.json
$ tools/list-pull-requests.sh servo/servo '2023-.*' | tee 2023.json

pull requests
- 2022: 215 (< 2022.json jq -s length)
- 2023: 1037 (< 2023.json jq -s length)

contributors
- 2022: 22 (< 2022.json jq -r .user.login | sort | uniq -c | sort -nr | wc -l)
- 2023: 53 (< 2023.json jq -r .user.login | sort | uniq -c | sort -nr | wc -l)

reviewers
- https://github.com/orgs/servo/teams/developers
- copy($$("#team-members li[data-bulk-actions-id]").map(x => x.dataset.bulkActionsId).sort().join("\n"))

commits
- 2022: 523 (git log --pretty=format:$'%h\t%cd' | rg ' 2022 ' | wc -l)
- 2023: 2485 (git log --pretty=format:$'%h\t%cd' | rg ' 2023 ' | wc -l)

for wpt pass rates and all other analysis, see assets/img/blog/recap-2023.ods
-->

<style>
    /* guaranteed minimum width for first paragraph after a float */
    ._floatmin {
        display: block;
        width: 13em;
        overflow: hidden;
    }
    ._none {
        display: none;
    }
    ._fig:not(#specificity) {
        width: 33em;
        max-width: 100%;
        margin: 1em auto;
    }
    ._fig > ._flex {
        display: flex;
    }
    ._fig._min {
        width: min-content;
    }
    ._fig table {
        text-align: initial;
    }
    ._fig figcaption._notes {
        text-align: left;
        width: max-content;
        max-width: 100%;
    }
    ._figl:not(#specificity),
    ._figr:not(#specificity) {
        margin: 0 1em 1em;
    }
    ._figl {
        float: left;
    }
    ._figr {
        float: right;
    }
    ._figl > iframe,
    ._figr > iframe,
    ._figl > a > img,
    ._figr > a > img {
        width: 17em;
        max-width: max-content;
    }
    ._figl._default > iframe,
    ._figr._default > iframe,
    ._figl._default > a > img,
    ._figr._default > a > img {
        width: auto;
    }
    ._runin {
        margin-bottom: 1em;
    }
    ._runin > p,
    ._runin > h2 {
        display: inline;
    }
    ._correction {
        max-width: 33em;
        margin: 1em auto;
        border-bottom: 1px solid;
        padding-bottom: 1em;
    }
</style>
