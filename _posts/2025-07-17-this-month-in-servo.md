---
layout:     post
tags:       blog
title:      "This month in Servo: network inspector, a11y support, WebDriver, and more!"
date:       2025-07-17
summary:    Plus huge perf gains thanks to our incremental layout work.
categories:
---

June was Servo’s busiest month in years, with **349 pull requests** landing in our nightly builds!

<canvas id="_stats"></canvas>

Servo now supports **viewport meta** tags ([@shubhamg13](https://github.com/shubhamg13), [@xiaochengh](https://github.com/xiaochengh), [#35901](https://github.com/servo/servo/pull/35901)), the **exportparts** attribute ([@simonwuelker](https://github.com/simonwuelker), [#37345](https://github.com/servo/servo/pull/37345)), the **‘::part()’ selector** ([@simonwuelker](https://github.com/simonwuelker), [#37307](https://github.com/servo/servo/pull/37307)), and several new web API features:

- **&lt;script type="importmap">** ([@wusyong](https://github.com/wusyong), [@pewsheen](https://github.com/pewsheen), [#37291](https://github.com/servo/servo/pull/37291), [#37405](https://github.com/servo/servo/pull/37405), [#37504](https://github.com/servo/servo/pull/37504), [#37552](https://github.com/servo/servo/pull/37552), [#37547](https://github.com/servo/servo/pull/37547), [#37340](https://github.com/servo/servo/pull/37340))
- **ImageBitmap** ([@tharkum](https://github.com/tharkum), [#37025](https://github.com/servo/servo/pull/37025), [#37397](https://github.com/servo/servo/pull/37397), [#37488](https://github.com/servo/servo/pull/37488), [#37560](https://github.com/servo/servo/pull/37560), [#37634](https://github.com/servo/servo/pull/37634))
- **scroll** events in the DOM ([@PotatoCP](https://github.com/PotatoCP), [@Asun0204](https://github.com/Asun0204), [#36687](https://github.com/servo/servo/pull/36687))
- the **supports() method** on **HTMLScriptElement** ([@pewsheen](https://github.com/pewsheen), [#37313](https://github.com/servo/servo/pull/37313))
- the **lang()** and **id()** functions in **XPath** ([@vlindhol](https://github.com/vlindhol), [#34594](https://github.com/servo/servo/pull/34594))
- the **&lt;hr size> attribute** ([@simonwuelker](https://github.com/simonwuelker), [#37211](https://github.com/servo/servo/pull/37211))
- barebones **IndexedDB** support, with `--pref dom_indexeddb_enabled` ([@arihant2math](https://github.com/arihant2math), [@rasviitanen](https://github.com/rasviitanen), [@jdm](https://github.com/jdm), [#33044](https://github.com/servo/servo/pull/33044), [#37652](https://github.com/servo/servo/pull/37652), [#37653](https://github.com/servo/servo/pull/37653))

You can now call **transform()** with [a dictionary](https://drafts.fxtf.org/geometry/#dommatrixinit-dictionary) on **CanvasRenderingContext2D** and **CanvasPattern** ([@tharkum](https://github.com/tharkum), [#37692](https://github.com/servo/servo/pull/37692), [#37731](https://github.com/servo/servo/pull/37731)).

Abort handling on the web is a lot more viable now, with support for **abort()** and **signal** on **AbortController** ([@gterzian](https://github.com/gterzian), [#37192](https://github.com/servo/servo/pull/37192), [#37217](https://github.com/servo/servo/pull/37217)), plus **aborted**, **reason**, and **throwIfAborted()** on **AbortSignal** ([@gterzian](https://github.com/gterzian), [#37218](https://github.com/servo/servo/pull/37218), [#37227](https://github.com/servo/servo/pull/37227), [#37245](https://github.com/servo/servo/pull/37245)).

Our experimental **multiprocess mode** (`-M` / `--multiprocess`) now **works on Windows** ([@wusyong](https://github.com/wusyong), [#37580](https://github.com/servo/servo/pull/37580)).

We’ve fixed several bugs, notably including a bug in the encoding of **HTML form submissions** in non-Unicode documents ([@simonwuelker](https://github.com/simonwuelker), [#37541](https://github.com/servo/servo/pull/37541)), which single-handedly fixed **over 97000 subtests** in the Web Platform Tests.

You can now use a **screen reader** to help you control servoshell’s **browser UI** ([@jdm](https://github.com/jdm), [#37519](https://github.com/servo/servo/pull/37519)).
Note that Servo’s webviews are not yet accessible to screen readers.

<figure>
  <a href="{{ '/img/blog/2025-07-screen-reader.png' | url }}"><img alt="Screenshot of servoshell with the location bar focused, annotated with key presses and Orca screen reader output: “frame” TAB “button” TAB “button” TAB “button” TAB “entry https colon slash slash servo dot org slash selected”" src="{{ '/img/blog/2025-07-screen-reader.png' | url }}"></a>
  <figcaption>Navigating servoshell with <a href="https://orca.gnome.org">Orca</a>, a screen reader. The back, forward, and reload buttons are not yet distinguishable (<a href="https://github.com/servo/servo/issues/38130">#38130</a>).</figcaption>
</figure>

## Devtools

Servo’s [devtools support](https://book.servo.org/hacking/using-devtools.html) is becoming more capable!
We now have basic support for the **Network tab** ([@uthmaniv](https://github.com/uthmaniv), [#37384](https://github.com/servo/servo/pull/37384), [#37263](https://github.com/servo/servo/pull/37263), [#37543](https://github.com/servo/servo/pull/37543), [#37707](https://github.com/servo/servo/pull/37707)), including listing requests and viewing **Headers** and **Timings**.

In addition, our devtools are now compatible with **Firefox 139** ([@eerii](https://github.com/eerii), [#37247](https://github.com/servo/servo/pull/37247)), and we’ve landed some preliminary work towards supporting the **Sources tab** ([@atbrakhi](https://github.com/atbrakhi), [@delan](https://github.com/delan), [#36774](https://github.com/servo/servo/pull/36774), [#37456](https://github.com/servo/servo/pull/37456), [#37197](https://github.com/servo/servo/pull/37197)).

<figure><a href="{{ '/img/blog/2025-07-devtools1-combined.png' | url }}"><img alt="Network tab in the Servo devtools, showing a list of requests, the Headers panel with request and response headers for a request, and the Timings panel with the time each phase of that request took" src="{{ '/img/blog/2025-07-devtools1-combined.png' | url }}"></a></figure>

## Performance

We’ve landed several improvements towards **incremental layout**, a broad class of optimisations that ensure that layout work is only done when something has changed and never done twice.
That work is some subset of [these five steps](https://github.com/servo/servo/wiki/Servo-Layout-Engines-Report#layout-2020):

- **Style**, that is, calculating the styles for the DOM tree
- **[Box tree](https://drafts.csswg.org/css-display/#box-tree) construction**, taking the styled DOM tree as input
- **[Fragment](https://www.w3.org/TR/css-break-4/#fragment) tree construction**, for pages, columns, and [lines](https://www.w3.org/TR/css-text-3/#line-breaking)
- **Stacking context tree construction**, sorting it into CSS [painting order](https://www.w3.org/TR/CSS22/zindex.html#painting-order)
- **Display list construction**, yielding the input we send to WebRender

Servo can now **skip display list construction** when nothing would change ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#37186](https://github.com/servo/servo/pull/37186)).
This change is especially noticeable when moving the mouse cursor around on a page.

**Script queries**, like offsetParent and getBoundingClientRect(), read back information from style and layout.
When answering script queries, [we can often skip some steps](https://github.com/servo/servo/blob/78cd77069797437797158bb860117efa699e9215/components/layout/layout_impl.rs#L1409-L1435) that are not relevant, but three steps were previously unavoidable.
Script queries can now **skip style, box tree, and fragment tree updates** when those are up to date ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#37677](https://github.com/servo/servo/pull/37677)).
This means some queries can now be answered without doing any work at all!

You can now **change ‘transform’**, ‘scale’, ‘rotate’, ‘translate’, and ‘perspective’ **without a full layout** in many cases ([@Loirooriol](https://github.com/Loirooriol), [@mrobinson](https://github.com/mrobinson), [#37380](https://github.com/servo/servo/pull/37380)).

## WebDriver

Work continues on our **WebDriver server**, which can be used to automate Servo and will also power our [support for testdriver.js-based Web Platform Tests](https://book.servo.org/architecture/servodriver.html).
We now better handle operations for [switching contexts](https://w3c.github.io/webdriver/#contexts) ([@yezhizhen](https://github.com/yezhizhen), [@longvatrong111](https://github.com/longvatrong111), [#37685](https://github.com/servo/servo/pull/37685), [#37632](https://github.com/servo/servo/pull/37632), [#37411](https://github.com/servo/servo/pull/37411)), [sending input](https://w3c.github.io/webdriver/#actions) ([@longvatrong111](https://github.com/longvatrong111), [@yezhizhen](https://github.com/yezhizhen), [@PotatoCP](https://github.com/PotatoCP), [#37484](https://github.com/servo/servo/pull/37484), [#37624](https://github.com/servo/servo/pull/37624), [#37403](https://github.com/servo/servo/pull/37403), [#37260](https://github.com/servo/servo/pull/37260), [#37423](https://github.com/servo/servo/pull/37423), [#37224](https://github.com/servo/servo/pull/37224), [#37393](https://github.com/servo/servo/pull/37393), [#37153](https://github.com/servo/servo/pull/37153), [#37095](https://github.com/servo/servo/pull/37095)), [inspecting the page](https://w3c.github.io/webdriver/#element-retrieval) ([@yezhizhen](https://github.com/yezhizhen), [#37521](https://github.com/servo/servo/pull/37521), [#37532](https://github.com/servo/servo/pull/37532), [#37502](https://github.com/servo/servo/pull/37502), [#37452](https://github.com/servo/servo/pull/37452), [#37425](https://github.com/servo/servo/pull/37425), [#37470](https://github.com/servo/servo/pull/37470)), and working with shadow roots ([@yezhizhen](https://github.com/yezhizhen), [@longvatrong111](https://github.com/longvatrong111), [#37546](https://github.com/servo/servo/pull/37546), [#37578](https://github.com/servo/servo/pull/37578), [#37280](https://github.com/servo/servo/pull/37280)).

Want to try automating Servo with WebDriver?
It’s so easy it fits in a blog post!

<figure markdown=1 style="font-size: 75%;">

```sh
$ cargo new app
$ cd app
$ cargo add webdriver_client@0.2.5
```

```rust
use std::{
    error::Error, net::{Shutdown, TcpStream},
    process::Command, thread::sleep, time::Duration,
};

use webdriver_client::{
    Driver, HttpDriverBuilder, LocationStrategy,
    messages::{ExecuteCmd, NewSessionCmd},
};

fn main() -> Result<(), Box<dyn Error>> {
    // Run servoshell.
    Command::new("/path/to/servo")
        .args(["--webdriver", "about:blank"])
        .spawn()?;

    let driver = HttpDriverBuilder::default()
        .url("http://127.0.0.1:7000")
        .build()?;
    let mut params = NewSessionCmd::default();

    // Remove the unsupported `goog:chromeOptions` capability, which Servo rejects
    // with a “Session not created due to invalid capabilities” error.
    params.reset_always_match();

    // Wait for the WebDriver server to start.
    loop {
        sleep(Duration::from_millis(250));
        if let Ok(stream) = TcpStream::connect("127.0.0.1:7000") {
            stream.shutdown(Shutdown::Both)?;
            break;
        }
    }

    // Connect to the WebDriver server and control Servo.
    let session = driver.session(&params)?;
    session.go("https://shuppy.org/posts/tagged/diffie.html")?;

    let diffie = session.find_element(
        r"#thread-10000195\.md img",
        LocationStrategy::Css,
    )?;
    diffie.click()?;

    sleep(Duration::from_secs(1));
    session.execute(ExecuteCmd {
        script: "document.body.innerHTML = '<h1>Hello from WebDriver!</h1>' +
            document.body.innerHTML".to_owned(),
        args: vec![],
    })?;

    Ok(())
}
```
</figure>

<figure>
  <a href="{{ '/img/blog/2025-07-webdriver.png' | url }}"><img alt="Servo showing a page that was modified by a WebDriver client" src="{{ '/img/blog/2025-07-webdriver.png' | url }}"></a>
</figure>

## Donations

Thanks again for your generous support!
We are now receiving **4464 USD/month** (−2.8% over May) in recurring donations.
This helps cover the cost of our [self-hosted](https://ci0.servo.org) [CI](https://ci1.servo.org) [runners](https://ci2.servo.org) and one of our [latest Outreachy interns](https://www.outreachy.org/alums/2025-06/#:~:text=Servo)!

Servo is also on [thanks.dev](https://thanks.dev), and already **25 GitHub users** (same as May) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 4464 / 10000); padding-left: 0.5em;"><strong>4464</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 4464 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="4464" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
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

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
  const canvas = document.querySelector("#_stats");
  const labels = ["2022-01", "2022-02", "2022-03", "2022-04", "2022-05", "2022-06", "2022-07", "2022-08", "2022-09", "2022-10", "2022-11", "2022-12", "2023-01", "2023-02", "2023-03", "2023-04", "2023-05", "2023-06", "2023-07", "2023-08", "2023-09", "2023-10", "2023-11", "2023-12", "2024-01", "2024-02", "2024-03", "2024-04", "2024-05", "2024-06", "2024-07", "2024-08", "2024-09", "2024-10", "2024-11", "2024-12", "2025-01", "2025-02", "2025-03", "2025-04", "2025-05", "2025-06"];
  const values = [9, 3, 21, 78, 0, 0, 0, 24, 5, 15, 30, 30, 53, 70, 60, 64, 77, 73, 70, 167, 132, 120, 97, 111, 193, 167, 324, 185, 164, 158, 174, 273, 224, 341, 241, 230, 289, 304, 318, 314, 251, 349];
  function sliceWithZeros(xs, start, stop) {
    return xs.map((x,i) => start <= i && i < stop ? x : 0);
  }
  new Chart(canvas, {
    type: "bar",
    data: {
      labels: labels,
      // alternate between blue and green every six months
      datasets: [...Array(Math.floor(values.length / 6))].map((_,i) => ({
        data: sliceWithZeros(values, i * 6, i * 6 + 6),
        backgroundColor: i % 2 ? "#42be65" : "#1192e8",
      })),
    },
    options: {
      responsive: true,
      maintainAspectRatio: true,
      scales: {
        x: {
          stacked: true,
        },
        y: {
          beginAtZero: true,
          stacked: true,
        },
      },
      plugins: {
        legend: {
          position: "none",
        },
      },
    }
  });
</script>
