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

**servoshell** now supports **multiple windows** (@mrobinson, #40927, #41235)!
This builds on features that landed in Servo’s embedding API [last month]({{ '/blog/2025/12/15/november-in-servo/' | url }}), and we’ve also fixed a memory leak when closing windows (@mrobinson, #41144).

When using **servoshell** on Windows, you can now see `--help` and log output, as long as servoshell was started in a console.

Servo diagnostics options are now accessible in servoshell via the `SERVO_DIAGNOSTICS` environment variable (@atbrakhi, #41013), in addition to the usual `-Z` / `--debug=` arguments.

## Embedding API

Servo now has basic support for **HTTP proxies** (@Narfinger, #40941).
You can set the proxy URL in the `http_proxy` (@Narfinger, #41209) or `HTTP_PROXY` (@treeshateorcs, @yezhizhen, #41268) environment variables, or via `--pref network_http_proxy_uri`.

We now use the **system root certificates** by default (@Narfinger, @mrobinson, #40935, #41179), on most platforms.
If you don’t want to trust the system root certificates, you can instead continue to use Mozilla’s root certificates with `--pref network_use_webpki_roots`.
As always, you can also add your own root certificates via [`Opts`](https://doc.servo.org/servo/opts/struct.Opts.html)::[`certificate_path`](https://doc.servo.org/servo/opts/struct.Opts.html#structfield.certificate_path) (`--certificate-path=`).

[`Servo`](https://doc.servo.org/servo/struct.Servo.html), the main handle for controlling Servo, is now cloneable for sharing within the same thread (@mukilan, @mrobinson, #41010).

Several interfaces have also been renamed:

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
