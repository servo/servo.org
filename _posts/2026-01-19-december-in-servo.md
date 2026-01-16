---
layout:     post
tags:       blog
title:      "December in Servo: and more!"
date:       2026-01-19
summary:    ao!! wrrrrao!!
categories:
---

<!--
- 2991.40/month opencollective
-->

**Servo 0.0.4** and our December nightly builds now support **multiple windows** (@mrobinson, #40927, #41235, #41144)!
This builds on features that landed in Servo’s embedding API [last month]({{ '/blog/2025/12/15/november-in-servo/' | url }}).

We’ve continued shipping the **[SubtleCrypto](https://w3c.github.io/webcrypto/) [API](https://wicg.github.io/webcrypto-modern-algos/)**, with full support for **ChaCha20-Poly1305**, **RSA-OAEP**, **RSA-PSS**, and **RSASSA-PKCS1-v1_5** (see below), plus **importKey() for ML-KEM** (@kkoyung, #41585) and several other improvements (@kkoyung, @PaulTreitel, #41180, #41395, #41428, #41442, #41472, #41544, #41563, #41587):

<figure style="overflow-x: scroll;">

| Algorithm | |
|---|---|
| <span style=white-space:nowrap>ChaCha20-Poly1305</span> | (@kkoyung, #40978, #41003, #41030) |
| <span style=white-space:nowrap>RSA-OAEP</span> | (@kkoyung, @TimvdLippe, @jdm, #41225, #41217, #41240, #41316) |
| <span style=white-space:nowrap>RSA-PSS</span> | (@kkoyung, @jdm, #41157, #41225, #41240, #41287) |
| <span style=white-space:nowrap>RSASSA-PKCS1-v1_5</span> | (@kkoyung, @jdm, #41172, #41225, #41240, #41267) |
</figure>

When using **servoshell** on Windows, you can now see `--help` and log output, as long as servoshell was started in a console.

Servo diagnostics options are now accessible in servoshell via the `SERVO_DIAGNOSTICS` environment variable (@atbrakhi, #41013), in addition to the usual `-Z` / `--debug=` arguments.

[**Servo’s devtools**](https://book.servo.org/contributing/devtools.html) now partially support the **Network** > **Security** tab (@jiang1997, #40567), allowing you to inspect some of the TLS details of your requests.
We’ve also made it **compatible with Firefox 145** (@eerii, #41087), and use fewer IPC resources (@mrobinson, #41161).

<figure>
    <img src="{{ '/img/blog/2026-01-devtools-security.png' | url }}" alt="this website in Servo’s devtools, showing that the main request used TLS 1.3, TLS13_AES_256_GCM_SHA384 cipher suite, and X25519MLKEM768 key exchange, with HSTS enabled and HPKP disabled">
</figure>

## Embedding API

Servo now has basic support for **HTTP proxies** (@Narfinger, #40941).
You can set the proxy URL in the `http_proxy` (@Narfinger, #41209) or `HTTP_PROXY` (@treeshateorcs, @yezhizhen, #41268) environment variables, or via `--pref network_http_proxy_uri`.

We now use the **system root certificates** by default (@Narfinger, @mrobinson, #40935, #41179), on most platforms.
If you don’t want to trust the system root certificates, you can instead continue to use Mozilla’s root certificates with `--pref network_use_webpki_roots`.
As always, you can also add your own root certificates via [`Opts`](https://doc.servo.org/servo/opts/struct.Opts.html)::[`certificate_path`](https://doc.servo.org/servo/opts/struct.Opts.html#structfield.certificate_path) (`--certificate-path=`).

We have a new [`SiteDataManager`](???) API for managing **localStorage**, **sessionStorage**, and **cookies** (@janvarga, #41236, #41255, #41378, #41523, #41528), and a new [`NetworkManager`](???) API for managing the **cache** (@janvarga, @mrobinson, #41255, #41474, #41386).
To clear the cache, call [`NetworkManager`](???)::[`clear_cache`](???), and to list cache entries, call [`NetworkManager`](???)::[`cache_entries`](???).

[**Simple dialogs**](https://html.spec.whatwg.org/multipage/#simple-dialogs) – that is alert(), confirm(), and prompt() – are now exposed to embedders via a new [`SimpleDialog`](https://doc.servo.org/servo/enum.SimpleDialog.html) type in [`EmbedderControl`](https://doc.servo.org/servo/webview_delegate/enum.EmbedderControl.html) (@mrobinson, @mukilan, #40982).
This new interface is harder to misuse, and no longer requires boilerplate for embedders that wish to [ignore simple dialogs](https://html.spec.whatwg.org/multipage/#cannot-show-simple-dialogs).

**Web console messages**, including messages from the [Console API](https://developer.mozilla.org/en-US/docs/Web/API/Console_API), are now accessible via [`ServoDelegate`](https://doc.servo.org/servo/trait.ServoDelegate.html)::[`show_console_message`](https://doc.servo.org/servo/trait.ServoDelegate.html#method.show_console_message) and [`WebViewDelegate`](https://doc.servo.org/servo/trait.WebViewDelegate.html)::[`show_console_message`](https://doc.servo.org/servo/trait.WebViewDelegate.html#method.show_console_message) (@atbrakhi, #41351).

[`Servo`](https://doc.servo.org/servo/struct.Servo.html), the main handle for controlling Servo, is now cloneable for sharing within the same thread (@mukilan, @mrobinson, #41010).
To shut down Servo, simply [drop](https://doc.rust-lang.org/std/mem/fn.drop.html) the last `Servo` handle or let it go out of scope.
`Servo`::`start_shutting_down` and `Servo`::`deinit` have been removed (@mukilan, @mrobinson, #41012).

Several interfaces have also been renamed:

- [`Servo`](https://doc.servo.org/servo/struct.Servo.html)::`clear_cookies` is now [`SiteDataManager`](???)::[`clear_cookies`](???) (@janvarga, #41236, #41255)
- `DebugOpts`::`disable_share_style_cache` is now [`Preferences`](https://doc.servo.org/servo/prefs/struct.Preferences.html)::[`layout_style_sharing_cache_enabled`](https://doc.servo.org/servo/prefs/struct.Preferences.html#structfield.layout_style_sharing_cache_enabled) (@atbrakhi, #40959)
- The rest of `DebugOpts` has been moved to [`DiagnosticsLogging`](https://doc.servo.org/servo/opts/struct.DiagnosticsLogging.html), and the options have been renamed (@atbrakhi, #40960)

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
