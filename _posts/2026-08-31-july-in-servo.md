---
layout:     post
tags:       blog
title:      "July in Servo: and more!"
date:       2026-08-31
summary:    ao!! wrrrrao!!
categories:
---

[**Servo 0.5.0**](https://github.com/servo/servo/releases/tag/v0.5.0) contains all of the changes we landed in July, which came out to **488 commits**.
For security fixes, see [**§ Security**](#security).

**DOM text selections** are now visible (@mrobinson, @SimonSapin, #46698, #46864, #46742, #46889, #46126).
Interactive selection is coming soon!

<figure>
    <a href="{{ '/img/blog/2026-08-diffie.png' | url }}"><img src="{{ '/img/blog/2026-08-diffie.png' | url }}" alt="servoshell 0.5.0 showing several new features: ‘text-decoration-thickness’, ‘box-decoration-break’, web fonts in inline `<svg>`, and DOM selection rendering"></a>
</figure>

We’ve shipped several new web platform features:

- **‘Cache-Control: stale-while-revalidate’** (@arayaryoma, #46060)
- **‘text-decoration-thickness’** (@nicoburns, #46592)
- **‘box-decoration-break’**, for the most part (@Psychpsyo, #45492)
- **‘@font-feature-values’**, for the most part (@simonwuelker, #45308)
- **‘font-language-override’**, for the most part (@simonwuelker, #46618)
- **‘font-variant-alternates’**, for the most part (@simonwuelker, #45308)

Plus a bunch of new DOM APIs:

- [**Ed448**](https://wicg.github.io/webcrypto-secure-curves/#ed448), [**X448**](https://wicg.github.io/webcrypto-secure-curves/#x448), and [**KMAC**](https://wicg.github.io/webcrypto-modern-algos/#kmac) algorithms in **Subtle­Crypto** (@kkoyung, #46402, #46141, #46180, #46583, #46606, #46622, #46334, #46376)
- **‘insert­Horizontal­Rule’**, **‘insert­Image’**, **‘insert­Text’**, and **‘forward­Delete’** commands in **document.exec­Command()** (@Psychpsyo, #46608, #46597, #46538, #46838)
- **Animation­Effect** (@simonwuelker, #46677)
- **new Touch()** (@yezhizhen, #46741)
- **duplex** property on **Request** (@Taym95, #46858)
- **effect** property on **Animation** (@simonwuelker, #46677)
- **get­Keyframes()** and **set­Keyframes()** on **Keyframe­Effect** (@simonwuelker, #46118)
- **id** property on **Largest­Contentful­Paint** (@shubhamg13, #46828)
- read-only **CSS­Font­Feature­Values­Rule** (@simonwuelker, #46728)

This is another big update, so here’s an outline:

- [**You can help!**](#you-can-help)

- [**Security**](#security)

- [**Real world compat**](#real-world-compat)

- [**Work in progress**](#work-in-progress)

- [**Embedding API**](#embedding-api)

- [**For users and developers**](#for-users-and-developers)

- [**More on the web platform**](#more-on-the-web-platform)

- [**Performance and stability**](#performance-and-stability)

- [**New contributors**](#new-contributors)

## You can help!

If you’re working on a pull request that you think might be interesting for the next monthly update, even if you’re not 100% sure, tell us about it by following the steps below:

1. You add the <span style="padding: 0.1875lh; border-radius: calc(0.5lh + 2 * 1px); background: rgb(13, 17, 23);"><span style="padding: 0 0.25lh; border: thin solid rgba(85, 221, 126, 0.3); border-radius: 0.5lh; color: rgb(85, 221, 126); background-color: rgba(84, 222, 126, 0.18);">monthly update</span></span> label to your pull request, or comment <code style="display: /* allow wrapping only as last resort */ inline-block;">[@servo-highfive](https://github.com/servo-highfive) monthly update</code>

2. Highfive posts a comment asking you some questions

3. You answer those questions in a comment containing <code style="display: /* allow wrapping only as last resort */ inline-block;">[@servo-highfive](https://github.com/servo-highfive) monthly update answer</code>

## Security

Servo was potentially affected by vulnerabilities in [**quick-xml**](https://crates.io/crates/quick-xml) and [**crossbeam-epoch**](https://crates.io/crates/crossbeam-epoch) that have been fixed in Servo 0.5.0 (@atouchet, @Loirooriol, #46737, #46324).
For more details, see [RUSTSEC-2026-0194](https://rustsec.org/advisories/RUSTSEC-2026-0194), [RUSTSEC-2026-0195](https://rustsec.org/advisories/RUSTSEC-2026-0195), and [RUSTSEC-2026-0204](https://rustsec.org/advisories/RUSTSEC-2026-0204).

## Real world compat

The duck on the **DuckDuckGo ([duckduckgo.com](https://duckduckgo.com))** landing page now renders in v0.5.0, after we fixed a preload bug that affected SVG images (@jdm, #46668).

<figure class="_spaced">
    <div class="_peel" style="--default-position: 22%;">
        <div class="_line">
            <div class="_left"><div>v0.4.0</div></div>
            <div class="_right"><div>v0.5.0</div></div>
        </div>
        <img src="{{ '/img/blog/2026-08-143728.png' | url }}">
        <img src="{{ '/img/blog/2026-08-143737.png' | url }}">
    </div>
    <figcaption><a href="https://duckduckgo.com/">duckduckgo.com</a></figcaption>
</figure>

Most of **Gumroad ([gumroad.com](https://gumroad.com))**, except for the landing page, did not render at all in v0.4.0, but as of v0.5.0, pages like the [**Discover page**](https://gumroad.com/discover) or [**this product page**](https://harrycraft2.gumroad.com/l/theworldslongestcity) render almost perfectly.

<figure class="_spaced">
    <div class="_peel" style="--default-position: 40%;">
        <div class="_line">
            <div class="_left"><div>v0.4.0</div></div>
            <div class="_right"><div>v0.5.0</div></div>
        </div>
        <img src="{{ '/img/blog/2026-08-165201.png' | url }}">
        <img src="{{ '/img/blog/2026-08-164722.png' | url }}">
    </div>
    <figcaption><a href="https://gumroad.com/discover">gumroad.com</a></figcaption>
</figure>

<figure class="_spaced">
    <div class="_peel" style="--default-position: 40%;">
        <div class="_line">
            <div class="_left"><div>v0.4.0</div></div>
            <div class="_right"><div>v0.5.0</div></div>
        </div>
        <img src="{{ '/img/blog/2026-08-162729.png' | url }}">
        <img src="{{ '/img/blog/2026-08-162731.png' | url }}">
    </div>
    <figcaption><a href="https://harrycraft2.gumroad.com/l/theworldslongestcity">gumroad.com</a></figcaption>
</figure>

<style>
    ._spaced {
        margin: 1em 0;
    }
    ._halves {
        display: flex;
        flex-flow: row wrap;
    }
    ._halves > * {
        width: 50%;
    }
    ._peel {
        --default-position: 50%;
        position: relative;
        overflow: hidden;
        background: white;
        * {
            /* ensure ‘pointermove’ events always target the root */
            pointer-events: none;
            user-select: none;
        }
        img {
            background: white;
        }
        :not(:last-child) {
            position: absolute;
            inset: 0 auto 0 auto;
            width: var(--position, var(--default-position));
            height: 100%;
            object-fit: cover;
            object-position: top left;
        }
        ._line {
            z-index: 1;
            border-right: thin solid #1192e8;
            div {
                position: absolute;
                right: 0;
                width: 0;
            }
            div div {
                position: absolute;
                width: max-content;
                padding: 0 0.25em;
                background: #ffffff80;
            }
            ._left div {
                /* extend left of the line */
                right: 0;
            }
            ._right div {
                /* extend right of the line */
                left: 0;
            }
        }
    }
</style>

<script>
    for (const peel of document.querySelectorAll("._peel")) {
        peel.addEventListener("pointermove", event => {
            const position = Math.max(0, Math.min(1, event.offsetX / peel.offsetWidth));
            peel.style.setProperty("--position", `${position * 100}%`);
        }, true);
    }
</script>

We’re interested to hear how well your favourite websites run in Servo!
Report successes in [this Zulip thread](https://servo.zulipchat.com/#narrow/channel/263398-general/topic/Servo.20web.20compat.20success.20stories/with/612898341), and failures [in our GitHub issues](https://github.com/servo/servo/issues).

## Work in progress

The upgrade to Stylo 2026-07-01 brings several changes to built-in **CSS functions** (@Loirooriol, #46129):

- **‘alpha()’** is now supported, under `--pref layout­_css­_alpha­_color­_function­_enabled`

- **‘progress()’** is now supported, under `--pref layout­_css­_progress­_function­_enabled`

- **‘ellipse()’** values **‘closest-corner’** and **‘farthest-corner’** are no longer stable due to spec uncertainty, but they are still experimental, under `--pref layout­_css­_ellipse­_corners­_enabled`

- **‘attr()’** is more conformant, under `--pref layout­_css­_attr­_enabled`

**Web­GPU** content can now enjoy better conformance and use **GPU­External­Texture** and **import­External­Texture()** on **GPU­Device**, under `--pref dom­_webgpu­_enabled` (@sagudev, #45873, #46178, #46286).

<figure>
    <a href="{{ '/img/blog/2026-08-webgpu.png' | url }}"><img src="{{ '/img/blog/2026-08-webgpu.png' | url }}" alt="servoshell 0.5.0 showing four tilted rectangles (in WebGPU), textured with a picture of a dog (which is a frame from an external video)"></a>
</figure>

**Indexed­DB** content can now use the **name** property on **IDB­Index**, under `--pref dom­_indexeddb­_enabled` (@skyz1, #45512).

**document.fonts** now includes a **Font­Face** for each valid **‘@font-face’**, under `--pref dom­_fontface­_enabled` (@simonwuelker, #46509, #46537).

All of the features above are enabled in servoshell’s [experimental mode](https://book.servo.org/design-documentation/experimental-features.html#experimental-web-platform-features).

We’ve started implementing **WebVTT** for native **subtitles** and **captions**, enabled by default (no `--pref`).
While they don’t render just yet, we can now fetch each &lt;track src>, parse the WebVTT, and expose cues via the **track** property on **HTML­Track­Element** (@TimvdLippe, #46289, #46383).

July was a big month for **accessibility** in Servo, under `--pref accessibility­_enabled`.
The focus for this month has been on **performance**, with the accessibility tree now supporting **incremental updates** (@alice, @delan, #45578, #45971, #46589, #46691, #46385), requiring **fewer HashMap lookups** and **tree walks** (@alice, @delan, #45798, #46740, #46348), and allowing for **faster DOM mutations** (@alice, #46348, #46530).

We’ve also started working on the [**File and Directory Entries API**](https://wicg.github.io/entries-api/), to allow users to **select** and **upload entire directories** via **&lt;input type=file>** and **drag-and-drop**.
To that end, we now have **webkit­Get­As­Entry()** on **Data­Transfer­Item**, plus minimal support for **File­System­Entry**, **File­System­Directory­Entry**, and **File­System­File­Entry**, under `--pref dom­_entries­_api­_enabled` (@yezhizhen, #46456, #46879, #46832).

## Embedding API

We’ve improved the docs for the [`servo`](https://doc.servo.org/servo/index.html) crate, and for [Web­View­Delegate](https://doc.servo.org/servo/trait.WebViewDelegate.html) (@mukilan, #46193).

**Breaking change:** [`Servo­Builder`](https://doc.servo.org/servo/struct.ServoBuilder.html)::`webxr­_registry()` has been **removed**.
Instead use the new [`Servo`](https://doc.servo.org/servo/struct.Servo.html)::[`register­_webxr­_registry`](https://doc.servo.org/servo/struct.Servo.html#method.register_webxr_registry), which is a **lazy** design that has allowed servoshell to **halve its startup time** (@Narfinger, #46494).

## For users and developers

**servoshell** for **Android** now runs on **Android 10+** (91% market share), not just Android 13+ (68% market share), improving adaptability and reducing waste (@jschwe, #46142, #46308).
We’ve also fixed a problem with building for Android on macOS (@jschwe, #46128).

**servoshell** for **Windows** is now better behaved when run in a console window, making the command prompt wait until servoshell exits (@yezhizhen, #43010).

When using the Firefox **DevTools**, the **Console** tab now supports some basic **autocomplete** (@freyacodes, #46382).

We’ve finished modernising servoshell for Android to use Compose UI (@veyndan, #46085, #46164, #46253, #46257, #46317, #46353, #46565, #46612, #46626, #46666, #46663, #46700), and we’re now migrating Servo as a library to use Kotlin (@veyndan, #46817, #46895, #46772).

## More on the web platform

**Inline SVG** can now use **web fonts** defined in the containing page (@yodalee, #45979).
We’re also implementing the **SVG DOM**, starting with stub interfaces for **SVG­Element**, SVG­Circle­Element, SVG­Defs­Element, SVG­Ellipse­Element, SVG­Line­Element, SVG­Linear­Gradient­Element, SVG­Path­Element, SVG­Polygon­Element, SVG­Polyline­Element, SVG­Radial­Gradient­Element, SVG­Stop­Element, SVG­Rect­Element, SVG­Symbol­Element, and SVG­Use­Element (@mu-mostafa98, #46558).

**&lt;button>** now **vertically centers** its contents (@Loirooriol, @mrobinson, #46590), and behaves better with ‘display: block’ and ‘display: inline’ (@Loirooriol, #46536).

We’ve improved the conformance of **&lt;form>** without **&lt;form action>** (@kevlu93, #46860), **&lt;color> values** (@Loirooriol, #46129), **Gamepad­Event** (@log101, #46788), **document.execCommand("delete")** (@Psychpsyo, #46539), the **selector­Text** property on **CSS­Style­Rule** (@simonwuelker, #46687), and **Set Window Rect** in WebDriver (@janeoa, #46475, #46477).

We’ve fixed bugs related to **&lt;iframe>** (@jschwe, @jdm, #46587), **&lt;img>** (@yodalee, #46892), **&lt;textarea>** (@SimonSapin, @mrobinson, #46309), **custom properties** (@Loirooriol, #46129), **‘::before’** and **‘::after’** (@Loirooriol, #46640), **‘float’** (@Loirooriol, @mrobinson, #46407, #46500, #46505), **‘@font-face’** (@simonwuelker, #46568, #46271, #46436), **‘position: absolute’** (@simonwuelker, #46358, #46637), **Blob** (@jdm, #46881), **IDB­Database** and **IDB­Object­Store** and **IDB­Index** (@mrobinson, #46615), the **adopted­Style­Sheets** property on **Shadow­Root** (@simonwuelker, #46738), **delete()** on **Font­Face­Set** (@simonwuelker, #46634), **move­Before()** on **Element** (@mrobinson, #46599), **resize­To()** on **Window** (@janeoa, #46477), the **selected** property on **HTML­Option­Element** (@rhit-kapilaar, #46386), and the **value** property on **HTML­Select­Element** (@simonwuelker, #46230).

## Performance and stability

**Text rendering** is **up to 10x faster** for cases with the same text and different ‘font-size’ (@Loirooriol, #46129).
**Flex layout** benchmarks are up to **3%** faster, and an improvement to **get­Elements­By­Class­Name()** has made some websites up to **1%** faster (@Narfinger, @jdm, #46563, #46595, #46594).

We’ve also reduced allocations, GC rooting steps, and other operations in many parts of Servo (@jdm, @yezhizhen, @Narfinger, @Gae24, @SimonSapin, @mrobinson, @Taym95, @cychronex-labs, #46411, #46659, #45974, #46377, #45758, #46440, #46762, #46301, #46349, #46419, #46418, #46420, #46460, #46633, #46638, #46690, #46745, #46726, #46564, #46144, #46664, #46462, #46139, #46430, #46446, #46498, #46548, #46598, #46632, #46656, #46678, #46718, #46722).

We’ve fixed a crash regression with memory corruption (@mrobinson, #46316), several dynamic-borrow-related crashes (@Narfinger, @SharanRP, @Taym95, @agrawalx, @amittenak47, @sungmen, #46381, #46384, #46405, #46684, #46452, #46770, #46830, #46763), plus crashes related to:

- **&lt;area>** without **&lt;area href>** (@simonwuelker, #46341)
- **&lt;progress>** or shadow DOM (@mrobinson, @simonwuelker, #46188)
- **&lt;table>** layout (@mrobinson, #46775)
- **&lt;td rowspan>** (@mrobinson, #46841)
- **&lt;svg>** without **&lt;svg viewBox>** (@Narfinger, @mrobinson, #46199)
- **&lt;use>** in SVG (@mrobinson, @Loirooriol, #46261)
- **‘animation’** (@mrobinson, @Loirooriol, #46689)
- **‘content’** (@Loirooriol, @mrobinson, #46314)
- **‘mix-blend-mode’** (@mrobinson, #45624)
- **Array­Buffer** (@jdm, #46504)
- **adopted­Style­Sheets** on **Document** (@TimvdLippe, #46373)
- **exec­Command(`"delete"`)** on **Document** (@TimvdLippe, #46265)
- removing DOM nodes (@SimonSapin, #46866)

We’ve continued our long-running effort to use the Rust type system to make Servo’s integration with SpiderMonkey safer and more reliable (@Gae24, @Narfinger, @TimvdLippe, @jdm, @kunalmohan, @lumiscosity, @simonwuelker, #46191, #46777, #46890, #46243, #46248, #46246, #46310, #46312, #46333, #46147, #46150, #46151, #46229, #46262, #46375, #46374, #46529, #46584, #46585, #46593, #46693, #46166, #46156, #46254, #46267, #46268, #46269, #46270, #46284, #46285, #46318, #46435).

## New contributors

A special thanks to the following people for landing their first patch in Servo:

- Umut Cevdet Koçak (@UMCEKO, #46256)
- Yash Agrawal (@agrawalx, #46770)
- amittenak47 (@amittenak47, #46743)
- Apoorva Pendse (@apoorvapendse, #46739)
- dDostalker (@dDostalker, #46181)
- Oisín Ó Maolchathail (@eachra-bawn, #46478)
- Kevin Lu (@kevlu93, #46860)
- Mohamed Mostafa (@mu-mostafa98, #45405)
- SeongMan Jeon (@sungmen, #46763)
- Yoda Lee (@yodalee, #45979)

Interested in helping build a web browser?
Take a look at our [curated list](https://starters.servo.org) of issues that are good for new contributors!

## Donations

<!--
7681/month → 7824/month
- 3585.07/month opencollective
- 4103.00/month github
- 135.93/month thanks.dev
    - 35 → 35 donors
-->

Thanks again for your generous support!
We are now receiving **7824 USD/month** (+1.8% from June) in recurring donations.
This helps us cover the cost of our **[speedy](https://ci0.servo.org) [CI](https://ci1.servo.org) [and](https://ci2.servo.org) [benchmarking](https://ci3.servo.org) [servers](https://ci4.servo.org)**, one of our latest **[Outreachy interns](https://www.outreachy.org/alums/2026-05/#:~:text=Servo)**, and funding **[maintainer work]({{ '/blog/2025/09/17/your-donations-at-work-funding-jdm/' | url }})** that helps more people contribute to Servo.

Servo is also on [thanks.dev](https://thanks.dev), and already **35 GitHub users** (same as June) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

We now have [**sponsorship tiers**]({{ '/blog/2025/11/21/sponsorship-tiers/' | url }}) that allow you or your organisation to donate to the Servo project with public acknowlegement of your support.
If you’re interested in this kind of sponsorship, please contact us at [join@servo.org](mailto:join@servo.org).

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; right: calc(100% - 100% * 7824 / 10000); padding-right: 0.5em;"><strong>7824</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 7824 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="7824" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
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
