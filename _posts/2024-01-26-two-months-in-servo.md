---
layout:     post
tags:       blog
title:      "Two months in Servo: and more!"
date:       2024-01-26
summary:    ao!! wrrrrao!!
categories:
---

Servo has had some exciting changes land in our nightly builds over the last month:

- as of 2023-12-27, the ‘text-align-last’ property is now supported (@mrobinson, #30905)
- as of 2023-12-27, ‘text-align: justify’ is now supported (@mrobinson, #30807, #30866)
- as of 2024-01-09, ‘line-height’ and ‘vertical-align’ are now moderately supported (@mrobinson, #30902)

We’ve started working on support for **sticky positioning** and **tables** in the new layout engine, with some very early sticky positioning code landing in 2023-11-30 (@mrobinson, #30686), the CSS tables tests now enabled (@mrobinson, #31131), and rudimentary table layout landing in 2024-01-20 under the `layout.tables.enabled` pref (@mrobinson, @Loirooriol, @Manishearth, #30799, #30868, #31121).

Geometry in our new layout engine is now being migrated from floating-point coordinates (`f32`) to **fixed-point coordinates** (`i32` × 1/60) (@atbrakhi, #30825, #30894, #31135), similar to other engines like WebKit and Blink.
While floating-point geometry was thought to be better for transformation-heavy content like SVG, the fact that larger values are less precise than smaller values causes a variety of rendering problems and test failures (#29819).

As a result of these changes, we’ve made big strides in our WPT pass rates:

- **CSS2 floats** (+3.3pp to 84.9%) and **floats-clear** (+5.6pp to 78.9%) continue to surge
- we now surpass legacy layout in the **CSS2 linebox** tests (**61.1% → 87.9%**, legacy 86.4%)
- we now surpass legacy layout in the **css-flexbox** tests (49.5% → 52.7%, legacy 52.2%)
- we’ve closed 76% of the gap in **key CSS2 tests** (79.2% → 82.2%, legacy 83.1%)

## Updates, servoshell, and stability

**GStreamer** has been updated from 0.15 to 0.21 (@mrobinson, #30750), fixing long-standing breakage of video playback.
**WebGPU** has been updated from 0.17 to 0.18 (@sagudev, #30926, #30954), and **ANGLE** has been updated from [April 2019](https://chromium.googlesource.com/angle/angle/+/refs/heads/chromium/3729) to [August 2023](https://chromium.googlesource.com/angle/angle/+/refs/heads/chromium/5359) (@sagudev, #30546).

Servo’s example browser now has **Back and Forward buttons** (@atbrakhi, #30805), and no longer shows the incorrect location when navigation takes a long time (@atbrakhi, #30518).

Many stability improvements have landed, including fixes for a crash in inline layout (@atbrakhi, #30897), three WebGPU-related crashes (@lucasMontenegro, @gterzian, @Taym95, #30888, #30989, #31002), a crash in the PerformanceResourceTiming API (@delan, #31063), and several crashes due to script runtimes being dropped in the wrong order (@gterzian, #30896).

## CI, code health, and dev changes

The intermittent macOS build failures on CI should now be fixed (@mrobinson, #30975).

The long-term effort to simplify how Servo is built continues (@mrobinson, #31075), and we’ve also replaced the `time` crate with `chrono` and `std::time` in much of Servo (@Taym95, @augustebaum, #30927, #31020, #30639, #31079).
We have also started migrating our DOM bindings to use typed arrays where possible (@gterzian, #30990, #31077, #31087, #31076, #31106), as part of an effort to **reduce our unsafe code surface** (#30889, #30862).

Several crates have been moved into [our main repo](https://github.com/servo/servo):

* `hyper_serde` ([servo/hyper_serde](https://github.com/servo/hyper_serde)) was moved to `components/hyper_serde` (@mrobinson, #30803)
* `device` ([servo/devices](https://github.com/servo/devices)) was merged into `components/bluetooth` (@mrobinson, #30974)
* `blurmac` ([servo/devices](https://github.com/servo/devices)) was moved to `third_party/blurmac` (@mrobinson, #30974)

We’ve also made some dev changes:

- the default branch in [our main repo](https://github.com/servo/servo) is now `main` (@mrobinson, @atouchet, 23add0c1e5c9c, #30877)
- we now target **Rust 1.74** stable, marking the first time ever we have built without unstable features (@mrobinson, #30831)
- we now use Python’s built-in venv feature, so you no longer need to install virtualenv (@frewsxcv, #30377)

### Linux build issues

Several people have reported problems building Servo on newer Linux distro versions, particularly [with clang 15](https://github.com/servo/servo/issues/31059) or [with clang 16](https://github.com/servo/servo/issues/30587).
While we’re still working on fixing the underlying issues, there are some workarounds.
If your distro lets you install older versions of clang with a package like `clang-14`, you can tell Servo to use it with:

```
export CC=/usr/bin/clang-14
export CXX=/usr/bin/clang++-14
```

Alternatively you can try our new Nix-based dev environment, which should now work on any Linux distro (@delan, #31001).
[Nix](https://nixos.org/manual/nix/stable/) is a package manager with some unusual benefits.
Servo can use Nix to find the correct versions of all of its compilers and build dependencies without needing you to install them or run `mach bootstrap`.
All you need to do is install Nix, and `export MACH_USE_NIX=` to your environment.
[See the wiki](https://github.com/servo/servo/wiki/Building#nix-on-other-distros) for more details!

<!--
    - layout
        - DONE sticky
        - DONE tables
        - inline
        - DONE Au
        - DONE wpt
    - xtermjs
    - updates
        - DONE angle
        - DONE webgpu
    - DONE minibrowser
    - DONE stability
    - ci
        - macOS
        - android
    - health
    - dev
        - DONE nix
        - DONE rust stable
-->

<!--
    based on
    - wpt dashboard
        prev	cur	legacy		delta	gap	ratio		
        79.2	82.2	83.1		3.0	3.9	76.9%		focus
        81.6	84.9	53.5		3.3	-28.1	-11.7%		floats
        73.3	78.9	68.2		5.6	-5.1	-109.8%		floats-clear
        61.1	87.9	86.4		26.8	25.3	105.9%		linebox !!
        78.1	78.8	87.5		0.7	9.4	7.4%		normal-flow
        87.6	88.2	81.1		0.6	-6.5	-9.2%		positioning
        60.5	61.8	60.1		1.3	-0.4	-325.0%		cssom
        44.6	48.6	44.2		4.0	-0.4	-1000.0%		css-position
        49.5	52.7	52.2		3.2	2.7	118.5%		css-flexbox !!
        8.2	30.8	36.8		22.6	28.6	79.0%		tables, css-tables
        39.9	44.2	35.6		4.3	-4.3	-100.0%		/css/csstext
        60.3	62.5	63.5		2.2	3.2	68.8%		/css
    - commits in nightlies 2023-11-28 through 2023-11-27
        >>> 2023-11-28T11:16:56Z
        >>> 2023-11-29T06:07:54Z
        >>> 2023-11-30T05:57:47Z
            +++ a05598402e8b21948e1ee9567dca76a491bd266e	https://github.com/servo/servo/pull/30686	Add initial support for sticky positioning for non-legacy layout (#30686)
        >>> 2023-12-01T05:53:38Z
        +++ f1c291853e331329271efba52a03ba5049e8358b	https://github.com/servo/servo/pull/30740	Stop sending " " to linebreaker for replaced content (#30740)
        >>> 2023-12-02T06:08:38Z
            +++ 604979e367faa6aa09805e8fa0223b8883ea009d	https://github.com/servo/servo/pull/30508	Replace script_plugins with a clippy like rustc driver (named crown) (#30508)
        +++ cdbd60fe53f64f08efcf9715c4655e38cd1d7ddd	https://github.com/servo/servo/pull/30800	Extend character-based soft wrap prevention to before atomics (#30800)
        >>> 2023-12-03T05:57:33Z
        >>> 2023-12-04T06:02:05Z
        >>> 2023-12-11T05:28:33Z
        warning: not reachable from default branch: 2668a0a43a19643922409e623880558dedfb4b98
            +++ e2743c61414f5d9cc0cd2d41dcc5c1d29f0b2d17	https://github.com/servo/servo/pull/30546	Bump mozangle to 0.5.0 (#30546)
            +++ 117d59d393cf7926063e8723934fec97fd61d713	https://github.com/servo/servo/pull/30377	Replace virtualenv with Python's built-in venv (#30377)
            +++ 7e82c5c957821f1328484e90becec0cfb5572938	https://github.com/servo/servo/pull/30831	Compile Servo with the latest version of rust stable (#30831)
        +++ bbc35b682f0fb926364e5800d20f77bba944a020	https://github.com/servo/servo/pull/30830	Remove thinlto servobuild.config option (#30830)
        +++ e7c412e7cae750c0eeb6374e14bbf8442eb2cacd	https://github.com/servo/servo/pull/30829	Remove clean_rmeta from crown test (#30829)
            +++ a326a60c1646cde1a8b34b70d7f632b341644d0a	https://github.com/servo/servo/pull/30805	Minibrowser: Add Back and Forward navigation (#30805)
        +++ 8ded1072ceda45e8f8b7716f5779c63996d7e653	https://github.com/servo/servo/pull/30823	Re-use the TextMetrics data structure in the Layout 2020 fragment tree (#30823)
            +++ f0b41623286a010cb021cd2debfa6b1be3b36b5d	https://github.com/servo/servo/pull/30799	Add initial support for table box tree construction (#30799)
            +++ 63701b338cd807dc237be4f3f0771a1fff933f09	https://github.com/servo/servo/pull/30820	Fix the upload docs action after renaming `master` to `main` (#30820)
            +++ ea8cd36f0d0c4485b0872774661de34c439d35c0	https://github.com/servo/servo/pull/30518	Fix the location url that reverts to the old value while loading (#30518)
            +++ 23add0c1e5c9cbdf0301b891d265e363d049532b	Rename the `master` branch to `main`
        >>> 2023-12-12T06:15:50Z
        +++ 1105eb66e9ce43f0f2ea6c6b5cea5e72394eee3f	https://github.com/servo/servo/pull/30848	Use os version in taplo cache-key & setuptools 65 in py3.8 (#30848)
            +++ 9f7afe595a11d32859b45bf3bf2fd36ee5ae46e7	https://github.com/servo/servo/pull/30836	Update mozjs (#30836)
            +++ a315bec4ed73c7c0ef89f120c8f52e2609f9028b	https://github.com/servo/servo/pull/30825	Use app units in replaced elements (#30825)
        >>> 2023-12-13T06:06:44Z
            +++ 17f3c45d4ff597dc1e179d89784bb5f57b4c03d7	https://github.com/servo/servo/pull/30767	Add initial support for offscreen rendering (#30767)
            +++ 97e6c72f5767e1cd754c82317a21aa222c5d968b	https://github.com/servo/servo/pull/30840	Add multiview feature flag in compositing and constellation (#30840)
            +++ 8a226fdb1975ae1df8d1a673eb3dca9f2bb771aa	https://github.com/servo/servo/pull/30841	constellation: notify embedder when events are hit-tested to browsers (#30841)
        >>> 2023-12-14T06:16:19Z
        >>> 2023-12-27T06:06:58Z
            +++ 7973cb64586d94a6987562fe6f180ac29ef0e971	https://github.com/servo/servo/pull/30926	Update wgpu to 0.18.1 (#30926)
        +++ 1f0f50b22bb43e965febf31f5a436113f2958725	https://github.com/servo/servo/pull/30912	Customizable wpt options and profile in workflows (#30912)
            +++ 81f5157522ae320068515571a371aa3b72de0cfa	https://github.com/servo/servo/pull/30868	Add support for table fixups (#30868)
            +++ 709d00583fb28fb668f10eab1f2f16f07c331078	https://github.com/servo/servo/pull/30866	layout: Make all word separators justification opportunities (#30866)
            +++ 74798c4b7bf173fc99b96e219c6c2cab136d5c4c	https://github.com/servo/servo/pull/30905	layout: Add support for `text-align-last` (#30905)
            +++ a9bf29cf8aede9771a16922c98cc933ce84b2ccc	https://github.com/servo/servo/pull/30897	Fix crash caused by arithmetic underflow in layout2020 (#30897)
        +++ abb017b8543efea54b732efa2846b25c949985c9	https://github.com/servo/servo/pull/30898	script: Allow moving back to non-quirks mode (#30898)
            +++ 256ab5353b9145dbda103ec48cf4d10f32f6912a	https://github.com/servo/servo/pull/30888	These changes fix #30843 (#30888) Fix a crash in WebGPU when WebGPU is disabled
            +++ e4aed3d06a8a1ef6e7af142f02be95ce2a3065cb	https://github.com/servo/servo/pull/30877	Update branch name to main (#30877)
            +++ ccf0b739dfca312a65002c443fb09537aa27225b	https://github.com/servo/servo/pull/30807	Add basic support for `text-align: justify` (#30807)
            +++ 569c4a8823369678870e1b5f50a2c484d32fb687	https://github.com/servo/servo/pull/30803	Integrate hyper_serde into Servo source (#30803)
        >>> 2023-12-28T06:04:45Z
        >>> 2023-12-29T06:03:36Z
            +++ e79171ec01199ba7100c0ad90576a6ec5705d80c	https://github.com/servo/servo/pull/30954	Update WebGPU CTS (#30954)
        >>> 2023-12-30T06:12:29Z
        >>> 2023-12-31T06:14:24Z
        >>> 2024-01-01T06:08:41Z
        >>> 2024-01-02T06:15:51Z
        +++ 7964a4f582d5697e0ea55203dd4ec25d69dbed97	https://github.com/servo/servo/pull/30963	Unfork and upgrade jemallocator (#30963)
        >>> 2024-01-03T06:11:55Z
            +++ 3353db71d232ed3e6108950e21a6dba6360e6d57	https://github.com/servo/servo/pull/30975	Fail gracefully when DMG smoketest fails (#30975)
        >>> 2024-01-04T06:14:15Z
            +++ f44ff83c20b82d1f3272d9389563e30f0d3c9700	https://github.com/servo/servo/pull/30989	WebGPU: always send exit message to script before exiting (#30989)
            +++ 65cbc95d38819e9b3d5870953015a9e7963a0ace	https://github.com/servo/servo/pull/30927	Replace time with std::time in components/devtools (#30927)
        +++ 0dbba9b6ffe0507011337c27c2709f6c4cebe1c0	https://github.com/servo/servo/pull/30973	Download Windows GStreamer dependencies from GitHub (#30973)
        >>> 2024-01-05T06:16:06Z
        +++ c219204084b8f8a747ebd37ec75472c1b7e97411	https://github.com/servo/servo/pull/30987	Fix crown on NixOS (#30987)
            +++ 90a9300f698aa266db47b336f3fcd7d6680b4d65	https://github.com/servo/servo/pull/30896	Script: ensure child JS runtimes are dropped before parent (#30896)
        >>> 2024-01-08T06:07:00Z
        +++ 79a0f76d26d43c7f6e38a60fbe2ec6bed1510543	https://github.com/servo/servo/pull/31019	Fix the build on Ubuntu 20.04 (#31019)
        +++ 9a1d7aabd71fe82c9420abdc33a6a9ba0f8eac52	https://github.com/servo/servo/pull/31003	bootstrap: Adding more output when installing dependencies (#31003)
            +++ 7fa4ea9740edccc93672d8cc428f6e9d4575a036	https://github.com/servo/servo/pull/30750	Upgrade media / GStreamer / GLib (#30750) 0.15 -> 0.21
        >>> 2024-01-09T06:16:45Z
            +++ aa073c3dcaffe30c7a6e272ba4ef5121c090f1bf	https://github.com/servo/servo/pull/30902	layout: Implement support for `line-height` and `vertical-align` (#30902)
        >>> 2024-01-10T06:16:53Z
            +++ 94a3c49a807626ecddb7f062e6856e9e0d66baca	https://github.com/servo/servo/pull/31001	Allow building with Nix on Linux distros other than NixOS (#31001)
            +++ 6a804cd775e3976103269ac54ae997a3accc8618	https://github.com/servo/servo/pull/30974	Integrate the `devices` respository (#30974)
            +++ fddc4a430fca591152c69f0793ab946dcdc81617	https://github.com/servo/servo/pull/31002	Fix failed request for adapter when not available (#31002)
        >>> 2024-01-11T06:08:02Z
            +++ 92196d985dceb0ca708b097e2a847b255d8387c8	https://github.com/servo/servo/pull/31020	Replace time with std::time in components/metrics & components/shared (#31020)
        +++ 17ffbbdd11b47d577bdfe4318c36bcb5de365b18	https://github.com/servo/servo/pull/31052	Nix: bump nixpkgs to nixos-23.05 (except gnumake) (#31052)
        >>> 2024-01-12T06:07:36Z
            +++ e145c512347807cdf44537fdfa83f2a5dda05b5a	https://github.com/servo/servo/pull/30990	WebIDL: use FLoat32Array  (#30990)
            +++ 90f70e3408e1d4b3f378e50f9f051cb00c77c446	https://github.com/servo/servo/pull/31063	Fix underflow in PerformanceResourceTiming API (#31063)
        +++ 1f1cf1499d1e249c58fb3ac8986e62cf0d796497	https://github.com/servo/servo/pull/31055	Nix: bump nixpkgs to nixos-unstable (#31055)
        >>> 2024-01-13T06:04:19Z
            +++ abb54f7832682bad1545b307a545a7ba977ef209	https://github.com/servo/servo/pull/31075	build: Don't add the `neon` feature for arm and aarch64 (#31075)
        >>> 2024-01-14T06:05:53Z
        >>> 2024-01-15T06:10:05Z
        >>> 2024-01-16T06:18:19Z
            +++ efa38c67fe6bdec751739bb3a0a6d159f2b695c8	https://github.com/servo/servo/pull/31091	ci: Remove the nightly-rust workflow (#31091)
        +++ 0d240b8713fb5cd933d348e668ab02a53859282b	https://github.com/servo/servo/pull/31088	deps: Raise the Python requirement to 3.10 (#31088)
        >>> 2024-01-17T06:09:03Z
            +++ 8c53a8c745ab2a5b660d6f170e74b4fecca189c1	https://github.com/servo/servo/pull/31077	use FLoat32Array in XRView (#31077)
            +++ 9654363c187ee549b82bca8c4e3098e4c20c7287	https://github.com/servo/servo/pull/30639	script: Start replacing `time` with `std::time` and `chrono`  (#30639)
        >>> 2024-01-18T06:17:19Z
            +++ 580062228bb083ccdc2144a43491bc4f916c57ad	https://github.com/servo/servo/pull/31079	Replace time with std::time in components/net (#31079)
        +++ d86e713a9cb5be2555d63bd477d47d440fa8c832	https://github.com/servo/servo/pull/31092	build: Clean up post-build copy of Windows DLLs (#31092)
            +++ f76982e2e7f411e2e2fd8e6dbfe92a080acefc54	https://github.com/servo/servo/pull/31087	script: Use FLoat32Array in XRRay (#31087)
            +++ 6a7b450478f69d9d83b0936a0ab28ac2d94761d4	https://github.com/servo/servo/pull/31076	use FLoat32Array in XRRigidTransform (#31076)
        >>> 2024-01-19T06:05:45Z
            +++ 8e5f28839cde6b9ee5cd7cb4f8c27ff0ae10a86c	https://github.com/servo/servo/pull/31120	Revert "Replace time with std::time in components/net (#31079)" (#31120)
        >>> 2024-01-20T06:04:40Z
            +++ fc31e69f79a68408fdd376a52942587a8fca9170	https://github.com/servo/servo/pull/31121	layout: Add *very* basic support for table layout (#31121)
            +++ 3d520f266800e0035c429ddf2a3b45922f502ebd	https://github.com/servo/servo/pull/30894	Use App units in flow layout (#30894)
            +++ 734eb469549db22b070d86bb13a8bd167d5d1e8e	https://github.com/servo/servo/pull/31131	wpt: Unskip the `css-tables suite (#31131)
            +++ 9d2c102fa0cc034b2bde51d27cd6c0e7f3cafa30	https://github.com/servo/servo/pull/31106	Use FLoat32Array in GamepadPose (#31106)
        >>> 2024-01-21T06:06:07Z
        >>> 2024-01-22T06:08:36Z
        >>> 2024-01-23T06:22:19Z
        +++ d7de206dbd459e8c8bf121f73755d12569c6cc55	https://github.com/servo/servo/pull/31086	Preliminary Android build support (#31086)
        >>> 2024-01-24T06:17:36Z
        +++ 5d7e2a823985a8314b10dc363eb191c0d4330424	https://github.com/servo/servo/pull/31123	Implement Event.composedPath (#31123)
        +++ 54fb381a0a4c070bac75e9f602bf905fa101194d	https://github.com/servo/servo/pull/31133	layout: Convert layout internal display to inline for replaced elements (#31133)
        +++ 7de0486e2e67a17e4cdcc881c7f3bd3fd1a66fb6	https://github.com/servo/servo/pull/31161	layout: Count word separators as justification opportunities when trimming whitespace (#31161)
        +++ dc2df7b02767004f0900055d985ecfc6cd874c9a	https://github.com/servo/servo/pull/31148	build: Add support for Visual Studio 2022 and VC143 DLLs (#31148)
            +++ 45af1198aa05882d6433642c45d1cd329f145782	https://github.com/servo/servo/pull/31135	Layout: use `Au` in `ContentSizes`  (#31135)
        >>> 2024-01-25T06:07:31Z
        +++ eb95703325aeb48d5f56a8da5b258bad608dd632	https://github.com/servo/servo/pull/30842	constellation: focusing and closing webviews (#30842)
-->

<!--
$ tools/list-commits-by-nightly.sh ~/code/servo 2>&1 | tee /dev/stderr | xclip -sel clip
From https://github.com/servo/servo
 * branch                  HEAD       -> FETCH_HEAD
>>> 2023-11-28T11:16:56Z
    81a38bde8cc0359efc32f2661fa5e4db33b38446	https://github.com/servo/servo/pull/30792	ci: do not set LIBCLANG_PATH for nightly build (#30792)
    0b2456b1eb8d251dd2f997d1e1958f23f5e4b777	https://github.com/servo/servo/pull/30791	build(deps): bump proc-macro2 from 1.0.69 to 1.0.70 (#30791)
    3a036a639e6cb5e4c0546de3adfde00e0b3e8d15	https://github.com/servo/servo/pull/30790	build(deps): bump js-sys from 0.3.65 to 0.3.66 (#30790)
    cccf8c2ffeeb3015ee5c3312bcf34e2caf48742f	https://github.com/servo/servo/pull/30789	build(deps): bump wasm-bindgen from 0.2.88 to 0.2.89 (#30789)
    139df1c73bba43a3fc6032bfc0f5518e9d87e856	https://github.com/servo/servo/pull/30783	Sync WPT with upstream (26-11-2023) (#30783)
    76401823f272754ba851a6fcbf0e4a63d074824e	https://github.com/servo/servo/pull/30775	build(deps): bump url from 2.4.1 to 2.5.0 (#30775)
    d10688b5ef3dceb2b8a0e5ca4e089cba12bca0cd	https://github.com/servo/servo/pull/30787	ci: use ubuntu 20.04 for nightly builds on linux (#30787)
>>> 2023-11-29T06:07:54Z
    bab2b58216f8845b3ecc8e0eaeba3b7175034f64	https://github.com/servo/servo/pull/30794	build(deps): bump errno from 0.3.7 to 0.3.8 (#30794)
    8f3491393f90678db6c65cc02ffe6c2403ece5ac	https://github.com/servo/servo/pull/30793	build(deps): bump web-sys from 0.3.65 to 0.3.66 (#30793)
>>> 2023-11-30T05:57:47Z
    53b0fa827d37f3f7127470371d12d2a1c917e396	https://github.com/servo/servo/pull/30796	Fix build script error.because starting with Python 3.9, the util module was moved from importlib to a separate top-level module called importlib.util. Therefore, if you are using Python 3.9 or later and you receive an AttributeError stating that module 'importlib' has no attribute 'util', it is likely due to a compatibility issue with your code. You can fix this issue by updating your code to import importlib.util directly (#30796)
    dd9366bfe7a76b3bee953632fa76b95d55618e3c	https://github.com/servo/servo/pull/30798	build(deps): bump ring from 0.17.5 to 0.17.6 (#30798)
+++ a05598402e8b21948e1ee9567dca76a491bd266e	https://github.com/servo/servo/pull/30686	Add initial support for sticky positioning for non-legacy layout (#30686)
>>> 2023-12-01T05:53:38Z
    b125bb6b6aa095fc287f279a13e6ff423deb3b0f	https://github.com/servo/servo/pull/30801	build(deps): bump core-foundation from 0.9.3 to 0.9.4 (#30801)
+++ f1c291853e331329271efba52a03ba5049e8358b	https://github.com/servo/servo/pull/30740	Stop sending " " to linebreaker for replaced content (#30740)
>>> 2023-12-02T06:08:38Z
    7bcb25c85c98c367c6423ebc0fed964dd08cad56	https://github.com/servo/servo/pull/30812	build(deps): bump slotmap from 1.0.6 to 1.0.7 (#30812)
    d837eb905518d0849f16a39ba343bdaffef1732f	https://github.com/servo/servo/pull/30809	build(deps): bump linux-raw-sys from 0.4.11 to 0.4.12 (#30809)
    49e8517b3a35009abedd10d08cc8f8faadd6e029	https://github.com/servo/servo/pull/30810	build(deps): bump core-graphics-types from 0.1.2 to 0.1.3 (#30810)
    20a122c2f6a1a97cf39938bc90b0d91cc198f0c7	https://github.com/servo/servo/pull/30804	Use git2 version of vergen (#30804)
+++ 604979e367faa6aa09805e8fa0223b8883ea009d	https://github.com/servo/servo/pull/30508	Replace script_plugins with a clippy like rustc driver (named crown) (#30508)
    20a73721de2f1a8a0b29905617783148bd3cfaff	https://github.com/servo/servo/pull/30806	Remove a comment that is no longer valid (#30806)
+++ cdbd60fe53f64f08efcf9715c4655e38cd1d7ddd	https://github.com/servo/servo/pull/30800	Extend character-based soft wrap prevention to before atomics (#30800)
>>> 2023-12-03T05:57:33Z
>>> 2023-12-04T06:02:05Z
>>> 2023-12-11T05:28:33Z
warning: not reachable from default branch: 2668a0a43a19643922409e623880558dedfb4b98
    2668a0a43a19643922409e623880558dedfb4b98	Use os version in taplo cache-key
    6bbd510e852c8ce6d0e9147aaa4ab486109711af	Python 3.10 on 20.04 runner
    589f2915237b39cdd6fd222d775737cb10f7b9b0	https://github.com/servo/servo/pull/30844	build(deps): bump rustix from 0.38.26 to 0.38.27 (#30844)
    77e04bc13ed23859f3c1ff2de19a4ec2756c9c88	https://github.com/servo/servo/pull/30839	build(deps): bump once_cell from 1.18.0 to 1.19.0 (#30839)
    3a5634a20c1926acd51e3cfb20dd9e6c36c9cf60	https://github.com/servo/servo/pull/30846	Update linux.yml (#30846)
    a9b64256f4b0df14d0e6ac071b51905f2a3e8ffc	https://github.com/servo/servo/pull/30845	build(deps): bump rustls from 0.21.9 to 0.21.10 (#30845)
+++ e2743c61414f5d9cc0cd2d41dcc5c1d29f0b2d17	https://github.com/servo/servo/pull/30546	Bump mozangle to 0.5.0 (#30546)
    6282c4d1476655f6822322935059a61fa7c83663	https://github.com/servo/servo/pull/30838	build(deps): bump try-lock from 0.2.4 to 0.2.5 (#30838)
    3310199cd0e5dd279ea4fb3896aedfe052d63522	https://github.com/servo/servo/pull/30837	build(deps): bump unicode-bidi from 0.3.13 to 0.3.14 (#30837)
+++ 117d59d393cf7926063e8723934fec97fd61d713	https://github.com/servo/servo/pull/30377	Replace virtualenv with Python's built-in venv (#30377)
    914fe64fc72462f3af743d9d1ff26781d9fecec3	https://github.com/servo/servo/pull/30814	Sync WPT with upstream (03-12-2023) (#30814)
+++ 7e82c5c957821f1328484e90becec0cfb5572938	https://github.com/servo/servo/pull/30831	Compile Servo with the latest version of rust stable (#30831)
    9c443cf2c1bbcee1f465cc76b7bf1ab551b85877	https://github.com/servo/servo/pull/30834	build(deps): bump ring from 0.17.6 to 0.17.7 (#30834)
    a92cf99cd272d0cc90aeb40938c4c37cd9928427	https://github.com/servo/servo/pull/30833	build(deps): bump filetime from 0.2.22 to 0.2.23 (#30833)
    d50954a9696b2b55501c76a006db8c266c64a92c	https://github.com/servo/servo/pull/30832	build(deps): bump mio from 0.8.9 to 0.8.10 (#30832)
+++ bbc35b682f0fb926364e5800d20f77bba944a020	https://github.com/servo/servo/pull/30830	Remove thinlto servobuild.config option (#30830)
+++ e7c412e7cae750c0eeb6374e14bbf8442eb2cacd	https://github.com/servo/servo/pull/30829	Remove clean_rmeta from crown test (#30829)
    9028c903325d5a37896f87a9667ebe81009de5d1	https://github.com/servo/servo/pull/30824	Generalize LengthPercentageOrAuto impl to Generic Type (#30824)
+++ a326a60c1646cde1a8b34b70d7f632b341644d0a	https://github.com/servo/servo/pull/30805	Minibrowser: Add Back and Forward navigation (#30805)
+++ 8ded1072ceda45e8f8b7716f5779c63996d7e653	https://github.com/servo/servo/pull/30823	Re-use the TextMetrics data structure in the Layout 2020 fragment tree (#30823)
+++ f0b41623286a010cb021cd2debfa6b1be3b36b5d	https://github.com/servo/servo/pull/30799	Add initial support for table box tree construction (#30799)
+++ 63701b338cd807dc237be4f3f0771a1fff933f09	https://github.com/servo/servo/pull/30820	Fix the upload docs action after renaming `master` to `main` (#30820)
    396af7c5633118b415d99b08a7b8a6099856fe9b	https://github.com/servo/servo/pull/30817	build(deps): bump rustix from 0.38.25 to 0.38.26 (#30817)
    16c402ef48dd5342ad68112a8373a9c2b0818ca3	https://github.com/servo/servo/pull/30819	build(deps): bump thin-vec from 0.2.12 to 0.2.13 (#30819)
    c909c64378125a33eab22236dfee83ee26b7a4b0	https://github.com/servo/servo/pull/30784	Fix typing issues in flex layout (#30784)
+++ ea8cd36f0d0c4485b0872774661de34c439d35c0	https://github.com/servo/servo/pull/30518	Fix the location url that reverts to the old value while loading (#30518)
+++ 23add0c1e5c9cbdf0301b891d265e363d049532b	Rename the `master` branch to `main`
>>> 2023-12-12T06:15:50Z
    48a95b2471c590a0ee1b85710fbb5a37ee8215c5	https://github.com/servo/servo/pull/30858	build(deps): bump libc from 0.2.150 to 0.2.151 (#30858)
    a4c3ba2a22bc9d63019fa1982e19f4bd6991ac85	https://github.com/servo/servo/pull/30856	build(deps): bump ryu from 1.0.15 to 1.0.16 (#30856)
    0a5ccf1bb8aad010773620140667ab5e6fcb5ef8	https://github.com/servo/servo/pull/30857	build(deps): bump http-body from 0.4.5 to 0.4.6 (#30857)
    e066700c998a0a69a3fb5249207cf6067ef4c2e1	https://github.com/servo/servo/pull/30855	build(deps): bump xcursor from 0.3.4 to 0.3.5 (#30855)
    ae31a01a0efc5eb13a4ec285fa3ed0f6c1f56e3e	https://github.com/servo/servo/pull/30854	build(deps): bump itoa from 1.0.9 to 1.0.10 (#30854)
    14305f2325efc02ca21d3a9990c25e436e295c10	https://github.com/servo/servo/pull/30853	build(deps): bump rustix from 0.38.27 to 0.38.28 (#30853)
    6026386d84c870e5be6b1ee4d1ef9bb53145f10e	https://github.com/servo/servo/pull/30852	build(deps): bump syn from 2.0.39 to 2.0.40 (#30852)
    8e5dc04347b22bb43320d410ae7e238931ed1f27	https://github.com/servo/servo/pull/30851	build(deps): bump profiling from 1.0.11 to 1.0.12 (#30851)
+++ 1105eb66e9ce43f0f2ea6c6b5cea5e72394eee3f	https://github.com/servo/servo/pull/30848	Use os version in taplo cache-key & setuptools 65 in py3.8 (#30848)
+++ 9f7afe595a11d32859b45bf3bf2fd36ee5ae46e7	https://github.com/servo/servo/pull/30836	Update mozjs (#30836)
+++ a315bec4ed73c7c0ef89f120c8f52e2609f9028b	https://github.com/servo/servo/pull/30825	Use app units in replaced elements (#30825)
>>> 2023-12-13T06:06:44Z
+++ 17f3c45d4ff597dc1e179d89784bb5f57b4c03d7	https://github.com/servo/servo/pull/30767	Add initial support for offscreen rendering (#30767)
+++ 97e6c72f5767e1cd754c82317a21aa222c5d968b	https://github.com/servo/servo/pull/30840	Add multiview feature flag in compositing and constellation (#30840)
+++ 8a226fdb1975ae1df8d1a673eb3dca9f2bb771aa	https://github.com/servo/servo/pull/30841	constellation: notify embedder when events are hit-tested to browsers (#30841)
    676c170b07551deabb9947f1f7ce6e0d1ec50974	https://github.com/servo/servo/pull/30865	Fix libsimpleservo build on Linux and BSD (#30865)
>>> 2023-12-14T06:16:19Z
    5e8f70fc2f71e2f4680c6adef2b005bd637c7e2e	https://github.com/servo/servo/pull/30872	build(deps): bump crossbeam-channel from 0.5.8 to 0.5.9 (#30872)
    01013b9ea8b3c5527a01e093a2c3b5b938c91186	https://github.com/servo/servo/pull/30871	Re-enable minification to fix the doc build (#30871)
    7ed6f330cf948b3fb4ad454fd95af00cc00e42c9	https://github.com/servo/servo/pull/30874	build(deps): bump crossbeam-utils from 0.8.16 to 0.8.17 (#30874)
    95dae276ccd130a5d7d0fbe35298f3853e5d1552	https://github.com/servo/servo/pull/30873	build(deps): bump syn from 2.0.40 to 2.0.41 (#30873)
    2fcbcb4b55b9ae7b518e78e6ea0f8828c0f76d70	https://github.com/servo/servo/pull/30867	Fix two more warnings in WebRender (#30867)
>>> 2023-12-27T06:06:58Z
    205d52a0c912a8418cbaf70bb82af3e182decc1d	https://github.com/servo/servo/pull/30948	Update h2 and servo-tidy.toml (#30948)
    e629ddb56df3d0a7331e060a41c86b44602e3a1b	https://github.com/servo/servo/pull/30947	build(deps): bump thiserror from 1.0.51 to 1.0.52 (#30947)
    29febb1b7bf5c88633527800ce036f403b7ef389	https://github.com/servo/servo/pull/30945	build(deps): bump futures-channel from 0.3.29 to 0.3.30 (#30945)
    3cf26dadcaac7406dba1482a71159e8e19119999	https://github.com/servo/servo/pull/30944	build(deps): bump futures-util from 0.3.29 to 0.3.30 (#30944)
    21f0c1637d086cdf57f7c7e0ef5454af753bd35d	https://github.com/servo/servo/pull/30943	build(deps): bump crossbeam-epoch from 0.9.10 to 0.9.17 (#30943)
    f272770f6ca4488a5afe8cab734ac3c8611f858d	https://github.com/servo/servo/pull/30942	build(deps): bump lyon_geom from 1.0.4 to 1.0.5 (#30942)
    85a5c18ab01d639bfd426fd18db9a03e27c6b5f6	https://github.com/servo/servo/pull/30939	De-dupe ahash (#30939)
    8d121a0a1d248bba29c6fb52624e9fef84b0ce89	https://github.com/servo/servo/pull/30940	Update requirements.txt (#30940)
    cad3ca2512e3e7e1a3a527e771bb2ff88f4cd47a	https://github.com/servo/servo/pull/30938	Sync WPT with upstream (25-12-2023) (#30938)
    d58fc0d674a2d41e57df79c52051c121d2e2864b	https://github.com/servo/servo/pull/30937	build(deps): bump futures-core from 0.3.29 to 0.3.30 (#30937)
    bfa3f8aede4f61a44fa718963022fe572e5cb319	https://github.com/servo/servo/pull/30933	build(deps): bump indexmap from 1.9.3 to 2.1.0 (#30933)
    4214462e5a802710773a94f485aa7d000c183360	https://github.com/servo/servo/pull/30935	build(deps): bump crossbeam-channel from 0.5.9 to 0.5.10 (#30935)
    66c17af150e5021edcda54dac6ad398179464d25	https://github.com/servo/servo/pull/30934	build(deps): bump futures-io from 0.3.29 to 0.3.30 (#30934)
    ee8df0f3a5e167604457e277e659421f45c782de	https://github.com/servo/servo/pull/30932	build(deps): bump crossbeam-utils from 0.8.17 to 0.8.18 (#30932)
    3aebbd41eb703a80ccf4c67dfee45c218647b5f2	https://github.com/servo/servo/pull/30931	build(deps): bump futures-sink from 0.3.29 to 0.3.30 (#30931)
    734accdbd21d17f609a6b67a8d906ce87fa8cc95	https://github.com/servo/servo/pull/30930	build(deps): bump syn from 2.0.42 to 2.0.43 (#30930)
    6d37c8789e72fffbb49913c05f60fcf9d3c4d915	https://github.com/servo/servo/pull/30929	build(deps): bump futures-task from 0.3.29 to 0.3.30 (#30929)
    1d2b77ea8b2fb4356a0a9cd39fc7aa6d56d41d90	https://github.com/servo/servo/pull/30928	build(deps): bump object from 0.32.1 to 0.32.2 (#30928)
+++ 7973cb64586d94a6987562fe6f180ac29ef0e971	https://github.com/servo/servo/pull/30926	Update wgpu to 0.18.1 (#30926)
    3ce590bec4f281ab68a817ce2d9872234a66ddf6	https://github.com/servo/servo/pull/30925	Fix wpt-sync-from-upstream boolean (#30925)
    554b35b7050523e9cd668d7fbdaa6abbf8bc7746	https://github.com/servo/servo/pull/30919	Improve formatting of Python files (#30919)
    df157dcc0389138a93c2c0e748b00995ac7d1bc4	https://github.com/servo/servo/pull/30923	dependencies: Update to latest version of `unwind-sys` (#30923)
    1e540e69ae074a1e8378f8ffc2a4fd89ff0ab484	https://github.com/servo/servo/pull/30921	Update mozjs to use ESR115.7 (#30921)
    6486efeeb27de3e197566e2dff6f136a751dbb2c	https://github.com/servo/servo/pull/30917	build(deps): bump proc-macro2 from 1.0.70 to 1.0.71 (#30917)
+++ 1f0f50b22bb43e965febf31f5a436113f2958725	https://github.com/servo/servo/pull/30912	Customizable wpt options and profile in workflows (#30912)
+++ 81f5157522ae320068515571a371aa3b72de0cfa	https://github.com/servo/servo/pull/30868	Add support for table fixups (#30868)
+++ 709d00583fb28fb668f10eab1f2f16f07c331078	https://github.com/servo/servo/pull/30866	layout: Make all word separators justification opportunities (#30866)
    8e31daeb6ba01c9af13b71280a002dc70a13ef0a	https://github.com/servo/servo/pull/30908	build(deps): bump syn from 2.0.41 to 2.0.42 (#30908)
    d296f0c5bea13dc109842a3fabd60e91b881fe2b	https://github.com/servo/servo/pull/30907	Fix flake8 config (#30907)
    8c257298c5f6ce75ef2617277a407c92541a1c9d	https://github.com/servo/servo/pull/30909	build(deps): bump anyhow from 1.0.75 to 1.0.76 (#30909)
    f2882879d8d345c62d8d1d076485af6280e54dde	https://github.com/servo/servo/pull/30903	Fix the try build when pushing to branches (#30903)
+++ 74798c4b7bf173fc99b96e219c6c2cab136d5c4c	https://github.com/servo/servo/pull/30905	layout: Add support for `text-align-last` (#30905)
    d007d265bd5449d6c8e5abd18f946b79ca9f31f7	https://github.com/servo/servo/pull/30906	Fix the unwind-sys build on latest Fedora (#30906)
+++ a9bf29cf8aede9771a16922c98cc933ce84b2ccc	https://github.com/servo/servo/pull/30897	Fix crash caused by arithmetic underflow in layout2020 (#30897)
+++ abb017b8543efea54b732efa2846b25c949985c9	https://github.com/servo/servo/pull/30898	script: Allow moving back to non-quirks mode (#30898)
    c8cfab2518937a1e2c1c62a7378bea4b8b06be6e	https://github.com/servo/servo/pull/30901	build(deps): bump tokio from 1.35.0 to 1.35.1 (#30901)
    6f09da1463a2a93f14a9cd941291e431fae587f8	https://github.com/servo/servo/pull/30900	build(deps): bump pkg-config from 0.3.27 to 0.3.28 (#30900)
    0989ffbf26872449fcb1d9c83cb2f99061831126	https://github.com/servo/servo/pull/30899	build(deps): bump profiling from 1.0.12 to 1.0.13 (#30899)
+++ 256ab5353b9145dbda103ec48cf4d10f32f6912a	https://github.com/servo/servo/pull/30888	These changes fix #30843 (#30888) Fix a crash in WebGPU when WebGPU is disabled
    8bbcf0abafc22cd840cd03f36b5b3b7d2d815493	https://github.com/servo/servo/pull/30884	build(deps): bump hyper from 0.14.27 to 0.14.28 (#30884)
    b156cd5ca219b4fb555ee4ea11cb96b796848d5b	https://github.com/servo/servo/pull/30883	build(deps): bump home from 0.5.5 to 0.5.9 (#30883)
    a7d5fc4db19aaf9dc28f7e617dd231906c759106	https://github.com/servo/servo/pull/30882	build(deps): bump thiserror from 1.0.50 to 1.0.51 (#30882)
    5c8fc7309d54ae2ffb4fd1eed122d411d454b13c	https://github.com/servo/servo/pull/30879	Update web-platform-tests to revision b'a85f0dfe538b9cb894388a65dba7a2a21db050c7' (#30879)
+++ e4aed3d06a8a1ef6e7af142f02be95ce2a3065cb	https://github.com/servo/servo/pull/30877	Update branch name to main (#30877)
+++ ccf0b739dfca312a65002c443fb09537aa27225b	https://github.com/servo/servo/pull/30807	Add basic support for `text-align: justify` (#30807)
    0be30b30ceecbde34cc03c30e44536a5d3f8b7a9	https://github.com/servo/servo/pull/30870	Fix the WPT exporter (#30870)
    29eb4878ed12d073e6fb805184b2f747ddfc9841	https://github.com/servo/servo/pull/30859	build(deps): bump tokio from 1.34.0 to 1.35.0 (#30859)
+++ 569c4a8823369678870e1b5f50a2c484d32fb687	https://github.com/servo/servo/pull/30803	Integrate hyper_serde into Servo source (#30803)
>>> 2023-12-28T06:04:45Z
    7305c59304a776dfcb197f91c02b1d28fe8a29ff	https://github.com/servo/servo/pull/30951	build(deps): bump futures-executor from 0.3.29 to 0.3.30 (#30951)
    4c47f7f723d3f60eb53fc5fe161338d48f559942	https://github.com/servo/servo/pull/30950	build(deps): bump serde_bytes from 0.11.12 to 0.11.13 (#30950)
    b51908d1785dac1035a0db395ba4220a042920e7	https://github.com/servo/servo/pull/30949	build(deps): bump anyhow from 1.0.76 to 1.0.77 (#30949)
    574445c27a6975213900d9c05e81cd89f7f6e2ed	https://github.com/servo/servo/pull/30946	build(deps): bump fdeflate from 0.3.1 to 0.3.2 (#30946)
>>> 2023-12-29T06:03:36Z
    f77554bfa37ad9db085619363f769192b8141ea3	https://github.com/servo/servo/pull/30956	build(deps): bump tempfile from 3.8.1 to 3.9.0 (#30956)
+++ e79171ec01199ba7100c0ad90576a6ec5705d80c	https://github.com/servo/servo/pull/30954	Update WebGPU CTS (#30954)
    90a25ab2e1344e13bf58c0dcab3ce5e9b58f3572	https://github.com/servo/servo/pull/30955	build(deps): bump fdeflate from 0.3.2 to 0.3.3 (#30955)
    bd052f536e92c6acdd7a2902af9896e3221139c1	https://github.com/servo/servo/pull/30924	bhm: Fix a warning in the Linux sampler (#30924)
>>> 2023-12-30T06:12:29Z
    ae1421a5156205ce339407c6862fa247e373a2e9	https://github.com/servo/servo/pull/30957	Update mozjs (#30957)  Move rust-mozjs's build script to mozjs-sys #409 
    be1a0a0b2b871c3d72536ee1eea5521c6214d637	https://github.com/servo/servo/pull/30958	fix: add a missing dot in HACKING_QUICKSTART.md (#30958)
>>> 2023-12-31T06:14:24Z
    f08ba0f6fff3cde89d326316b33c86a880b46739	https://github.com/servo/servo/pull/30959	build(deps): bump memchr from 2.6.4 to 2.7.1 (#30959)
>>> 2024-01-01T06:08:41Z
>>> 2024-01-02T06:15:51Z
    f58541e65263daf60d3f5c3f8ad075b09d25223b	https://github.com/servo/servo/pull/30962	Sync WPT with upstream (01-01-2024) (#30962)
+++ 7964a4f582d5697e0ea55203dd4ec25d69dbed97	https://github.com/servo/servo/pull/30963	Unfork and upgrade jemallocator (#30963)
    d8e1e0e07ca0828e200af9f47a7e120ccdcd945c	https://github.com/servo/servo/pull/30967	build(deps): bump clang-sys from 1.3.1 to 1.7.0 (#30967)
    f51c7847fb88c55f39b67edb7e95a98d48361420	https://github.com/servo/servo/pull/30969	build(deps): bump serde_json from 1.0.108 to 1.0.109 (#30969)
    634c3fb1bd671582d664d38d89259920d88b2232	https://github.com/servo/servo/pull/30965	build(deps): bump anyhow from 1.0.77 to 1.0.78 (#30965)
    eb06c00c201cefd1116651debb2252d430f6eb0a	https://github.com/servo/servo/pull/30964	build(deps): bump thiserror from 1.0.52 to 1.0.53 (#30964)
>>> 2024-01-03T06:11:55Z
    230e00c31350095b078f195152c4c37bf57900bd	https://github.com/servo/servo/pull/30983	build(deps): bump serde from 1.0.193 to 1.0.194 (#30983)
    3274c812e5f87ae544aeba2d5b2b9f0f5f16e52a	https://github.com/servo/servo/pull/30978	build(deps): bump iana-time-zone from 0.1.58 to 0.1.59 (#30978)
    8916ae73ccf9111df7e9788ab17414870cbe8989	https://github.com/servo/servo/pull/30982	build(deps): bump anyhow from 1.0.78 to 1.0.79 (#30982)
    d2b4439dec428c819712a7260950bcdf13617b0a	https://github.com/servo/servo/pull/30980	build(deps): bump thiserror from 1.0.53 to 1.0.55 (#30980)
    8faa90450192978b080ff95ba39a64b1b8111ba4	https://github.com/servo/servo/pull/30977	build(deps): bump quote from 1.0.33 to 1.0.35 (#30977)
+++ 3353db71d232ed3e6108950e21a6dba6360e6d57	https://github.com/servo/servo/pull/30975	Fail gracefully when DMG smoketest fails (#30975)
    bbadef3365e0565fca96e9a0c2e2cb014f8d60e8	https://github.com/servo/servo/pull/30976	Remove the servo-gst-plugin (#30976)
    5b0c03801a4a52252ccf0b6add7f8ea76187b0d8	https://github.com/servo/servo/pull/30966	build(deps): bump ahash from 0.8.6 to 0.8.7 (#30966)
    516cc2cbca55a1d1505a494875d0c2022ac314c2	https://github.com/servo/servo/pull/30941	tidy: A few small improvements and fixes (#30941)
>>> 2024-01-04T06:14:15Z
+++ f44ff83c20b82d1f3272d9389563e30f0d3c9700	https://github.com/servo/servo/pull/30989	WebGPU: always send exit message to script before exiting (#30989)
+++ 65cbc95d38819e9b3d5870953015a9e7963a0ace	https://github.com/servo/servo/pull/30927	Replace time with std::time in components/devtools (#30927)
    d0998a771ae773509104e1fcfbe23d4a69f7aa90	https://github.com/servo/servo/pull/30995	build(deps): bump thiserror from 1.0.55 to 1.0.56 (#30995)
    e306f69f64396ec84f00acf56536439ef23b02ff	https://github.com/servo/servo/pull/30994	build(deps): bump serde_bytes from 0.11.13 to 0.11.14 (#30994)
    06fedebe1160e7f0e46e70a0cce3ac6f6ada018c	https://github.com/servo/servo/pull/30993	build(deps): bump serde_json from 1.0.109 to 1.0.110 (#30993)
    6695dba5927ba879f1f8b3c398e139bcedb76e13	https://github.com/servo/servo/pull/30992	build(deps): bump semver from 1.0.20 to 1.0.21 (#30992)
    a7e97af9f2c3ae04fc9336fc71ff6e779a23eac8	https://github.com/servo/servo/pull/30991	build(deps): bump prettyplease from 0.2.15 to 0.2.16 (#30991)
    94d76b29468d6468068a3d99eab7ddc14a5f7bb4	https://github.com/servo/servo/pull/30960	docs(style): update outdated `stylo` project name and link (#30960)
    7580aa2fc2d779df979578d688e47986461c03d4	https://github.com/servo/servo/pull/30985	Update futures (#30985)
    51c91d2881689537ace800f87482f47b30c62956	https://github.com/servo/servo/pull/30988	bootstrap: Don't try to install Windows Python with `./mach bootstrap` (#30988)
+++ 0dbba9b6ffe0507011337c27c2709f6c4cebe1c0	https://github.com/servo/servo/pull/30973	Download Windows GStreamer dependencies from GitHub (#30973)
>>> 2024-01-05T06:16:06Z
+++ c219204084b8f8a747ebd37ec75472c1b7e97411	https://github.com/servo/servo/pull/30987	Fix crown on NixOS (#30987)
    21d9c2cc637842118adc5af682422e3df994710b	https://github.com/servo/servo/pull/31004	build(deps): bump proc-macro2 from 1.0.74 to 1.0.75 (#31004)
+++ 90a9300f698aa266db47b336f3fcd7d6680b4d65	https://github.com/servo/servo/pull/30896	Script: ensure child JS runtimes are dropped before parent (#30896)
    2f6f03a3b5ab49368e27988960c78d8f7d5f1190	https://github.com/servo/servo/pull/30996	build(deps): bump windows-core from 0.51.1 to 0.52.0 (#30996)
    a3a2a433877ce9d9b4cf8d04551c145543450333	https://github.com/servo/servo/pull/30998	Remove IRC comment in style.md (#30998)
>>> 2024-01-08T06:07:00Z
+++ 79a0f76d26d43c7f6e38a60fbe2ec6bed1510543	https://github.com/servo/servo/pull/31019	Fix the build on Ubuntu 20.04 (#31019)
    d0ce48db06c121028e723ad3375186ab0fb961da	https://github.com/servo/servo/pull/31015	Fix installation instructions for Python on Debian-like distributions in README (#31015)
    4132bc920b829a82dafae39ff66f2a56c353f46f	https://github.com/servo/servo/pull/31009	build(deps): bump syn from 2.0.46 to 2.0.48 (#31009)
    2cecd1c99e2a28476019256d332672082d5ea66f	https://github.com/servo/servo/pull/31011	build(deps): bump itertools from 0.10.5 to 0.12.0 (#31011)
    d83741d14c98b114ed8b1fd0e795d292467dc76b	https://github.com/servo/servo/pull/31010	build(deps): bump num-rational from 0.4.0 to 0.4.1 (#31010)
+++ 9a1d7aabd71fe82c9420abdc33a6a9ba0f8eac52	https://github.com/servo/servo/pull/31003	bootstrap: Adding more output when installing dependencies (#31003)
    afb0d4c56ed98c4a16fe51d9cf051cc351aba16f	https://github.com/servo/servo/pull/31005	build(deps): bump serde_json from 1.0.110 to 1.0.111 (#31005)
+++ 7fa4ea9740edccc93672d8cc428f6e9d4575a036	https://github.com/servo/servo/pull/30750	Upgrade media / GStreamer / GLib (#30750) 0.15 -> 0.21
>>> 2024-01-09T06:16:45Z
    dd0149d95374593f3c613716284fe584a2324cbb	https://github.com/servo/servo/pull/31029	build(deps): bump serde from 1.0.194 to 1.0.195 (#31029)
    77cf708ca6a01b30db718f6abf4cbfc730c6f604	https://github.com/servo/servo/pull/31027	build(deps): bump winnow from 0.5.31 to 0.5.33 (#31027)
    e2c490aaac581c726f8405f6b6917f5469e6f848	https://github.com/servo/servo/pull/31035	build(deps): bump crossbeam-channel from 0.5.10 to 0.5.11 (#31035)
    15d6c39ba6bd6191d5688b8f02e0af32827fc753	https://github.com/servo/servo/pull/31031	build(deps): bump libz-sys from 1.1.12 to 1.1.13 (#31031)
    a78bb04c1a5ec5d655bad3f8c2c7d80c4b09c520	https://github.com/servo/servo/pull/31032	build(deps): bump base64 from 0.21.5 to 0.21.6 (#31032)
    ea4bf488912a7f13a6f960e71dd247e6ec3e25d5	https://github.com/servo/servo/pull/31034	build(deps): bump proc-macro2 from 1.0.75 to 1.0.76 (#31034)
    9278c28863ce20d3c7dd11323d9bbdab122718f3	https://github.com/servo/servo/pull/31033	build(deps): bump crossbeam-utils from 0.8.18 to 0.8.19 (#31033)
    cfa955778df17caf36dbb0a0216f2a3b392703d0	https://github.com/servo/servo/pull/31030	build(deps): bump crossbeam-epoch from 0.9.17 to 0.9.18 (#31030)
    65c44dea37fbfe743aa8d8adc1de97fe59158bc2	https://github.com/servo/servo/pull/31008	build(deps): bump cpufeatures from 0.2.11 to 0.2.12 (#31008)
+++ aa073c3dcaffe30c7a6e272ba4ef5121c090f1bf	https://github.com/servo/servo/pull/30902	layout: Implement support for `line-height` and `vertical-align` (#30902)
    527119aebb4e0c05e3ba17c5ba2e2741d51489a9	https://github.com/servo/servo/pull/31018	Sync WPT with upstream (07-01-2024) (#31018)
>>> 2024-01-10T06:16:53Z
    bfa853a1cc305048d99a6eba5201ac86e8fbb1c1	https://github.com/servo/servo/pull/31044	build(deps): bump libc from 0.2.151 to 0.2.152 (#31044)
    81c665e392182ad0ab61243d180d7448000992bc	https://github.com/servo/servo/pull/31043	build(deps): bump crossbeam-deque from 0.8.1 to 0.8.5 (#31043)
    91ef26b203ae99cff0a6f46fefd4c783a9132af5	https://github.com/servo/servo/pull/31040	build(deps): bump getrandom from 0.2.11 to 0.2.12 (#31040)
    1150a2c33fc9793dfd55f3f7ba6019d311589c9d	https://github.com/servo/servo/pull/31041	build(deps): bump libz-sys from 1.1.13 to 1.1.14 (#31041)
    54dd8becc1d5684f19c1e4b6f6b9c5a2c43c2ebe	https://github.com/servo/servo/pull/31038	build: Combine and simplify GStreamer shared object lists (#31038)
+++ 94a3c49a807626ecddb7f062e6856e9e0d66baca	https://github.com/servo/servo/pull/31001	Allow building with Nix on Linux distros other than NixOS (#31001)
+++ 6a804cd775e3976103269ac54ae997a3accc8618	https://github.com/servo/servo/pull/30974	Integrate the `devices` respository (#30974)
+++ fddc4a430fca591152c69f0793ab946dcdc81617	https://github.com/servo/servo/pull/31002	Fix failed request for adapter when not available (#31002)
>>> 2024-01-11T06:08:02Z
+++ 92196d985dceb0ca708b097e2a847b255d8387c8	https://github.com/servo/servo/pull/31020	Replace time with std::time in components/metrics & components/shared (#31020)
    e3e0d8f2c41e5d3b7ec46c851a9754fe4e486dae	https://github.com/servo/servo/pull/31058	build(deps): bump termcolor from 1.4.0 to 1.4.1 (#31058)
    81d4236c8c66cbb86685c4acc115a08671bd1d1c	https://github.com/servo/servo/pull/31057	fixed commented time in nightly-rust.yml (#31057)
+++ 17ffbbdd11b47d577bdfe4318c36bcb5de365b18	https://github.com/servo/servo/pull/31052	Nix: bump nixpkgs to nixos-23.05 (except gnumake) (#31052)
    355567186400d0531657d0eedda7625de9d0e93a	https://github.com/servo/servo/pull/31039	layout: Split `LineItem` layout into a new file (#31039)
>>> 2024-01-12T06:07:36Z
    6dc208bb09bc85b8f08118fd91c6848ca29c6d16	https://github.com/servo/servo/pull/31068	build(deps): bump h2 from 0.3.22 to 0.3.23 (#31068)
    24a18a985e54ced34d9e7fc08debdc0a955bba2b	https://github.com/servo/servo/pull/31066	build(deps): bump winnow from 0.5.33 to 0.5.34 (#31066)
+++ e145c512347807cdf44537fdfa83f2a5dda05b5a	https://github.com/servo/servo/pull/30990	WebIDL: use FLoat32Array  (#30990)
+++ 90f70e3408e1d4b3f378e50f9f051cb00c77c446	https://github.com/servo/servo/pull/31063	Fix underflow in PerformanceResourceTiming API (#31063)
+++ 1f1cf1499d1e249c58fb3ac8986e62cf0d796497	https://github.com/servo/servo/pull/31055	Nix: bump nixpkgs to nixos-unstable (#31055)
>>> 2024-01-13T06:04:19Z
    efe4071a5b97f7b5bc460bf99c26823bbf0d918f	https://github.com/servo/servo/pull/31082	build(deps): bump js-sys from 0.3.66 to 0.3.67 (#31082)
    fdd9263cae673a3a6d06630a56515a7e398d163a	https://github.com/servo/servo/pull/31081	build(deps): bump vergen from 8.2.6 to 8.2.7 (#31081)
    3efaaa1514947191c563aef6a6ef6a99d80a297b	https://github.com/servo/servo/pull/31080	build(deps): bump wasm-bindgen from 0.2.89 to 0.2.90 (#31080)
+++ abb54f7832682bad1545b307a545a7ba977ef209	https://github.com/servo/servo/pull/31075	build: Don't add the `neon` feature for arm and aarch64 (#31075)
    b61c794ae43da74b6038055295bbf8f7eb877b28	https://github.com/servo/servo/pull/31073	fix conditional logic that enables native bluetooth (#31073)
>>> 2024-01-14T06:05:53Z
    e7d2d23e1eb3aca4d69666ea21682188a9be1e35	https://github.com/servo/servo/pull/31085	Update web-platform-tests to revision b'5049a31d2a7eebd7bca08317e56664021a8bd36c' (#31085)
>>> 2024-01-15T06:10:05Z
>>> 2024-01-16T06:18:19Z
    4248168f38bdb24114e42fe5835a377043349428	https://github.com/servo/servo/pull/31096	build(deps): bump jpeg-decoder from 0.3.0 to 0.3.1 (#31096)
    214a423dc2cb80a50c13676aec7e527e6ceb0fd6	https://github.com/servo/servo/pull/31103	build(deps): bump freetype from 0.7.0 to 0.7.1 (#31103)
    cf2fd238246261d882773af74dac8d9b0cdd31b4	https://github.com/servo/servo/pull/31102	build(deps): bump rustix from 0.38.28 to 0.38.30 (#31102)
    3e00979ce734f258697847a36930a52b19d8c294	https://github.com/servo/servo/pull/31101	build(deps): bump web-sys from 0.3.66 to 0.3.67 (#31101)
    d5ae4e6d36ce3d2ee91bdca8fcfd769f317c7f6d	https://github.com/servo/servo/pull/31099	build(deps): bump png from 0.17.10 to 0.17.11 (#31099)
    a75eec6fe41253f1bcf8c7770d1ed91c43635451	https://github.com/servo/servo/pull/31100	build(deps): bump vergen from 8.2.7 to 8.2.10 (#31100)
    4c371986f701ea15b9fdb8b83ddec5a59cced973	https://github.com/servo/servo/pull/31097	build(deps): bump image from 0.24.7 to 0.24.8 (#31097)
    33b9e7e77a4e18d59bb6c1a24882d9e7d3b0a4c1	https://github.com/servo/servo/pull/31094	build(deps): bump tiff from 0.9.0 to 0.9.1 (#31094)
    1b847c3166d17a957f5ab5e4aae3a3fcb10d875c	https://github.com/servo/servo/pull/31083	layout: Switch `IndependentLayout` to use `Au` instead of `Length` (#31083)
+++ efa38c67fe6bdec751739bb3a0a6d159f2b695c8	https://github.com/servo/servo/pull/31091	ci: Remove the nightly-rust workflow (#31091)
    25a9f4560ec0270c5f5b4794c30be85b3ca12ef3	https://github.com/servo/servo/pull/31026	bootstrap: Improve pip dependency resolution (#31026)
    5d94fc6b708e3ab172802dbc1825ca9b427335ac	https://github.com/servo/servo/pull/31067	build(deps): bump base64 from 0.21.6 to 0.21.7 (#31067)
+++ 0d240b8713fb5cd933d348e668ab02a53859282b	https://github.com/servo/servo/pull/31088	deps: Raise the Python requirement to 3.10 (#31088)
    3c1ab6545829442d30cc8244074f59c9e857755f	https://github.com/servo/servo/pull/31090	crown: Add a cargo config.toml file (#31090)
    97284ead14d90ca4891f709d220e4d6ee0c2f4c1	https://github.com/servo/servo/pull/31089	Temporarily disable the webaudio tests (#31089)
    ee46f233d9ed02fc25ea9b2c7b2a4e0a829616e0	https://github.com/servo/servo/pull/31071	audiobuffer: ensure dest has the same size as source in copy from channel (#31071)
>>> 2024-01-17T06:09:03Z
    55bf020d8989c732b095b9e330bc55369f11d432	https://github.com/servo/servo/pull/31107	build(deps): bump vergen from 8.2.10 to 8.3.0 (#31107)
+++ 8c53a8c745ab2a5b660d6f170e74b4fecca189c1	https://github.com/servo/servo/pull/31077	use FLoat32Array in XRView (#31077)
+++ 9654363c187ee549b82bca8c4e3098e4c20c7287	https://github.com/servo/servo/pull/30639	script: Start replacing `time` with `std::time` and `chrono`  (#30639)
    c06ae7faf201e539a4cfbaefb6d5b8444796f472	https://github.com/servo/servo/pull/31095	ci: Set LLVM_PATH when building docs (#31095)
    f2b3e497b24da23f480939be1616925fa326721d	https://github.com/servo/servo/pull/31098	build(deps): bump smallvec from 1.11.2 to 1.12.0 (#31098)
>>> 2024-01-18T06:17:19Z
    d9cb4445ff85b687307f93d950eab810dee2c6b0	https://github.com/servo/servo/pull/31113	build(deps): bump fdeflate from 0.3.3 to 0.3.4 (#31113)
    7480f67497464a7664cab37a739299e2a5d50498	https://github.com/servo/servo/pull/31114	build(deps): bump vergen from 8.3.0 to 8.3.1 (#31114)
    831c7fa5e8e1e7975969270320033b9940c70f7d	https://github.com/servo/servo/pull/31112	build(deps): bump bitflags from 2.4.1 to 2.4.2 (#31112)
    746dd0892f6f24f4cde6ff10e9778f3770894834	https://github.com/servo/servo/pull/31111	build(deps): bump pkg-config from 0.3.28 to 0.3.29 (#31111)
    0ab41e977fbfed1012bdf120d7279522b589bc8c	https://github.com/servo/servo/pull/31110	build(deps): bump linux-raw-sys from 0.4.12 to 0.4.13 (#31110)
+++ 580062228bb083ccdc2144a43491bc4f916c57ad	https://github.com/servo/servo/pull/31079	Replace time with std::time in components/net (#31079)
+++ d86e713a9cb5be2555d63bd477d47d440fa8c832	https://github.com/servo/servo/pull/31092	build: Clean up post-build copy of Windows DLLs (#31092)
+++ f76982e2e7f411e2e2fd8e6dbfe92a080acefc54	https://github.com/servo/servo/pull/31087	script: Use FLoat32Array in XRRay (#31087)
    d43adb1a92c419680be86e7335f3de84b75fb2ef	https://github.com/servo/servo/pull/31078	build: Only set PATH for GStreamer (#31078)
+++ 6a7b450478f69d9d83b0936a0ab28ac2d94761d4	https://github.com/servo/servo/pull/31076	use FLoat32Array in XRRigidTransform (#31076)
>>> 2024-01-19T06:05:45Z
    9a698b7bfbb2d8ec72e31d103051edf1f11b3e51	https://github.com/servo/servo/pull/31132	mach: remove the generic 'test' command since it only supports two types of tests (#31129) (#31132)
    0c8e74dcecfe02034ee5ea150ee9f5910250c595	https://github.com/servo/servo/pull/31128	mach: Don't print anything when deps are up-to-date (#31128)
    729f40d1e080ebea5b858c60ee9372dcb2d13d09	https://github.com/servo/servo/pull/31127	Remove the `.hgignore` file (#31127)
    64292cbb97407254bdaca949cf33c29139015a3e	https://github.com/servo/servo/pull/31126	build(deps): bump unicode-bidi from 0.3.14 to 0.3.15 (#31126)
    e8212b5db18a39ed987b26f368880d5c5dfaf184	https://github.com/servo/servo/pull/31125	build(deps): bump h2 from 0.3.23 to 0.3.24 (#31125)
    8ffa567cfa3c239dfb374986f5bf3a85f790cbc1	https://github.com/servo/servo/pull/31122	build(deps): bump rayon-core from 1.12.0 to 1.12.1 (#31122)
    fdfeb3ed4425c3ac659bea8e2fc5535cb3b9488d	https://github.com/servo/servo/pull/31115	wpt: Create a base class for Servo process executors (#31115)
    c641c589e5f18e461887bdb67528425fe683715d	https://github.com/servo/servo/pull/31119	build: Use `--keep-going` in `./mach doc` (#31119)
+++ 8e5f28839cde6b9ee5cd7cb4f8c27ff0ae10a86c	https://github.com/servo/servo/pull/31120	Revert "Replace time with std::time in components/net (#31079)" (#31120)
    c3fd27c225e66fc00611bcd35f462077dfcf21d1	https://github.com/servo/servo/pull/31118	ci: Fix WPT try layout configuration (#31118)
>>> 2024-01-20T06:04:40Z
    f93aefdb7359e1ac6cad99133262b9909b6908b9	https://github.com/servo/servo/pull/31139	build(deps): bump smallvec from 1.12.0 to 1.13.0 (#31139)
    87e88eecf246b5ee43a47870855ddb1be263fa00	https://github.com/servo/servo/pull/31138	build(deps): bump uuid from 1.6.1 to 1.7.0 (#31138)
    957016f83cca3ad8815b5476ce9ff34a36d1cefa	https://github.com/servo/servo/pull/31140	build(deps): bump rayon from 1.8.0 to 1.8.1 (#31140)
    a8b34e88ca9ab4d0707fdf7ff3e30a508c8f54fe	https://github.com/servo/servo/pull/31117	layout: Convert all inline iteration to a new `foreach` function (#31117)
+++ fc31e69f79a68408fdd376a52942587a8fca9170	https://github.com/servo/servo/pull/31121	layout: Add *very* basic support for table layout (#31121)
+++ 3d520f266800e0035c429ddf2a3b45922f502ebd	https://github.com/servo/servo/pull/30894	Use App units in flow layout (#30894)
+++ 734eb469549db22b070d86bb13a8bd167d5d1e8e	https://github.com/servo/servo/pull/31131	wpt: Unskip the `css-tables suite (#31131)
+++ 9d2c102fa0cc034b2bde51d27cd6c0e7f3cafa30	https://github.com/servo/servo/pull/31106	Use FLoat32Array in GamepadPose (#31106)
>>> 2024-01-21T06:06:07Z
>>> 2024-01-22T06:08:36Z
    8dcf3dd0b0fee0658fea43645db266be32eb2c11	https://github.com/servo/servo/pull/31143	Fix trivial typo in variable name (#31143)
    23a4a750beb89ef8e79bafc75f7a86a9e88971e1	https://github.com/servo/servo/pull/31144	Update web-platform-tests to revision b'a10b8c0164b4c4521040898ee9394738aca488b0' (#31144)
>>> 2024-01-23T06:22:19Z
    33500ed05fddd8d2985815b61d0f61b237b98b57	https://github.com/servo/servo/pull/31158	build(deps): bump regex from 1.10.2 to 1.10.3 (#31158)
    768e27344fc9e4b97ebd510256d129cfb50385e0	https://github.com/servo/servo/pull/31159	build(deps): bump smallvec from 1.13.0 to 1.13.1 (#31159)
    ebe741724f7d09e6df59a4afdbaf90ed50446e31	https://github.com/servo/servo/pull/31157	build(deps): bump env_logger from 0.10.1 to 0.10.2 (#31157)
    92453fa1b4b91b166a552e8bc993ef688585075d	https://github.com/servo/servo/pull/31155	build(deps): bump proc-macro2 from 1.0.76 to 1.0.78 (#31155)
    24a669a278cc3e5c8d6c5cd27ba2364b0c0d1919	https://github.com/servo/servo/pull/31154	build(deps): bump regex-automata from 0.4.3 to 0.4.4 (#31154)
    504fbc35a50657d89e1ff49a5b768dc2ffbc3cdd	https://github.com/servo/servo/pull/31153	build(deps): bump weezl from 0.1.7 to 0.1.8 (#31153)
    adea6248f745b65630c7cc9d3519312d93d9f143	https://github.com/servo/servo/pull/31151	build(deps): bump is-terminal from 0.4.9 to 0.4.10 (#31151)
    5c1723c9833c133e1af641533293e63d8723f8d3	https://github.com/servo/servo/pull/31147	rustdoc: Fix many rustdoc errors (#31147)
+++ d7de206dbd459e8c8bf121f73755d12569c6cc55	https://github.com/servo/servo/pull/31086	Preliminary Android build support (#31086)
    8e6bdb69b1b5110ac7fce5801d8ee3e9fd7c6354	https://github.com/servo/servo/pull/31137	Layout: Clean up `Au` conversion helper functions in the flexbox  (#31137)
>>> 2024-01-24T06:17:36Z
    6baaa828261af49e790938666ee89f156a736821	https://github.com/servo/servo/pull/31162	build(deps): bump chrono from 0.4.31 to 0.4.32 (#31162)
+++ 5d7e2a823985a8314b10dc363eb191c0d4330424	https://github.com/servo/servo/pull/31123	Implement Event.composedPath (#31123)
+++ 54fb381a0a4c070bac75e9f602bf905fa101194d	https://github.com/servo/servo/pull/31133	layout: Convert layout internal display to inline for replaced elements (#31133)
    890588945d2f0b9ad28d024d5a1ba2fb85542637	https://github.com/servo/servo/pull/31145	Use Uint8Array for TextEncoder (#31145)
+++ 7de0486e2e67a17e4cdcc881c7f3bd3fd1a66fb6	https://github.com/servo/servo/pull/31161	layout: Count word separators as justification opportunities when trimming whitespace (#31161)
    1d67aa44ca13cb3bcccc96b34fc2d86272e33f71	https://github.com/servo/servo/pull/31152	build(deps): bump webxr from `21d9e38` to `3b2f303` (#31152)
+++ dc2df7b02767004f0900055d985ecfc6cd874c9a	https://github.com/servo/servo/pull/31148	build: Add support for Visual Studio 2022 and VC143 DLLs (#31148)
+++ 45af1198aa05882d6433642c45d1cd329f145782	https://github.com/servo/servo/pull/31135	Layout: use `Au` in `ContentSizes`  (#31135)
    bd25c07b22cdd20566f5373c6e458c5e2fc51d80	https://github.com/servo/servo/pull/31156	build(deps): bump shlex from 1.2.0 to 1.3.0 (#31156)
    cf5d9c7a28a11e6780b0dc69e9d8dc562cc724f6	https://github.com/servo/servo/pull/31150	ci: fix reference to android job filename in main.yml (#31150)
>>> 2024-01-25T06:07:31Z
    af6652fc098fee10cdf4d2ad67648e7d813f1ec8	https://github.com/servo/servo/pull/31163	tests: Add GStreamer library directory to DYLD_LIBRARY_PATH (#31163)
+++ eb95703325aeb48d5f56a8da5b258bad608dd632	https://github.com/servo/servo/pull/30842	constellation: focusing and closing webviews (#30842)
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
    .figl > iframe,
    .figr > iframe,
    .figl > a > img,
    .figr > a > img {
        width: 17em;
        max-width: max-content;
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
