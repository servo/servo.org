---
layout:     post
tags:       blog
title:      "April in Servo: and more!"
date:       2026-05-29
summary:    ao!! wrrrrao!!
categories:
---

## Work in progress

[TODO: write about experimental feature changes]

All of the features above are enabled in servoshell’s experimental mode.

Servo can now build a very basic **accessibility tree** for web contents, under `--pref accessibility­_enabled` (@alice, @delan, @lukewarlow, #42338, #43558, #44437, #44438).
This includes text runs, plus nine other non-interactive accessibility roles (@alice, @delan, #44255).

## Embedding API

With this second monthly release of the Servo library, we have some quick notes about **API stability** and **semver compatibility**:

- **The [‘servo’](https://crates.io/crates/servo) package** follows [Cargo’s rules for semver compatibility](https://doc.rust-lang.org/1.88.0/cargo/reference/specifying-dependencies.html#default-requirements).
0.1.1 is compatible with version 0.1.0, but 0.2.0 is a breaking update.

- Until we integrate semver analysis into our release process, each monthly release will have a breaking version number, while non-breaking version numbers may be used for LTS updates.

- In general, **dependencies of ‘servo’**, like [‘servo-base’](https://crates.io/crates/servo-base) and [‘servo-script’](https://crates.io/crates/servo-script), **do not use semver**.
Any release may include breaking changes.

We’ve fixed a **build failure** affecting embedders with a **new or updated Cargo.lock** (@jschwe, #44093), and landed several other changes to help us with the Servo library release process (@jschwe, @mukilan, #43972, #44642, #43182, #43866, #44086, #43797).

Breaking changes:

- [`Web­View`](https://doc.servo.org/servo/struct.WebView.html)::[`animating`](https://doc.servo.org/servo/struct.WebView.html#method.animating) now takes `&self` instead of `self`, so you can call it without cloning the handle (@JavaDerg, #44253)

- [`Servo`](https://doc.servo.org/servo/struct.Servo.html)::[`site­_data­_manager`](https://doc.servo.org/servo/struct.Servo.html#method.site_data_manager) now returns `&SiteDataManager` instead of `Ref<'_, SiteDataManager>` (@sabbCodes, #44116)

- [`Web­View­Delegate`](https://doc.servo.org/servo/trait.WebViewDelegate.html)::`play­_gamepad­_haptic­_effect` and `stop­_gamepad­_haptic­_effect` have been removed (@mrobinson, #43895), but they have not worked since February 2026 – use [`Gamepad­Delegate`](https://doc.servo.org/servo/trait.GamepadDelegate.html) instead

You can now load a URL with **custom request headers** by calling [`Web­View`](https://doc.servo.org/servo/struct.WebView.html)::[`load­_request`](https://doc.servo.org/servo/struct.WebView.html#method.load_request) (@Narfinger, @longvatrong111, @mrobinson, #43338).

You can now **retrieve cookies asynchronously** by calling [`Site­Data­Manager`](https://doc.servo.org/servo/struct.SiteDataManager.html)::[`cookies­_for­_url­_async`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.cookies_for_url_async) (@longvatrong111, #43794).

The synchronous version of that method, [`Site­Data­Manager`](https://doc.servo.org/servo/struct.SiteDataManager.html)::[`cookies­_for­_url`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.cookies_for_url), was previously not callable because [`Cookie­Source`](https://doc.servo.org/servo/enum.CookieSource.html) was not exposed to the public API, but we’ve fixed that now (@TG199, #44124).

You can now **clear session cookies** without clearing [permanent cookies](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/Cookies#removal_defining_the_lifetime_of_a_cookie) by calling [`Site­Data­Manager`](https://doc.servo.org/servo/struct.SiteDataManager.html)::[`clear­_session­_cookies`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.clear_session_cookies) (@longvatrong111, #44166).

When **intercepting requests** with [`Servo­Delegate`](https://doc.servo.org/servo/trait.ServoDelegate.html):: and [`Web­View­Delegate`](https://doc.servo.org/servo/trait.WebViewDelegate.html)::[`load­_web­_resource`](https://doc.servo.org/servo/trait.WebViewDelegate.html#method.load_web_resource), we now include a [`destination`](https://doc.servo.org/servo/struct.WebResourceRequest.html#structfield.destination) and [`referrer­_url`](https://doc.servo.org/servo/struct.WebResourceRequest.html#structfield.referrer_url) in the [`Web­Resource­Request`](https://doc.servo.org/servo/struct.WebResourceRequest.html), which can be helpful if you’re implementing **ad blocking** (@webbeef, #44493).

You can configure Servo to **write all of its storage to a unique directory** for that session by enabling [`Opts`](https://doc.servo.org/servo/struct.Opts.html)::[`temporary­_storage`](https://doc.servo.org/servo/struct.Opts.html#structfield.temporary_storage) (@janvarga, #44433).
Note that these unique directories currently persist after Servo exits, so it’s an isolation feature, not a privacy feature.

[`Window­Rendering­Context`](https://doc.servo.org/servo/struct.WindowRenderingContext.html)::[`new`](https://doc.servo.org/servo/struct.WindowRenderingContext.html#method.new) and [`Software­Rendering­Context`](https://doc.servo.org/servo/struct.SoftwareRenderingContext.html)::[`new`](https://doc.servo.org/servo/struct.SoftwareRenderingContext.html#method.new) now return an error if the given `size` is less than 1x1 (@freyacodes, @mrobinson, #44011).

We’ve improved our API docs for [`Web­View`](https://doc.servo.org/servo/struct.WebView.html), [`Web­View­Builder`](https://doc.servo.org/servo/struct.WebViewBuilder.html), [`Web­View­Delegate`](https://doc.servo.org/servo/trait.WebViewDelegate.html), [`ServoDelegate`](https://doc.servo.org/servo/trait.ServoDelegate.html), [`Prompt­Dialog`](https://doc.servo.org/servo/struct.PromptDialog.html), [`Web­Resource­Load`](https://doc.servo.org/servo/struct.WebResourceLoad.html), [`Web­Xr­Registry`](https://doc.servo.org/servo/webxr/trait.WebXrRegistry.html), [`Preferences`](https://doc.servo.org/servo/struct.Preferences.html), and servoshell’s [`EXPERIMENTAL­_PREFS`](https://doc.servo.org/servoshell/prefs/static.EXPERIMENTAL_PREFS.html) (@simonwuelker, @TG199, @sabbCodes, @jdm, @rovertrack, #43892, #43787, #44171, #43947).

We’ve also improved our API docs for [`Opts`](https://doc.servo.org/servo/struct.Opts.html), [`Output­Options`](https://doc.servo.org/servo/enum.OutputOptions.html), [`Diagnostics­Logging`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html), [`Pref­Value`](https://doc.servo.org/servo/enum.PrefValue.html), [`servo`](https://doc.servo.org/servo/index.html)::[`opts`](https://doc.servo.org/servo/opts/index.html), and [`servo­_config`](https://doc.servo.org/servo_config/index.html) (@mukilan, #43802).

## Performance and stability

We’ve continued our long-running effort to **use the Rust type system** to make certain kinds of dynamic borrow failures impossible (@sagudev, @TimvdLippe, @Narfinger, @elomscansio, @Gae24, @rovertrack, @yezhizhen, @nodelpit, #43174, #43524, #43928, #43943, #43942, #43944, #43946, #43952, #43975, #44018, #44175, #44241, #44368, #44406, #44441, #44422, #44475, #44478, #44484, #44476, #44490, #44477, #44494, #44497, #44498, #44495, #44505, #44506, #44507, #44508, #44509, #44510, #44512, #44482, #44527, #44528, #44531, #44534, #44542, #44533, #44543, #44553, #44547, #44563, #44562, #44565, #44558, #44583, #44606, #44605, #44608, #44602, #44584, #44620, #44590, #44254, #44628, #44629, #44638, #44626).

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
