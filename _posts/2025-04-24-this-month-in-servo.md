---
layout:     post
tags:       blog
title:      "This month in Servo: ????"
date:       2025-04-24
summary:    Who knows?
categories:
---

<!--[commits]
>>> 2025-03-01T06:05:03Z
-https://github.com/servo/servo/pull/35729	(@yerke, #35729)	refactor: add CanGc as argument to BaseAudioContext::{Destination, Listener} (#35729)
    # Add CanGc as argument to `BaseAudioContext::{Destination, Listener}`.
    # Addressed part of https://github.com/servo/servo/issues/34573.
-https://github.com/servo/servo/pull/35722	(@dependabot[bot], @dependabot[bot], #35722)	build(deps): bump cc from 1.2.15 to 1.2.16 (#35722)
-https://github.com/servo/servo/pull/35721	(@dependabot[bot], @dependabot[bot], #35721)	build(deps): bump async-compression from 0.4.19 to 0.4.20 (#35721)
+https://github.com/servo/servo/pull/35705	(@mrobinson, #35705)	fonts: Remove the per-FontGroup cached fallback font (#35705)
    layout
+https://github.com/servo/servo/pull/35638	(@mrobinson, #35638)	libservo: Stop double-buffering `OffscreenRenderingContext` (#35638)
    performance
>>> 2025-03-02T06:04:32Z
-https://github.com/servo/servo/pull/35735	(@simonwuelker, #35735)	Refactor devtools server (#35735)
    # Previously, the devtools server code was structured like this (in pseudocode): ```rust fn run() {
    #     let member_1; let member_2;
    #     fn foo(&member_1) {
    # 	// ...
    #     }
    #     fn bar(&member_1, &member_2) {
    # 	// ...
    #     }
    #     loop {
    # 	match get_message() {
    # 	    Message1 => foo(&member_1), Message2 => bar(&member_1, &member_2),
    # 	}
    #     }
    # } ```
    # This is not very idiomatic rust.  And, more importantly, it makes it hard to edit this code with an IDE, because "find
    # all references" and similar actions don't properly work.  (member_1 inside "foo" is a different variable than member_1
    # inside "bar" or "run").
    # Instead, the code is now structured (roughly) like this:
    # ```rust struct DevtoolsInstance {
    #     member_1, member_2,
    # }
    # impl DevtoolsInstance {
    #     fn foo(&self) {
    # 	// ...
    #     }
    #     fn bar(&self) {
    # 	// ...
    #     }
    #     fn run(&self) {
    # 	loop {
    # 	    match get_message() {
    # 		Message1 => self.foo(), Message2 => self.bar(),
    # 	    }
    # 	}
    #     }
    # } ```
    # In my opinion, this is an improvement and should make future additions to the devtools server easier.  No behaviour
    # change is intended.
    # It also allows us to get rid of some `#[allow(clippy::too_many_arguments)]` annotations + ~80 LoC.
+https://github.com/servo/servo/pull/35725	(@simonwuelker, #35725)	Don't recurse in Node::GetRootNode (#35725)
    performance crash
    # Additionally, this adds a fast path in the case where the node is connected and either `composed` is true or the node is
    # not in a shadow tree.  In this case, the root is trivially the owner document.
-https://github.com/servo/servo/pull/35732	(@yerke, #35732)	refactor: add CanGc as argument to methods in CanvasRenderingContext2D and OffscreenCanvasRenderingContext2D (#35732)
    # Add CanGc as argument to methods in `CanvasRenderingContext2D` and `OffscreenCanvasRenderingContext2D`.
    # Addressed part of https://github.com/servo/servo/issues/34573.
-https://github.com/servo/servo/pull/35581	(@Narfinger, #35581)	servoshell: Read prefs.json from bundle on OHOS (#35581)
    # Allows to read the prefs.json from the hap bundle on OHOS.
-https://github.com/servo/servo/pull/35731	(@yerke, #35731)	refactor: add CanGc as argument to OffscreenCanvas methods (#35731)
    # Add CanGc as argument to `OffscreenCanvas` methods.
    # Addressed part of https://github.com/servo/servo/issues/34573.
-https://github.com/servo/servo/pull/35730	(@yerke, #35730)	sync cargo-deny version in python/servo/platform/base.py (#35730)
    # Sync cargo-deny version in `python/servo/platform/base.py` to the version specified in CI
    # (`.github/workflows/lint.yml`).  CI now requires 0.18.* after changes in https://github.com/servo/servo/pull/35628.
    # Previously I had cargo-deny version 0.16.3 installed on my machine.  After pulling the latest changes on `main`, I
    # started to get the following errors: ```
    #  ➤ Running `cargo-deny` checks...
    #   | /Users/yerke/dev/servo/deny.toml:30: unable to check for yanked crates: async-compression 0.4.20
    #   registry+https://github.com/rust-lang/crates.io-index | /Users/yerke/dev/servo/deny.toml:71: unable to check for
    #   yanked crates: calendrical_calculations 0.1.3 registry+https://github.com/rust-lang/crates.io-index |
    #   /Users/yerke/dev/servo/deny.toml:78: unable to check for yanked crates: cc 1.2.16
    #   registry+https://github.com/rust-lang/crates.io-index | /Users/yerke/dev/servo/deny.toml:85: unable to check for
    #   yanked crates: chrono 0.4.40 registry+https://github.com/rust-lang/crates.io-index |
    #   /Users/yerke/dev/servo/deny.toml:91: unable to check for yanked crates: clap 4.5.31
    #   registry+https://github.com/rust-lang/crates.io-index | /Users/yerke/dev/servo/deny.toml:92: unable to check for
    #   yanked crates: clap_builder 4.5.31 registry+https://github.com/rust-lang/crates.io-index |
    #   /Users/yerke/dev/servo/deny.toml:173: unable to check for yanked crates: either 1.14.0
    #   registry+https://github.com/rust-lang/crates.io-index | /Users/yerke/dev/servo/deny.toml:195: unable to check for
    #   yanked crates: flate2 1.1.0 registry+https://github.com/rust-lang/crates.io-index |
    #   /Users/yerke/dev/servo/deny.toml:374: unable to check for yanked crates: libc 0.2.170
    #   registry+https://github.com/rust-lang/crates.io-index | /Users/yerke/dev/servo/deny.toml:384: unable to check for
    #   yanked crates: litemap 0.7.5 registry+https://github.com/rust-lang/crates.io-index |
    #   /Users/yerke/dev/servo/deny.toml:634: unable to check for yanked crates: tar 0.4.44
    #   registry+https://github.com/rust-lang/crates.io-index | /Users/yerke/dev/servo/deny.toml:764: unable to check for
    #   yanked crates: windows-link 0.1.0 registry+https://github.com/rust-lang/crates.io-index |
    #   /Users/yerke/dev/servo/deny.toml:822: unable to check for yanked crates: zerofrom 0.1.6
    #   registry+https://github.com/rust-lang/crates.io-index | /Users/yerke/dev/servo/deny.toml:823: unable to check for
    #   yanked crates: zerofrom-derive 0.1.6 registry+https://github.com/rust-lang/crates.io-index
    # ```
    # Updating cargo-deny to version 0.18.1 (which the latest in 0.18.*) resolved the issue.
    # --- - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors
    # - [x] These changes do not require tests because I am just updating the cargo-deny version to match the version we use
    # in CI.
>>> 2025-03-03T06:06:08Z
+https://github.com/servo/servo/pull/35670	(@yezhizhen, #35670)	layout: Merge `BoxFragment::used_overflow` into `ComputedValuesExt::effective_overflow` (#35670) (#35670)
    # 1.  Merge `used_overflow` to `effective_overflow` 2.  Remove duplicate call 3.  Add link to spec, as the Overflow
    # handling for replaced element is different in:
    # - [Level 4](https://www.w3.org/TR/css-overflow-4/#overflow-control): On [replaced
    # elements](https://www.w3.org/TR/css-display-3/#replaced-element), the [used
    # values](https://www.w3.org/TR/CSS21/cascade.html#used-value) of all computed values other than
    # [visible](https://www.w3.org/TR/css-overflow-3/#valdef-overflow-visible) is
    # [clip](https://www.w3.org/TR/css-overflow-3/#valdef-overflow-clip).  - [Level 3
    # Draft](https://drafts.csswg.org/css-overflow-3/#overflow-control): On [replaced
    # elements](https://drafts.csswg.org/css-display-4/#replaced-element), a
    # [computed](https://drafts.csswg.org/css-cascade-5/#computed-value) 'hidden' value further resolves to a [used
    # value](https://drafts.csswg.org/css-cascade-5/#used-value) of 'clip'.  - [Level
    # 3](https://www.w3.org/TR/css-overflow-3/#overflow-control): No special handling for replaced element
    # Our implementation conforms to the Level 4.
    # 4.  Add comment that was missing before, to cite that viewport overflow must be interpreted as scrollable.
    # cc @xiaochengh
https://github.com/servo/servo/pull/35746	(@sagudev, #35746)	Generate Try Configuration use `ubuntu-22.04` (#35746)
    # Fixes: ![slika](https://github.com/user-attachments/assets/e286cb99-c804-48e
3-9ecb-6e4aeee0d608)
    css
-https://github.com/servo/servo/pull/35741	(@servo-wpt-sync, #35741)	Update web-platform-tests to revision b'fc557e215e11221c91de4f283539725ef2f35928' (#35741)
    # Automated downstream sync of changes from upstream as of 02-03-2025 [no-wpt-sync]
+https://github.com/servo/servo/pull/35745	(@simonwuelker, #35745)	Respond to the `connect` message from a devtools client (#35745)
    # The `connect` message is sent to the root actor when a client connection is established and tells it about the frontend
    # version of the client.  While we don't really need that information yet, we shouldn't ignore the message, otherwise we
    # trigger warnings about unimplemented functionality.
    # I also bumped the log level of some log messages in the devtools server.  Previously almost everything was `log::debug`,
    # which buries important warnings in spam (for example, all messages that are sent/received by the server are also logged
    # at that level).  Additionally, seeing a `log::debug("error: [..]")` physically hurts me.
    devtools
+https://github.com/servo/servo/pull/35718	(@xiaochengh, #35718)	script: Implement preparation-time document (#35718)
    # This PR implements the following as per spec:
    # > A [script](https://html.spec.whatwg.org/multipage/scripting.html#the-script-element) element has a preparation-time
    # document, which is either null or a [Document](https://html.spec.whatwg.org/multipage/dom.html#document), initially
    # null.  It is used to prevent scripts that move between documents during
    # [preparation](https://html.spec.whatwg.org/multipage/scripting.html#prepare-the-script-element) from
    # [executing](https://html.spec.whatwg.org/multipage/scripting.html#execute-the-script-element).
    dom
+https://github.com/servo/servo/pull/35713	(@kongbai1996, #35713)	add `cancelable` property to the `TouchEvent` (#35713)
    # add `cancelable` property to the `TouchEvent` set `cancellable = false` when sending move events to script, if the first
    # touch_move event did not cancel it
    dom
-https://github.com/servo/servo/pull/35743	(@yerke, #35743)	refactor: add CanGc as argument to methods in CSSGroupingRule, CSSKeyframesRule, Crypto (#35743)
    # Add CanGc as argument to methods in `CSSGroupingRule`, `CSSKeyframesRule`, `Crypto`.
    # Addressed part of https://github.com/servo/servo/issues/34573.
+https://github.com/servo/servo/pull/35740	(@webbeef, #35740)	Set a valid default value for the --userscripts command line option (#35740)
    # This prevents a crash when not specifying the path and matches the help message for that option.
    crash
>>> 2025-03-04T06:07:19Z
+https://github.com/servo/servo/pull/35701	(@mrobinson, @delan, #35701)	compositor: Make `PipelineDetails` and pending paint metrics per-WebView (#35701)
    # This is one of the first big steps toward making the compositor work per-WebView.  It moves the collection of pipelines
    # into the per-WebView data structure in the compositor as well as the pending paint metrics.
    # This means that more messages need to carry information about the WebView they apply to.  Note that there are still a
    # few places that we need to map from `PipelineId` to `WebViewId`, so this also includes a shared mapping which tracks
    # this.  The mapping can be removed once event handling is fully per-WebView.
    # Co-authored-by: Delan Azabani Signed-off-by: Martin Robinson
    webview
+https://github.com/servo/servo/pull/35782	(@Loirooriol, #35782)	Upgrade Stylo to 2025-03-01 (#35782)
    # This continues #35289
    # Changelog:
    #  - Upstream:
    #  https://github.com/servo/stylo/compare/3a069b37010ca2a55e6d41aa2f69bc5ee66bb0eb...42c338a67a96909aed5499c88fba1b265f437
    # 5d3
    #  - Servo fixups:
    #  https://github.com/servo/stylo/compare/c88e9e7ba3a63d360b155b6f159953b789fe444a...0190fff684fa7b67f5413a60f215e671b6222
    # 534
    # Stylo tracking issue: https://github.com/servo/stylo/issues/130
    upgrade
-https://github.com/servo/servo/pull/35778	(@dependabot[bot], @dependabot[bot], #35778)	build(deps): bump tokio-rustls from 0.26.1 to 0.26.2 (#35778)
    # Bumps [tokio-rustls](https://github.com/rustls/tokio-rustls) from 0.26.1 to 0.26.2.
    # Commits
    # See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=tokio-rustls&package-manager=c
    # argo&previous-version=0.26.1&new-version=0.26.2)](https://docs.github.com/en/github/managing-security-vulnerabilities/ab
    # out-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
https://github.com/servo/servo/pull/35780	(@dependabot[bot], @dependabot[bot], #35780)	build(deps): bump proc-macro2 from 1.0.93 to 1.0.94 (#35780)
    # Bumps [proc-macro2](https://github.com/dtolnay/proc-macro2) from 1.0.93 to 1.0.94.
    # Release notes Sourced from proc-macro2's releases.
    # 1.0.94
    # Documentation improvements
    # Commits
    # 7cb0f3c Release 1.0.94 23c425c Raise minimum tested compiler to rust 1.67 cbffe0c Ignore elidable_lifetime_names
    # pedantic clippy lint a12fe8b Point standard library links to stable 36920b1 Combine rustdoc semver exempt cfg into one
    # argument 3a9bc71 Convert html links to intra-doc links c7d999c Unset doc-scrape-examples for lib target 020a8ae Resolve
    # unnecessary_semicolon pedantic clippy lint 0a77455 Ignore WebAssembly linker warning ffc417a More precise gitignore
    # patterns Additional commits viewable in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=proc-macro2&package-manager=ca
    # rgo&previous-version=1.0.93&new-version=1.0.94)](https://docs.github.com/en/github/managing-security-vulnerabilities/abo
    # ut-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35779	(@dependabot[bot], @dependabot[bot], #35779)	build(deps): bump pin-project from 1.1.9 to 1.1.10 (#35779)
    # Bumps [pin-project](https://github.com/taiki-e/pin-project) from 1.1.9 to 1.1.10.
    # Release notes Sourced from pin-project's releases.
    # 1.1.10
    # Suppress clippy::elidable_lifetime_names lint in generated code.
    # Changelog Sourced from pin-project's changelog.
    # [1.1.10] - 2025-03-03
    # Suppress clippy::elidable_lifetime_names lint in generated code.
    # Commits
    # b0757d1 Release 1.1.10 12dfb3c Suppress clippy::elidable_lifetime_names lint in generated code 2714ef5 Tweak error
    # message 2454aed tools: Update scripts 29dac8c Revert &quot;Temporarily disable broken clippy::pedantic lint group&quot;
    # ee0cd59 Temporarily disable broken clippy::pedantic lint group aa6dbe2 rustfmt: set style_edition = &quot;2024&quot;
    # f49dc13 tools: Update tidy.sh 27ee733 tests: Update ui test output to nightly-2025-02-16 7a435d3 tests: Update lint test
    # Additional commits viewable in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=pin-project&package-manager=ca
    # rgo&previous-version=1.1.9&new-version=1.1.10)](https://docs.github.com/en/github/managing-security-vulnerabilities/abou
    # t-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35777	(@dependabot[bot], @dependabot[bot], #35777)	build(deps): bump serde_bytes from 0.11.15 to 0.11.16 (#35777)
    # Bumps [serde_bytes](https://github.com/serde-rs/bytes) from 0.11.15 to 0.11.16.
    # Release notes Sourced from serde_bytes's releases.
    # 0.11.16
    # Documentation improvements
    # Commits
    # f308f5e Release 0.11.16 a514507 Ignore elidable_lifetime_names pedantic clippy lint 31d681f Point standard library links
    # to stable 700aabb Unset doc-scrape-examples for lib target a77e4ca More precise gitignore patterns aece2be Remove
    # **/*.rs.bk from project-specific gitignore 07f078a Prevent upload-artifact step from causing CI failure 88a4dac Ignore
    # needless_lifetimes clippy lint 4dfc6e7 Resolve some needless_lifetimes clippy lints 527f91a Upload CI Cargo.lock for
    # reproducing failures Additional commits viewable in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=serde_bytes&package-manager=ca
    # rgo&previous-version=0.11.15&new-version=0.11.16)](https://docs.github.com/en/github/managing-security-vulnerabilities/a
    # bout-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35776	(@dependabot[bot], @dependabot[bot], #35776)	build(deps): bump quote from 1.0.38 to 1.0.39 (#35776)
    # Bumps [quote](https://github.com/dtolnay/quote) from 1.0.38 to 1.0.39.
    # Release notes Sourced from quote's releases.
    # 1.0.39
    # Documentation improvements
    # Commits
    # 7d089f5 Release 1.0.39 dd15f29 Ignore elidable_lifetime_names pedantic clippy lint b723616 Point standard library links
    # to stable ddbabd5 Convert html links to intra-doc links fa46189 Unset doc-scrape-examples for lib target 4d071e3 Resolve
    # doc_overindented_list_items clippy lint 908ddbd More precise gitignore patterns See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=quote&package-manager=cargo&pr
    # evious-version=1.0.38&new-version=1.0.39)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-dep
    # endabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35775	(@dependabot[bot], @dependabot[bot], #35775)	build(deps): bump bitflags from 2.8.0 to 2.9.0 (#35775)
    # Bumps [bitflags](https://github.com/bitflags/bitflags) from 2.8.0 to 2.9.0.
    # Release notes Sourced from bitflags's releases.
    # 2.9.0 What's Changed
    # Flags trait: add clear(&amp;mut self) method by @​wysiwys in bitflags/bitflags#437 Fix up UI tests by @​KodrAus in
    # bitflags/bitflags#438 Prepare for 2.9.0 release by @​KodrAus in bitflags/bitflags#439
    # Full Changelog: https://github.com/bitflags/bitflags/compare/2.8.0...2.9.0
    # Changelog Sourced from bitflags's changelog.
    # 2.9.0 What's Changed
    # Flags trait: add clear(&amp;mut self) method by @​wysiwys in bitflags/bitflags#437 Fix up UI tests by @​KodrAus in
    # bitflags/bitflags#438
    # Full Changelog: https://github.com/bitflags/bitflags/compare/2.8.0...2.9.0
    # Commits
    # e197bf5 Merge pull request #439 from KodrAus/cargo/2.9.0 8df6e80 prepare for 2.9.0 release e92f0ae Merge pull request
    # #438 from KodrAus/fix/ui-tests 226ff75 fix up UI tests 2170a26 Merge pull request #437 from
    # wysiwys/wysiwys/add-clear-method 76dde58 add tests for clear() trait method ce5d420 add clear() method to trait 9e45d36
    # Merge pull request #434 from bitflags/KodrAus-patch-1 617645a pin checkout action for miri job 2c836f2 Merge pull
    # request #433 from bitflags/ci/remove-scorecard Additional commits viewable in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=bitflags&package-manager=cargo
    # &previous-version=2.8.0&new-version=2.9.0)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-de
    # pendabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35773	(@dependabot[bot], @dependabot[bot], #35773)	build(deps): bump aws-lc-rs from 1.12.4 to 1.12.5 (#35773)
    # Bumps [aws-lc-rs](https://github.com/aws/aws-lc-rs) from 1.12.4 to 1.12.5.
    # Release notes Sourced from aws-lc-rs's releases.
    # aws-lc-rs v1.12.5 v1.12.5 What's Changed Bug fix
    # Support PKCS8 in agreement::PrivateKey::from_private_key_der by @​justsmth in aws/aws-lc-rs#713
    # Full Changelog: https://github.com/aws/aws-lc-rs/compare/v1.12.4...v1.12.5
    # Commits
    # ad169b3 Support PKCS8 in agreement::PrivateKey::from_private_key_der (#713) See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=aws-lc-rs&package-manager=carg
    # o&previous-version=1.12.4&new-version=1.12.5)](https://docs.github.com/en/github/managing-security-vulnerabilities/about
    # -dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35774	(@dependabot[bot], @dependabot[bot], #35774)	build(deps): bump syn from 2.0.98 to 2.0.99 (#35774)
    # Bumps [syn](https://github.com/dtolnay/syn) from 2.0.98 to 2.0.99.
    # Release notes Sourced from syn's releases.
    # 2.0.99
    # Documentation improvements
    # Commits
    # 4552057 Release 2.0.99 f4d8f0e Ignore elidable_lifetime_names pedantic clippy lint afbee2e Point standard library links
    # to stable fdbed64 Merge pull request #1848 from findepi/findepi/remove-obsolete-clippy-suppress...  88f0820 Remove
    # obsolete clippy suppressions 5357d54 Update test suite to nightly-2025-02-13 5cffd62 Update color-backtrace dependency
    # to 0.7 076ac95 Unset doc-scrape-examples for lib target af12bda Ignore format_push_string pedantic clippy lint f3614ce
    # Update test suite to nightly-2025-02-07 Additional commits viewable in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=syn&package-manager=cargo&prev
    # ious-version=2.0.98&new-version=2.0.99)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-depen
    # dabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35772	(@dependabot[bot], @dependabot[bot], #35772)	build(deps): bump anyhow from 1.0.96 to 1.0.97 (#35772)
    # Bumps [anyhow](https://github.com/dtolnay/anyhow) from 1.0.96 to 1.0.97.
    # Release notes Sourced from anyhow's releases.
    # 1.0.97
    # Documentation improvements
    # Commits
    # bfb89ef Release 1.0.97 c7fca9b Ignore elidable_lifetime_names pedantic clippy lint 427c0bb Point standard library links
    # to stable See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=anyhow&package-manager=cargo&p
    # revious-version=1.0.96&new-version=1.0.97)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-de
    # pendabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
https://github.com/servo/servo/pull/35763	(@kongbai1996, @schwenderjonathan@gmail.com, #35763)	Fix the problem that touchmove crashes occasionally. Fix crash when multiple touch cancels occur (#35763)
    # reason: During vsync message processing, the touchsequenceInfo is deleted if the last Fling is performed.  Then, the
    # touchmove processed message is received.  However, the touchsequenceInfo has been deleted at this time.  Therefore, the
    # touchsequenceInfo cannot be obtained, causing a crash.  resolution: Check whether touchSequenceInfo exists when
    # touch_sequence_map is modified in on_touch_event_processed.
    touch crash
+https://github.com/servo/servo/pull/35753	(@jdm, #35753)	script: Mark callback methods with CanGc. (#35753)
    # Callbacks can run arbitrary JS, so invoking one always comes with a risk of triggering a GC.
    # --- - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors - [x] These
    # changes do not require tests because they are compile-time only.
    dom crash
-https://github.com/servo/servo/pull/35764	(@simonwuelker, #35764)	Update rustfmt to the 2024 style edition (#35764)
    # Part of https://github.com/servo/servo/pull/35755
    # Note that this also reformats code in `third_party/` - I don't think there's a way around this, because `rustfmt` does
    # not support ignoring certain files [^1], or overriding the style edition for certain subdirectories.
    # [^1]: https://github.com/rust-lang/rustfmt/issues/3395
-https://github.com/servo/servo/pull/35717	(@mrobinson, #35717)	servoshell: Rename `Minibrowser::is_in_browser_rect` to `Minibrowser::is_in_egui_toolbar_rect` (#35717)
    # "browser rect" is a bit of a misnomer as the browser is the entire window, but this function is trying to determine if a
    # point is on the non-WebView toolbar portion of the GUI.
    # Signed-off-by: Martin Robinson
+https://github.com/servo/servo/pull/35742	(@leftmostcat@gmail.com, #35742)	script: Avoid double borrow crash on iframe focus (#35742)
    # When an iframe with an `onfocus` event is focused, servo will crash due to attempting a mutable borrow on an
    # already-borrowed `RefCell`.  Avoid this by providing a new root for the needed `Element` borrow.
    crash
>>> 2025-03-05T06:05:04Z
-https://github.com/servo/servo/pull/35771	(@dependabot[bot], @dependabot[bot], #35771)	build(deps): bump serde_json from 1.0.139 to 1.0.140 (#35771)
    # Bumps [serde_json](https://github.com/serde-rs/json) from 1.0.139 to 1.0.140.
    # Release notes Sourced from serde_json's releases.
    # v1.0.140
    # Documentation improvements
    # Commits
    # 7627834 Release 1.0.140 d77a498 Merge pull request #1245 from serde-rs/powerpc b34d317 Delete unused gcc installation
    # f7200c3 Ignore unbuffered_bytes clippy lint 76cd4fb Ignore elidable_lifetime_names pedantic clippy lint 400eaa9 Point
    # standard library links to stable See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=serde_json&package-manager=car
    # go&previous-version=1.0.139&new-version=1.0.140)](https://docs.github.com/en/github/managing-security-vulnerabilities/ab
    # out-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
+https://github.com/servo/servo/pull/35794	(@jschwe, #35794)	servoshell: Minor fixes to cli help. (#35794)
    # Fixes the `--pref` enable hint to use `_` instead of dots.  Remove `--prefs-file` from the hint, since the hint is
    # placed directly after the long option.  (The help line displayed as `--prefs-file --prefs-file /path/to/prefs.json`
    # before).
    # --- - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors - [x] These
    # changes improve the cli help output - [x] These changes do not require tests because: they adjust the cli help output.
    ux
+https://github.com/servo/servo/pull/35781	(@jschwe, #35781)	Reduce allocations in layout_block_level_children_in_parallel (#35781)
    # This function showed up as a top producer of allocations (around 10% of all allocations).  Allocating the vector once
    # upfront and using `collect_into_vec` removes any intermediate allocations.  This approach is also recommended by the
    # rayon documentation: https://docs.rs/rayon/1.10.0/rayon/iter/trait.ParallelIterator.html#method.collect
    # --- - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors - [x] These
    # changes reduce intermediate allocations
    performance
+https://github.com/servo/servo/pull/35785	(@kongbai1996, #35785)	Optimize IPC for non-cancelable touch events (#35785)
    # Reduce needless IPC with non-cancelable touch events.  If a touch event is not cancellable, no message is sent back to
    # the Compositor, since no action would be required anyway.
    # Add a warning log when prevent TouchsequenceInfo cannot be found.
    performance
+https://github.com/servo/servo/pull/35682	(@Loirooriol, #35682)	layout: Partial support for keyword sizes on preferred cross size (#35682)
    # This changes `FlexItem::content_cross_size` into `Size` to preserve keyword sizes.  The calculation of the hypothetical
    # cross size still ignores them though, that will be addressed in a follow-up.
    # Also, browsers don't follow the spec and treat a stretch size different than a stretch alignment: the former stretches
    # to the containing block, while the latter stretches to the line.  This aligns Servo with that behavior (following the
    # spec would require bigger refactorings), so `stretches()` is renamed to `stretches_to_line()` for clarity.
    css
>>> 2025-03-06T06:03:38Z
-https://github.com/servo/servo/pull/35804	(@jschwe, #35804)	hos CI: fix app bundlename (#35804)
    # In 78f7d525cc9d805731c2b99df4a57a754a5c9840 we renamed the app bundle.  This adapts the CI job to use the same name.
+https://github.com/servo/servo/pull/35716	(@delan, @mrobinson, #35716)	compositor: Make input event handling per-WebView (#35716)
    # This is another step in the move to having a per-WebView renderer.  In this step event handling is made per-WebView.
    # Most events sent to Servo are sent via the WebView API already, so this just moves more event handling code to the
    # per-WebView render portion of the compositor.
    # - ServoRenderer is given shared ownership and interior mutability as
    #   it is now shared among all WebView(Renderers).
    # - Some messages coming from other parts of Servo must now carry a
    #   WebViewId as well so that they can be associated with a particular WebView.
    # - There needs to be some reorganization of `ServoRenderer` in order to
    #   avoid issues with double borrow of `RefCells`.
    webview
-https://github.com/servo/servo/pull/35796	(@yerke, #35796)	refactor: add CanGc as argument to methods in CSSKeyframeRule, CSSMediaRule, CSSRule (#35796)
    # Add CanGc as argument to methods in `CSSKeyframeRule`, `CSSMediaRule`, `CSSRule`.
    # Addressed part of https://github.com/servo/servo/issues/34573.
+https://github.com/servo/servo/pull/35790	(@jschwe, #35790)	Rename ohos app bundle (#35790)
    # The `shell` suffix causes issues with the startup profiling tools on OpenHarmony.  The profiler fails to detect the
    # start of the app.  This is fixed by renaming the app.  I tried various different variations and identified the `shell`
    # suffix to be the culprit.  E.g.  `org.servo.shell` has the same issue, so it's not a length issue.
    # This does require users to regenerate signatures for the new app bundle name, which will lead to the HarmonyOS CI test
    # job temporarily failing (but it doesn't block the merge queue).
    # Edit: This would also break the OHOS nightly build, unless the signature file is updated too.
    ohos
+https://github.com/servo/servo/pull/35792	(@atbrakhi, #35792)	devtools: update targeted firefox version. (#35792)
    # Current version is old(130.0) and that is an unsupported setup and it can cause the DevTools to fail.  The minimum
    # supported version is (133.0a1)
    # Signedoff-by: atbrakhi
    devtools
-https://github.com/servo/servo/pull/35795	(@delan, #35795)	mach: Install Rust toolchain during bootstrap if needed (#35795)
    # In servo/ci-runners#27, we found that mach bootstrap was busted due to a “toolchain not installed” error.  This was
    # because rustup 1.28.0 (as well as the upcoming rustup 1.28.1 with RUSTUP_AUTO_INSTALL=0) no longer installs the Rust
    # toolchain when you try to use it for the first time (see rust-lang/rustup#3985, rust-lang/rustup#4211).
    # This patch explicitly installs the Rust toolchain during mach bootstrap.  Users that prefer RUSTUP_AUTO_INSTALL=0 will
    # need to rerun mach bootstrap whenever we bump our Rust version (rust-toolchain.toml).
>>> 2025-03-07T06:03:54Z
-https://github.com/servo/servo/pull/35820	(@dependabot[bot], @dependabot[bot], #35820)	build(deps): bump proc-macro-crate from 3.2.0 to 3.3.0 (#35820)
    # Bumps [proc-macro-crate](https://github.com/bkchr/proc-macro-crate) from 3.2.0 to 3.3.0.
    # Release notes Sourced from proc-macro-crate's releases.
    # v3.3.0 What's Changed
    # Disable display feature of toml-edit by @​zeenix in bkchr/proc-macro-crate#54 Fix use with Bazel by @​tronical in
    # bkchr/proc-macro-crate#55 Fix handling of inline tables by @​ijackson in bkchr/proc-macro-crate#58 Release v3.3.0 by
    # @​bkchr in bkchr/proc-macro-crate#59
    # New Contributors
    # @​zeenix made their first contribution in bkchr/proc-macro-crate#54 @​tronical made their first contribution in
    # bkchr/proc-macro-crate#55 @​ijackson made their first contribution in bkchr/proc-macro-crate#58
    # Full Changelog: https://github.com/bkchr/proc-macro-crate/compare/v3.2.0...v3.3.0
    # Commits
    # 5cd850c Merge pull request #59 from bkchr/bkchr-release-3.3.0 b44117e Release v3.3.0 88f5bf0 Merge pull request #58 from
    # ijackson/table 1bcfd88 FMT b11171a Update .github/workflows/rust.yml 1ded013 tests: One test of an inline table fe807ed
    # CI: check that we don't call toml_edit::Item::as_table a138066 fixup!  toml_edit tables: clippy.toml forbidden methods
    # 5ce9214 toml_edit tables: clippy.toml forbidden methods 51e8f0d toml_edit tables: Use TableLike and .as_table_like
    # Additional commits viewable in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=proc-macro-crate&package-manag
    # er=cargo&previous-version=3.2.0&new-version=3.3.0)](https://docs.github.com/en/github/managing-security-vulnerabilities/
    # about-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35819	(@dependabot[bot], @dependabot[bot], #35819)	build(deps): bump bytemuck from 1.21.0 to 1.22.0 (#35819)
    # Bumps [bytemuck](https://github.com/Lokathor/bytemuck) from 1.21.0 to 1.22.0.
    # Changelog Sourced from bytemuck's changelog.
    # bytemuck changelog 1.22
    # Add the pod_saturating feature, which adds Pod impls for Saturating&lt;T&gt; when T is already Pod.  A bump in the
    # minimum bytemuck_derive dependency from 1.4.0 to 1.4.1 to avoid a bug if you have a truly ancient cargo.lock file
    # sitting around.  Adds Send and Sync impls to BoxBytes.
    # 1.21
    # Implement Pod and Zeroable for core::arch::{x86, x86_64}::__m512, __m512d and __m512i without nightly.  Requires Rust
    # 1.72, and is gated through the avx512_simd cargo feature.  Allow the use of must_cast_mut and must_cast_slice_mut in
    # const contexts.  Requires Rust 1.83, and is gated through the must_cast_extra cargo feature.  internal: introduced the
    # maybe_const_fn macro that allows defining some function to be const depending upon some cfg predicate.
    # 1.20
    # New functions to allocate zeroed Arc and Rc.  Requires Rust 1.82 TransparentWrapper impls for core::cmp::Reverse and
    # core::num::Saturating.  internal: Simplified the library's fill_zeroes calls to write_bytes
    # 1.19
    # Adds the #[track_caller] attribute to functions which may panic.
    # 1.18
    # Adds the latest_stable_rust cargo feature, which is a blanket feature that turns all other features on that are both
    # sound and compatible with Stable rust.
    # 1.17.1
    # Adds #[repr(C)] to the union Transmute&lt;A, B&gt; type that's used internally for most of the transmutations.
    # 1.17.0
    # Makes the must_cast versions of the by-value and by-ref casts be const.  The mut ref cast is unaffected for now (mut
    # references aren't yet stable in const fn).  This increases the MSRV of using that particular feature from 1.57 to 1.64.
    # 1.16.3
    # Fully described in Lokathor/bytemuck#256, This makes casting slices to/from ZST elements more consistent between the
    # crate's core module and other modules.
    # ... (truncated)
    # Commits
    # d1d918b chore: Release bytemuck version 1.22.0 f48810f changelog.  ee2f71f Add pod_saturating feature (#303) e023695
    # bump bytemuck_derive dependency to &gt;= 1.4.1 (#301) 9ec593d Implement Send and Sync for BoxBytes.  (#299) 1f6afb3 Add
    # a pack1 as a related crate for packed integers etc.  (#296) c254af3 chore: Release bytemuck_derive version 1.9.0 417e989
    # fix changelog which cargo-release goofed because crates.io goofed.  d6cd76c chore: Release bytemuck_derive version 1.9.0
    # 95db6e1 changelog Additional commits viewable in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=bytemuck&package-manager=cargo
    # &previous-version=1.21.0&new-version=1.22.0)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-
    # dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35818	(@dependabot[bot], @dependabot[bot], #35818)	build(deps): bump rustversion from 1.0.19 to 1.0.20 (#35818)
    # Bumps [rustversion](https://github.com/dtolnay/rustversion) from 1.0.19 to 1.0.20.
    # Release notes Sourced from rustversion's releases.
    # 1.0.20
    # Documentation improvements
    # Commits
    # 4887012 Release 1.0.20 bb83b89 Merge pull request #58 from dtolnay/modern bc271d9 Modernize dates in docs and parse
    # errors c58d9bf Point standard library links to stable dfe5fcc More precise gitignore patterns 132031e Remove **/*.rs.bk
    # from project-specific gitignore See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=rustversion&package-manager=ca
    # rgo&previous-version=1.0.19&new-version=1.0.20)](https://docs.github.com/en/github/managing-security-vulnerabilities/abo
    # ut-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35817	(@dependabot[bot], @dependabot[bot], #35817)	build(deps): bump ryu from 1.0.19 to 1.0.20 (#35817)
    # Bumps [ryu](https://github.com/dtolnay/ryu) from 1.0.19 to 1.0.20.
    # Release notes Sourced from ryu's releases.
    # 1.0.20
    # Documentation improvements
    # Commits
    # 02237f8 Release 1.0.20 d6d5367 Point standard library links to stable ce04e72 Convert html links to intra-doc links
    # f030f26 Unset doc-scrape-examples for lib target See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=ryu&package-manager=cargo&prev
    # ious-version=1.0.19&new-version=1.0.20)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-depen
    # dabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35814	(@dependabot[bot], @dependabot[bot], #35814)	build(deps): bump semver from 1.0.25 to 1.0.26 (#35814)
    # Bumps [semver](https://github.com/dtolnay/semver) from 1.0.25 to 1.0.26.
    # Release notes Sourced from semver's releases.
    # 1.0.26
    # Documentation improvements
    # Commits
    # 3e64fdb Release 1.0.26 dd8dc0a Point standard library links to stable 479518d Unset doc-scrape-examples for lib target
    # 4fa7acb More precise gitignore patterns See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=semver&package-manager=cargo&p
    # revious-version=1.0.25&new-version=1.0.26)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-de
    # pendabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35815	(@dependabot[bot], @dependabot[bot], #35815)	build(deps): bump time from 0.3.37 to 0.3.39 (#35815)
    # Bumps [time](https://github.com/time-rs/time) from 0.3.37 to 0.3.39.
    # Release notes Sourced from time's releases.
    # v0.3.39 See the changelog for details.  v0.3.38 See the changelog for details.
    # Changelog Sourced from time's changelog.
    # 0.3.39 [2025-03-06] Fixed
    # Doc tests run successfully with the default feature set.  wasm builds work again.
    # Both of these were regressions in v0.3.38 and are now checked in CI.  0.3.38 [2025-03-05] Added
    # The [year] component (in format descriptions) now supports a range modifier, which can be either standard or extended.
    # The default is extended for backwards compatibility.  This is intended as a manner to opt out of the extended range when
    # the large-dates feature is enabled.  When the large-dates feature is not enabled, the modifier has no effect.
    # UtcDateTime, which is semantically equivalent to an OffsetDateTime with UTC as its offset.  The advantage is that it is
    # the same size as a PrimitiveDateTime and has improved operability with well-known formats.  As part of this, there were
    # some other additions:
    # utc_datetime!  macro, which is similar to the datetime!  macro but constructs a UtcDateTime.  PrimitiveDateTime::as_utc
    # OffsetDateTime::to_utc OffsetDateTime::checked_to_utc
    # time::serde::timestamp::milliseconds_i64, which is a module to serialize/deserialize timestamps as the Unix timestamp.
    # The pre-existing module does this as an i128 where an i64 would suffice.  This new module should be preferred.
    # Changed
    # error::Format has had its source() implementation changed to no longer return a boxed value from the ComponentRange
    # variant.  If you were explicitly expecting this, you will need to update your code.  The method API remains unchanged.
    # [year repr:century] supports single-digit values.  All format_into methods accept ?Sized references.
    # Miscellaneous
    # Some non-exhaustive enum variants that are no longer used have been modified to be statically proven as uninhabited.
    # The relevant fields are doc-hidden and not semver-guaranteed to remain as such, though it is unlikely to change.  An
    # unnecessary check when parsing RFC 2822 has been removed.  Various methods have had their implementations changed,
    # resulting in significant performance gains.  Among the methods changed are
    # util::is_leap_year util::weeks_in_year Month::length Date::to_calendar_date
    # ... (truncated)
    # Commits
    # 7949d2c v0.3.39 release f51623b Fix breakage from v0.3.38 1a31c05 v0.3.38 release addf231 Permit unsized writers for
    # format_into 338f84f Allow clippy::ref_option lint for serde::format_description.  f8ecd81 feat:
    # timestamp::milliseconds_i64 serializer ce03bca Update Unicode license for cargo-audit 3d0b981 Add parentheses for
    # clarity 3096301 Remove specific year from license ec327a2 Optimize Julian day calculations Additional commits viewable
    # in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=time&package-manager=cargo&pre
    # vious-version=0.3.37&new-version=0.3.39)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-depe
    # ndabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35813	(@dependabot[bot], @dependabot[bot], #35813)	build(deps): bump epaint_default_fonts from 0.31.0 to 0.31.1 (#35813)
    # Bumps [epaint_default_fonts](https://github.com/emilk/egui) from 0.31.0 to 0.31.1.
    # Release notes Sourced from epaint_default_fonts's releases.
    # 0.31.1 - TextEdit and egui_kittest fixes egui is an easy-to-use immediate mode GUI for Rust that runs on both web and
    # native.  Try it now: https://www.egui.rs/ egui development is sponsored by Rerun, a startup building an SDK for
    # visualizing streams of multimodal data.  egui
    # Fix sizing bug in TextEdit::singleline #5640 by @​IaVashik Fix panic when rendering thin textured rectangles #5692 by
    # @​PPakalns
    # egui_extras
    # Fix image_loader for animated image types #5688 by @​BSteffaniak
    # egui_kittest
    # Fix modifiers not working in kittest #5693 by @​lucasmerlin Enable all features for egui_kittest docs #5711 by
    # @​YgorSouza Run a frame per queued event in egui_kittest #5704 by @​lucasmerlin Add guidelines for image comparison
    # tests #5714 by @​Wumpf
    # epaint
    # Fix panic when rendering thin textured rectangles #5692 by @​PPakalns
    # Changelog Sourced from epaint_default_fonts's changelog.
    # 0.31.1 - 2025-03-05
    # Fix sizing bug in TextEdit::singleline #5640 by @​IaVashik Fix panic when rendering thin textured rectangles #5692 by
    # @​PPakalns
    # Commits
    # 1669e52 Release 0.31.1 - text_edit and kittest fixes b32fc71 Add guidelines for image comparison tests (#5714) c58aa8f
    # Add badges to kittest README.md 2d37f1a Fix panic when rendering thin textured rectangles (#5692) bc2d370 Fix sizing bug
    # in TextEdit::singleline (#5640) a872446 Fix image_loader for animated image types (#5688) 5b47b80 Run a frame per queued
    # event in egui_kittest (#5704) 97cb07a Enable all features for egui_kittest docs (#5711) 45df656 Fix modifiers not
    # working in kittest (#5693) See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=epaint_default_fonts&package-m
    # anager=cargo&previous-version=0.31.0&new-version=0.31.1)](https://docs.github.com/en/github/managing-security-vulnerabil
    # ities/about-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35811	(@dependabot[bot], @dependabot[bot], #35811)	build(deps): bump dtoa from 1.0.9 to 1.0.10 (#35811)
    # Bumps [dtoa](https://github.com/dtolnay/dtoa) from 1.0.9 to 1.0.10.
    # Release notes Sourced from dtoa's releases.
    # 1.0.10
    # Documentation improvements
    # Commits
    # f51ccb5 Release 1.0.10 89062a2 Point standard library links to stable efb2984 Convert html links to intra-doc links
    # 78a970e Unset doc-scrape-examples for lib target 8448e87 More precise gitignore patterns d020388 Ignore
    # cast_precision_loss pedantic clippy lint 3f8e970 Ignore cast_possible_wrap pedantic clippy lint 6d41c5c Revert
    # &quot;Temporarily disable miri on doctests&quot; 964c7fb Temporarily disable miri on doctests 566db4e Remove 'remember
    # to update' reminder from Cargo.toml Additional commits viewable in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=dtoa&package-manager=cargo&pre
    # vious-version=1.0.9&new-version=1.0.10)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-depen
    # dabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35812	(@dependabot[bot], @dependabot[bot], #35812)	build(deps): bump unicode-ident from 1.0.17 to 1.0.18 (#35812)
    # Bumps [unicode-ident](https://github.com/dtolnay/unicode-ident) from 1.0.17 to 1.0.18.
    # Release notes Sourced from unicode-ident's releases.
    # 1.0.18
    # Documentation improvements
    # Commits
    # 93ab72c Release 1.0.18 d4de098 Point standard library links to stable See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=unicode-ident&package-manager=
    # cargo&previous-version=1.0.17&new-version=1.0.18)](https://docs.github.com/en/github/managing-security-vulnerabilities/a
    # bout-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35810	(@dependabot[bot], @dependabot[bot], #35810)	build(deps): bump the egui-related group with 5 updates (#35810)
    # Bumps the egui-related group with 5 updates:
    # | Package | From | To | | --- | --- | --- | | [egui](https://github.com/emilk/egui) | `0.31.0` | `0.31.1` | |
    # [egui-winit](https://github.com/emilk/egui) | `0.31.0` | `0.31.1` | | [ecolor](https://github.com/emilk/egui) | `0.31.0`
    # | `0.31.1` | | [emath](https://github.com/emilk/egui) | `0.31.0` | `0.31.1` | | [epaint](https://github.com/emilk/egui)
    # | `0.31.0` | `0.31.1` |
    # Updates `egui` from 0.31.0 to 0.31.1
    # Release notes Sourced from egui's releases.
    # 0.31.1 - TextEdit and egui_kittest fixes egui is an easy-to-use immediate mode GUI for Rust that runs on both web and
    # native.  Try it now: https://www.egui.rs/ egui development is sponsored by Rerun, a startup building an SDK for
    # visualizing streams of multimodal data.  egui
    # Fix sizing bug in TextEdit::singleline #5640 by @​IaVashik Fix panic when rendering thin textured rectangles #5692 by
    # @​PPakalns
    # egui_extras
    # Fix image_loader for animated image types #5688 by @​BSteffaniak
    # egui_kittest
    # Fix modifiers not working in kittest #5693 by @​lucasmerlin Enable all features for egui_kittest docs #5711 by
    # @​YgorSouza Run a frame per queued event in egui_kittest #5704 by @​lucasmerlin Add guidelines for image comparison
    # tests #5714 by @​Wumpf
    # epaint
    # Fix panic when rendering thin textured rectangles #5692 by @​PPakalns
    # Changelog Sourced from egui's changelog.
    # 0.31.1 - 2025-03-05
    # Fix sizing bug in TextEdit::singleline #5640 by @​IaVashik Fix panic when rendering thin textured rectangles #5692 by
    # @​PPakalns
    # Commits
    # 1669e52 Release 0.31.1 - text_edit and kittest fixes b32fc71 Add guidelines for image comparison tests (#5714) c58aa8f
    # Add badges to kittest README.md 2d37f1a Fix panic when rendering thin textured rectangles (#5692) bc2d370 Fix sizing bug
    # in TextEdit::singleline (#5640) a872446 Fix image_loader for animated image types (#5688) 5b47b80 Run a frame per queued
    # event in egui_kittest (#5704) 97cb07a Enable all features for egui_kittest docs (#5711) 45df656 Fix modifiers not
    # working in kittest (#5693) See full diff in compare view
    # Updates `egui-winit` from 0.31.0 to 0.31.1
    # Release notes Sourced from egui-winit's releases.
    # 0.31.1 - TextEdit and egui_kittest fixes egui is an easy-to-use immediate mode GUI for Rust that runs on both web and
    # native.  Try it now: https://www.egui.rs/ egui development is sponsored by Rerun, a startup building an SDK for
    # visualizing streams of multimodal data.  egui
    # Fix sizing bug in TextEdit::singleline #5640 by @​IaVashik Fix panic when rendering thin textured rectangles #5692 by
    # @​PPakalns
    # egui_extras
    # Fix image_loader for animated image types #5688 by @​BSteffaniak
    # egui_kittest
    # Fix modifiers not working in kittest #5693 by @​lucasmerlin Enable all features for egui_kittest docs #5711 by
    # @​YgorSouza Run a frame per queued event in egui_kittest #5704 by @​lucasmerlin Add guidelines for image comparison
    # tests #5714 by @​Wumpf
    # epaint
    # Fix panic when rendering thin textured rectangles #5692 by @​PPakalns
    # Changelog Sourced from egui-winit's changelog.
    # 0.31.1 - 2025-03-05
    # Fix sizing bug in TextEdit::singleline #5640 by @​IaVashik Fix panic when rendering thin textured rectangles #5692 by
    # @​PPakalns
    # Commits
    # 1669e52 Release 0.31.1 - text_edit and kittest fixes b32fc71 Add guidelines for image comparison tests (#5714) c58aa8f
    # Add badges to kittest README.md 2d37f1a Fix panic when rendering thin textured rectangles (#5692) bc2d370 Fix sizing bug
    # in TextEdit::singleline (#5640) a872446 Fix image_loader for animated image types (#5688) 5b47b80 Run a frame per queued
    # event in egui_kittest (#5704) 97cb07a Enable all features for egui_kittest docs (#5711) 45df656 Fix modifiers not
    # working in kittest (#5693) See full diff in compare view
    # Updates `ecolor` from 0.31.0 to 0.31.1
    # Release notes Sourced from ecolor's releases.
    # 0.31.1 - TextEdit and egui_kittest fixes egui is an easy-to-use immediate mode GUI for Rust that runs on both web and
    # native.  Try it now: https://www.egui.rs/ egui development is sponsored by Rerun, a startup building an SDK for
    # visualizing streams of multimodal data.  egui
    # Fix sizing bug in TextEdit::singleline #5640 by @​IaVashik Fix panic when rendering thin textured rectangles #5692 by
    # @​PPakalns
    # egui_extras
    # Fix image_loader for animated image types #5688 by @​BSteffaniak
    # egui_kittest
    # Fix modifiers not working in kittest #5693 by @​lucasmerlin Enable all features for egui_kittest docs #5711 by
    # @​YgorSouza Run a frame per queued event in egui_kittest #5704 by @​lucasmerlin Add guidelines for image comparison
    # tests #5714 by @​Wumpf
    # epaint
    # Fix panic when rendering thin textured rectangles #5692 by @​PPakalns
    # Changelog Sourced from ecolor's changelog.
    # 0.31.1 - 2025-03-05
    # Fix sizing bug in TextEdit::singleline #5640 by @​IaVashik Fix panic when rendering thin textured rectangles #5692 by
    # @​PPakalns
    # Commits
    # 1669e52 Release 0.31.1 - text_edit and kittest fixes b32fc71 Add guidelines for image comparison tests (#5714) c58aa8f
    # Add badges to kittest README.md 2d37f1a Fix panic when rendering thin textured rectangles (#5692) bc2d370 Fix sizing bug
    # in TextEdit::singleline (#5640) a872446 Fix image_loader for animated image types (#5688) 5b47b80 Run a frame per queued
    # event in egui_kittest (#5704) 97cb07a Enable all features for egui_kittest docs (#5711) 45df656 Fix modifiers not
    # working in kittest (#5693) See full diff in compare view
    # Updates `emath` from 0.31.0 to 0.31.1
    # Release notes Sourced from emath's releases.
    # 0.31.1 - TextEdit and egui_kittest fixes egui is an easy-to-use immediate mode GUI for Rust that runs on both web and
    # native.  Try it now: https://www.egui.rs/ egui development is sponsored by Rerun, a startup building an SDK for
    # visualizing streams of multimodal data.  egui
    # Fix sizing bug in TextEdit::singleline #5640 by @​IaVashik Fix panic when rendering thin textured rectangles #5692 by
    # @​PPakalns
    # egui_extras
    # Fix image_loader for animated image types #5688 by @​BSteffaniak
    # egui_kittest
    # Fix modifiers not working in kittest #5693 by @​lucasmerlin Enable all features for egui_kittest docs #5711 by
    # @​YgorSouza Run a frame per queued event in egui_kittest #5704 by @​lucasmerlin Add guidelines for image comparison
    # tests #5714 by @​Wumpf
    # epaint
    # Fix panic when rendering thin textured rectangles #5692 by @​PPakalns
    # Changelog Sourced from emath's changelog.
    # 0.31.1 - 2025-03-05
    # Fix sizing bug in TextEdit::singleline #5640 by @​IaVashik Fix panic when rendering thin textured rectangles #5692 by
    # @​PPakalns
    # Commits
    # 1669e52 Release 0.31.1 - text_edit and kittest fixes b32fc71 Add guidelines for image comparison tests (#5714) c58aa8f
    # Add badges to kittest README.md 2d37f1a Fix panic when rendering thin textured rectangles (#5692) bc2d370 Fix sizing bug
    # in TextEdit::singleline (#5640) a872446 Fix image_loader for animated image types (#5688) 5b47b80 Run a frame per queued
    # event in egui_kittest (#5704) 97cb07a Enable all features for egui_kittest docs (#5711) 45df656 Fix modifiers not
    # working in kittest (#5693) See full diff in compare view
    # Updates `epaint` from 0.31.0 to 0.31.1
    # Release notes Sourced from epaint's releases.
    # 0.31.1 - TextEdit and egui_kittest fixes egui is an easy-to-use immediate mode GUI for Rust that runs on both web and
    # native.  Try it now: https://www.egui.rs/ egui development is sponsored by Rerun, a startup building an SDK for
    # visualizing streams of multimodal data.  egui
    # Fix sizing bug in TextEdit::singleline #5640 by @​IaVashik Fix panic when rendering thin textured rectangles #5692 by
    # @​PPakalns
    # egui_extras
    # Fix image_loader for animated image types #5688 by @​BSteffaniak
    # egui_kittest
    # Fix modifiers not working in kittest #5693 by @​lucasmerlin Enable all features for egui_kittest docs #5711 by
    # @​YgorSouza Run a frame per queued event in egui_kittest #5704 by @​lucasmerlin Add guidelines for image comparison
    # tests #5714 by @​Wumpf
    # epaint
    # Fix panic when rendering thin textured rectangles #5692 by @​PPakalns
    # Changelog Sourced from epaint's changelog.
    # 0.31.1 - 2025-03-05
    # Fix sizing bug in TextEdit::singleline #5640 by @​IaVashik Fix panic when rendering thin textured rectangles #5692 by
    # @​PPakalns
    # Commits
    # 1669e52 Release 0.31.1 - text_edit and kittest fixes b32fc71 Add guidelines for image comparison tests (#5714) c58aa8f
    # Add badges to kittest README.md 2d37f1a Fix panic when rendering thin textured rectangles (#5692) bc2d370 Fix sizing bug
    # in TextEdit::singleline (#5640) a872446 Fix image_loader for animated image types (#5688) 5b47b80 Run a frame per queued
    # event in egui_kittest (#5704) 97cb07a Enable all features for egui_kittest docs (#5711) 45df656 Fix modifiers not
    # working in kittest (#5693) See full diff in compare view
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
+https://github.com/servo/servo/pull/35769	(@simonwuelker, #35769)	Let layout invalidations happen in the flat tree (#35769)
    # Layout invalidation currently happens on the regular dom.  That is incorrect and we should use the flat tree instead.
    # The flat tree is equivalent to the DOM, except for the following: * Assigned slottables are children of their slots (and
    # their slot is their parent) * Children of shadow roots are children of their hosts (and the hosts are their parents)
    # For example, when an assigned slottable becomes dirty then we want to mark its assigned slot as dirty, not it's parent.
    layout dom
-https://github.com/servo/servo/pull/35807	(@jschwe, #35807)	hos CI: fix checking success (#35807)
    # In #35804 we fixed the bundlename, but I assumed the servoshell in the grep expression was referring to the libraryname.
    # As it turns out the tracelines start with the bundlename, so we need to update this name too.  This is the last line in
    # the hos CI, and the grep expression works locally so this time CI should really be fixed.  As already mentioned in the
    # previous PR, we can't really test this well, since this job only runs on self-hosted runners, which check out the github
    # action yaml version from the main branch.
    # --- - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors - [x] These
    # changes fix hos ci.
>>> 2025-03-08T05:59:57Z
-https://github.com/servo/servo/pull/35861	(@webbeef, #35861)	Remove obsolete memory profiler console output (#35861)
    # As agreed on Zulip.  cc @jdm
+https://github.com/servo/servo/pull/35816	(@Loirooriol, #35816)	layout: Assert that `hypothetical_cross_size` is already correct (#35816)
    # There doesn't seem to be a need to recompute it.
    performance
-https://github.com/servo/servo/pull/35855	(@dependabot[bot], @dependabot[bot], #35855)	build(deps): bump is-terminal from 0.4.15 to 0.4.16 (#35855)
    # Bumps [is-terminal](https://github.com/sunfishcode/is-terminal) from 0.4.15 to 0.4.16.
    # Commits
    # 4a18365 chore: Release is-terminal version 0.4.16 ee36d99 Update to dev-dependencies rustix 1.0, and hermit-abi 0.5.
    # See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=is-terminal&package-manager=ca
    # rgo&previous-version=0.4.15&new-version=0.4.16)](https://docs.github.com/en/github/managing-security-vulnerabilities/abo
    # ut-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35853	(@dependabot[bot], @dependabot[bot], #35853)	build(deps): bump itoa from 1.0.14 to 1.0.15 (#35853)
    # Bumps [itoa](https://github.com/dtolnay/itoa) from 1.0.14 to 1.0.15.
    # Release notes Sourced from itoa's releases.
    # 1.0.15
    # Documentation improvements
    # Commits
    # e2766b8 Release 1.0.15 a136ce8 Point standard library links to stable ecc7fae Convert html links to intra-doc links
    # 94fea8f Unset doc-scrape-examples for lib target 758499d More precise gitignore patterns See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=itoa&package-manager=cargo&pre
    # vious-version=1.0.14&new-version=1.0.15)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-depe
    # ndabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35852	(@dependabot[bot], @dependabot[bot], #35852)	build(deps): bump prettyplease from 0.2.29 to 0.2.30 (#35852)
    # Bumps [prettyplease](https://github.com/dtolnay/prettyplease) from 0.2.29 to 0.2.30.
    # Release notes Sourced from prettyplease's releases.
    # 0.2.30
    # Documentation improvements
    # Commits
    # 8e721e6 Release 0.2.30 b206eae Point standard library links to stable 148c065 Unset doc-scrape-examples for lib target
    # 182b7c2 More precise gitignore patterns See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=prettyplease&package-manager=c
    # argo&previous-version=0.2.29&new-version=0.2.30)](https://docs.github.com/en/github/managing-security-vulnerabilities/ab
    # out-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35857	(@dependabot[bot], @dependabot[bot], #35857)	build(deps): bump pkg-config from 0.3.31 to 0.3.32 (#35857)
    # Bumps [pkg-config](https://github.com/rust-lang/pkg-config-rs) from 0.3.31 to 0.3.32.
    # Changelog Sourced from pkg-config's changelog.
    # [0.3.32] - 2025-03-03 Fixed
    # Suggest installing pkgconf via homebrew on macOS instead of pkg-config (#173)
    # Quote failed pkg-config command correctly in error messages to allow for directly copy&amp;pasting it into a shell
    # (#175)
    # Commits
    # d75288f Merge pull request #177 from rust-lang/release-0.3.32 1ced396 Release 0.3.32 86e0896 Merge pull request #173
    # from chenrui333/patch-1 3314c8d Merge pull request #175 from awilfox/awilfox/fix-version-param-output 3a63f27 Quote
    # WrappedCommand arguments with spaces in them 90743f8 support linuxbrew 15a342f add pr feedback 3c2aa27 remove iOS target
    # from pkg-config installation instructions as Homebrew does ...  19cdc2d Use pkgconf instead of pkg-config for brew
    # builds See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=pkg-config&package-manager=car
    # go&previous-version=0.3.31&new-version=0.3.32)](https://docs.github.com/en/github/managing-security-vulnerabilities/abou
    # t-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35846	(@dependabot[bot], @dependabot[bot], #35846)	build(deps): bump httparse from 1.10.0 to 1.10.1 (#35846)
    # Bumps [httparse](https://github.com/seanmonstar/httparse) from 1.10.0 to 1.10.1.
    # Release notes Sourced from httparse's releases.
    # v1.10.1 What's Changed
    # fix(swar): utf8 support by @​nikneym in seanmonstar/httparse#205
    # New Contributors
    # @​nikneym made their first contribution in seanmonstar/httparse#203
    # Full Changelog: https://github.com/seanmonstar/httparse/compare/v1.10.0...v1.10.1
    # Commits
    # 9f29e79 v1.10.1 11a86d1 fix(swar): utf8 support (#205) 36c38e5 docs: document the AVX2 instructions (#203) 876d08c ci:
    # upgrade fuzz job to upload-artifact v4 (#204) See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=httparse&package-manager=cargo
    # &previous-version=1.10.0&new-version=1.10.1)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-
    # dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35845	(@dependabot[bot], @dependabot[bot], #35845)	build(deps): bump bytes from 1.10.0 to 1.10.1 (#35845)
    # Bumps [bytes](https://github.com/tokio-rs/bytes) from 1.10.0 to 1.10.1.
    # Release notes Sourced from bytes's releases.
    # Bytes v1.10.1 1.10.1 (March 5th, 2025) Fixed
    # Fix memory leak when using to_vec with Bytes::from_owner (#773)
    # #773: tokio-rs/bytes#773
    # Changelog Sourced from bytes's changelog.
    # 1.10.1 (March 5th, 2025) Fixed
    # Fix memory leak when using to_vec with Bytes::from_owner (#773)
    # Commits
    # 19d1427 chore: prepare bytes v1.10.1 (#774) 3667543 Fix memory leak in owned_to_vec (#773) See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=bytes&package-manager=cargo&pr
    # evious-version=1.10.0&new-version=1.10.1)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-dep
    # endabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
+https://github.com/servo/servo/pull/35808	(@HastD, #35808)	layout: Make `transform-style: preserve-3d` establish a containing block for all descendants (#35808)
    # This makes `transform-style: preserve-3d` establish a containing block for all descendants, as specified here:
    # (This is my first time contributing to Servo; I think I followed the instructions properly but let me know if there's
    # anything I need to fix.)
    # -----
    # - [X] `./mach build -d` does not report any errors - [X] `./mach test-tidy` does not report any errors - [X] These
    # changes fix #35801 and #35824 - [x] There are tests for these changes
    css
-https://github.com/servo/servo/pull/35854	(@Loirooriol, #35854)	Ignore RUSTSEC-2024-0436 (crate `paste` is unmaintained) (#35854)
    # Unblock CI for now, filed #35856 to take care of the actual problem.
-https://github.com/servo/servo/pull/35844	(@dependabot[bot], @dependabot[bot], #35844)	build(deps): bump oorandom from 11.1.4 to 11.1.5 (#35844)
    # Bumps oorandom from 11.1.4 to 11.1.5.
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=oorandom&package-manager=cargo
    # &previous-version=11.1.4&new-version=11.1.5)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-
    # dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35843	(@dependabot[bot], @dependabot[bot], #35843)	build(deps): bump content-security-policy from 0.5.3 to 0.5.4 (#35843)
    # Bumps [content-security-policy](https://github.com/rust-ammonia/rust-content-security-policy) from 0.5.3 to 0.5.4.
    # Release notes Sourced from content-security-policy's releases.
    # 0.5.4
    # Minimum supported Rust version: 1.81.0 chore: bump base64 dependency Fix strict-dynamic handling on non-parser-inserted
    # &lt;script&gt;
    # Changelog Sourced from content-security-policy's changelog.
    # 0.5.4
    # Minimum supported Rust version: 1.81.0 chore: bump base64 dependency Fix strict-dynamic handling on non-parser-inserted
    # &lt;script&gt;
    # Commits
    # 20312b8 Merge pull request #53 from notriddle/release-0.5.4 74d3356 Release 0.5.4 9206fa0 Allow script requests
    # triggered by non-parser inserted &lt;script&gt; elements if s...  See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=content-security-policy&packag
    # e-manager=cargo&previous-version=0.5.3&new-version=0.5.4)](https://docs.github.com/en/github/managing-security-vulnerabi
    # lities/about-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35842	(@dependabot[bot], @dependabot[bot], #35842)	build(deps): bump ring from 0.17.11 to 0.17.13 (#35842)
    # Bumps [ring](https://github.com/briansmith/ring) from 0.17.11 to 0.17.13.
    # Changelog Sourced from ring's changelog.
    # Version 0.17.13 (2025-03-06) Increased MSRV to 1.66.0 to avoid bugs in earlier versions so that we can safely use
    # core::arch::x86_64::__cpuid and core::arch::x86::__cpuid from Rust in future releases.  AVX2-based VAES-CLMUL
    # implementation.  This will be a notable performance improvement for most newish x86-64 systems.  This will likely raise
    # the minimum binutils version supported for very old Linux distros.  Version 0.17.12 (2025-03-05) Bug fix:
    # briansmith/ring#2447 for denial of service (DoS).
    # Fixes a panic in ring::aead::quic::HeaderProtectionKey::new_mask() when integer overflow checking is enabled.  In the
    # QUIC protocol, an attacker can induce this panic by sending a specially-crafted packet.  Even unintentionally it is
    # likely to occur in 1 out of every 2**32 packets sent and/or received.
    # Fixes a panic on 64-bit targets in ring::aead::{AES_128_GCM, AES_256_GCM} when overflow checking is enabled, when
    # encrypting/decrypting approximately 68,719,476,700 bytes (about 64 gigabytes) of data in a single chunk.  Protocols like
    # TLS and SSH are not affected by this because those protocols break large amounts of data into small chunks.  Similarly,
    # most applications will not attempt to encrypt/decrypt 64GB of data in one chunk.
    # Overflow checking is not enabled in release mode by default, but RUSTFLAGS=&quot;-C overflow-checks&quot; or
    # overflow-checks = true in the Cargo.toml profile can override this.  Overflow checking is usually enabled by default in
    # debug mode.
    # Commits
    # See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=ring&package-manager=cargo&pre
    # vious-version=0.17.11&new-version=0.17.13)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-de
    # pendabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35838	(@dependabot[bot], @dependabot[bot], #35838)	build(deps): bump egui_glow in the egui-related group (#35838)
    # Bumps the egui-related group with 1 update: [egui_glow](https://github.com/emilk/egui).
    # Updates `egui_glow` from 0.31.0 to 0.31.1
    # Release notes Sourced from egui_glow's releases.
    # 0.31.1 - TextEdit and egui_kittest fixes egui is an easy-to-use immediate mode GUI for Rust that runs on both web and
    # native.  Try it now: https://www.egui.rs/ egui development is sponsored by Rerun, a startup building an SDK for
    # visualizing streams of multimodal data.  egui
    # Fix sizing bug in TextEdit::singleline #5640 by @​IaVashik Fix panic when rendering thin textured rectangles #5692 by
    # @​PPakalns
    # egui_extras
    # Fix image_loader for animated image types #5688 by @​BSteffaniak
    # egui_kittest
    # Fix modifiers not working in kittest #5693 by @​lucasmerlin Enable all features for egui_kittest docs #5711 by
    # @​YgorSouza Run a frame per queued event in egui_kittest #5704 by @​lucasmerlin Add guidelines for image comparison
    # tests #5714 by @​Wumpf
    # epaint
    # Fix panic when rendering thin textured rectangles #5692 by @​PPakalns
    # Changelog Sourced from egui_glow's changelog.
    # 0.31.1 - 2025-03-05
    # Fix sizing bug in TextEdit::singleline #5640 by @​IaVashik Fix panic when rendering thin textured rectangles #5692 by
    # @​PPakalns
    # Commits
    # 1669e52 Release 0.31.1 - text_edit and kittest fixes b32fc71 Add guidelines for image comparison tests (#5714) c58aa8f
    # Add badges to kittest README.md 2d37f1a Fix panic when rendering thin textured rectangles (#5692) bc2d370 Fix sizing bug
    # in TextEdit::singleline (#5640) a872446 Fix image_loader for animated image types (#5688) 5b47b80 Run a frame per queued
    # event in egui_kittest (#5704) 97cb07a Enable all features for egui_kittest docs (#5711) 45df656 Fix modifiers not
    # working in kittest (#5693) See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=egui_glow&package-manager=carg
    # o&previous-version=0.31.0&new-version=0.31.1)](https://docs.github.com/en/github/managing-security-vulnerabilities/about
    # -dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35840	(@dependabot[bot], @dependabot[bot], #35840)	build(deps): bump android_logger from 0.14.1 to 0.15.0 (#35840)
    # Bumps [android_logger](https://github.com/rust-mobile/android_logger-rs) from 0.14.1 to 0.15.0.
    # Release notes Sourced from android_logger's releases.
    # v0.15.0 What's Changed
    # Only provide docs.rs pages for Android targets by @​MarijnS95 in rust-mobile/android_logger-rs#77 cargo: Add
    # os::android-apis category by @​MarijnS95 in rust-mobile/android_logger-rs#78 Prevent truncating log tag name by
    # @​dextero in rust-mobile/android_logger-rs#83 Replace CStr::from_ptr() with CStr::from_bytes_with_nul() by @​MarijnS95
    # in rust-mobile/android_logger-rs#82 Derive/implement Debug for Config and AndroidLogger by @​MarijnS95 in
    # rust-mobile/android_logger-rs#81 Split things into different files, to optimize future work by @​Nercury in
    # rust-mobile/android_logger-rs#85 ci: Run cargo fmt --check to ensure code is always properly formatted by @​MarijnS95 in
    # rust-mobile/android_logger-rs#86 Use __android_log_is_loggable in AndroidLogger::enabled by @​dextero in
    # rust-mobile/android_logger-rs#84 Avoid rewriting the preconfigured tag by @​dextero in rust-mobile/android_logger-rs#87
    # Prepare for release by @​Nercury in rust-mobile/android_logger-rs#88
    # New Contributors
    # @​MarijnS95 made their first contribution in rust-mobile/android_logger-rs#77 @​dextero made their first contribution in
    # rust-mobile/android_logger-rs#83
    # Full Changelog: https://github.com/rust-mobile/android_logger-rs/compare/0.14.1...v0.15.0
    # Commits
    # 634c027 Merge pull request #88 from rust-mobile/prepare-for-release f2a48f0 Prepare for release 8b7fe0b Merge pull
    # request #87 from dextero/no-truncate-2 d829810 Merge pull request #84 from dextero/is-loggable e6931cf Fix typos a14e0c8
    # Document the behavior of android-api-30 feature 47488c9 Apply review suggestions 5288561 cargo clippy --fix bde2b63
    # Avoid rewriting the preconfigured tag 2581c25 Reformat with 1.85 toolchain Additional commits viewable in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=android_logger&package-manager
    # =cargo&previous-version=0.14.1&new-version=0.15.0)](https://docs.github.com/en/github/managing-security-vulnerabilities/
    # about-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35841	(@dependabot[bot], @dependabot[bot], #35841)	build(deps): bump either from 1.14.0 to 1.15.0 (#35841)
    # Bumps [either](https://github.com/rayon-rs/either) from 1.14.0 to 1.15.0.
    # Commits
    # 59ae1fc Merge pull request #120 from cuviper/release-1.15.0 7f4bf02 Release 1.15.0 56178e9 Merge pull request #119 from
    # klkvr/klkvr/fix-no-std 80b6f2a fix last references of use_std 2b71801 serde 1.0.95 8c1ea3e use_std -&gt; std d743e25
    # fix: no-std with serde feature See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=either&package-manager=cargo&p
    # revious-version=1.14.0&new-version=1.15.0)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-de
    # pendabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35839	(@dependabot[bot], @dependabot[bot], #35839)	build(deps): bump taffy from 0.7.6 to 0.7.7 (#35839)
    # Bumps [taffy](https://github.com/DioxusLabs/taffy) from 0.7.6 to 0.7.7.
    # Changelog Sourced from taffy's changelog.
    # 0.7.7 Fixed
    # Add #[inline] annotation to some methods on TaffyTree (#802) Add TaffyTree::remove_children_range method (#802)
    # Commits
    # 38c99d9 Prepare for v0.7.7 release a9df0d1 Add inline attributes and function to remove range of children in TaffyTree
    # (...  See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=taffy&package-manager=cargo&pr
    # evious-version=0.7.6&new-version=0.7.7)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-depen
    # dabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35837	(@stephenmuss, #35837)	Fix missing space in title of directory listings (#35837)
-https://github.com/servo/servo/pull/35836	(@stephenmuss, #35836)	reuse effects var in establishes_stacking_context (#35836)
    # Minor change to reuse effects variable in establishes_stacking_context() and to keep effects related conditional checks
    # together for readability.
-https://github.com/servo/servo/pull/35823	(@atouchet, #35823)	Add epaint_default_fonts to egui Dependabot group (#35823)
+https://github.com/servo/servo/pull/35728	(@webbeef, #35728)	Add an about:memory page (#35728)
    # This patch exposes a servo internal DOM API that is only made available to about: pages on the navigator object to
    # request memory reports.  The about:memory page itself is loaded like other html resources (eg.  bad cert, net error) and
    # makes use of this new API.
    # On the implementation side, notable changes: - components/script/routed_promise.rs abstracts the setup used to fulfill a
    # promise when the work needs to be routed through the constellation.  The goal is to migrate other similar promise APIs
    # in followup (eg.  dom/webgpu/gpu.rs, bluetooth.rs).  - a new message is added to request a report from the memory
    # reporter, and the memory reporter creates a json representation of the set of memory reports.  - the post-processing of
    # memory reports is done in Javascript in the about-memory.html page, providing the same results as the current Rust code
    # that outputs to stdout.  We can decide later if we want to remove the current output.
    devtools
>>> 2025-03-09T06:00:37Z
-https://github.com/servo/servo/pull/35869	(@servo-wpt-sync, #35869)	Update web-platform-tests to revision b'c23b0ad587af296087067b48a2f2101233589a8f' (#35869)
    # Automated downstream sync of changes from upstream as of 09-03-2025 [no-wpt-sync]
+https://github.com/servo/servo/pull/35864	(@kkoyung, #35864)	Implement can-have-its-url-rewritten for history api (#35864)
    # Implement the helper function to verify whether the document can have its URL rewritten to a new URL.
    # https://html.spec.whatwg.org/multipage/nav-history-apis.html#can-have-its-url-rewritten
    dom
>>> 2025-03-10T06:09:49Z
+https://github.com/servo/servo/pull/35789	(@dklassic, #35789)	feat: display file chosen for input file (#35789)
    # This PR allows the display of selected file count for `htmlinputelement` with `file` type.
    # **Working Example**
    # https://github.com/user-attachments/assets/8f4eff54-cf0a-45a8-a2b4-22f06333ce7a
    dom
+https://github.com/servo/servo/pull/35756	(@k+github@kafji.net, #35756)	Allow domain-like as URL location input (#35756)
    # Before this patch, domain with subdomain (e.g.  book.servo.org) won't be treated as URL location.
    # This patch retifies that by adding Firefox's location bar behavior:
    #   - book.servo.org is URL location - book.servo.org.  is URL location - .book.servo.org is not URL location
    # Fixes #35754.
    servoshell
+https://github.com/servo/servo/pull/35874	(@simonwuelker, #35874)	Register iframes with the devtools (#35874)
    # Previously, the devtools didn't know abouts.  They either ignored messages coming from iframes or crashed.
    # This reverts https://github.com/servo/servo/pull/34032 and then filters out non-tab globals in the "listTabs" message to
    # the root actor to ensure that iframes and workers don't show up in the devtools tab list.
    devtools
+https://github.com/servo/servo/pull/35787	(@yezhizhen, #35787)	layout: support CSS will-change (#35787)
    # Stylo PR: https://github.com/servo/stylo/pull/128 Spec:
    # https://www.w3.org/TR/css-will-change/#valdef-will-change-custom-ident
    # When will-change has certain properties specified, the element now establishes - stacking context - containing block for
    # absolutely positioned elements - containing block for fixed positioned elements
    css
>>> 2025-03-11T06:06:48Z
-https://github.com/servo/servo/pull/35897	(@nicoburns, #35897)	Eliminate to_shmem dependency from servo_url (#35897)
    # This removes the `ToShmem` trait impl for `servo_url::Url` and then removes the dependency from `Cargo.toml` (Servo
    # still depends on this crate indirectly via Stylo but that becomes an implementation detail).
    # This implementation was previously required to support `servo_url::Url` being used in Stylo, but Stylo now uses
    # `url::Url` directly (and doesn't depend on `servo_url`) so this is no longer necessary.
    # --- - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors
+https://github.com/servo/servo/pull/35802	(@simonwuelker, #35802)	Keep a list of slot descendants on each shadow root (#35802)
    # This makes it much faster to look up the slot with a given name, which is a fairly costly part of "assign slottables to
    # a tree".
    # As a result the time it takes for the results to load on wpt.fyi is reduced from over 3 minutes to about 5 seconds.
    performance dom
+https://github.com/servo/servo/pull/35821	(@Loirooriol, #35821)	layout: Remove `calculate_hypothetical_cross_size()` (#35821)
    # One of the callers was only used for an assert, and it was passing an inline size argument to a parameter expecting a
    # block size, so it wasn't making much sense anyways.
    # Just inline the code into the other caller, and for consistency remove the assert for replaced elements too.
    layout cleanup
+https://github.com/servo/servo/pull/35410	(@Taym95, @gterzian, #35410)	script: implement ReadableByteStreamController (#35410)
    # Part of https://github.com/servo/servo/issues/34676
    dom stream
-https://github.com/servo/servo/pull/35890	(@dependabot[bot], @dependabot[bot], #35890)	build(deps): bump tokio from 1.43.0 to 1.44.0 (#35890)
    # Bumps [tokio](https://github.com/tokio-rs/tokio) from 1.43.0 to 1.44.0.
    # Release notes Sourced from tokio's releases.
    # Tokio v1.44.0 1.44.0 (March 7th, 2025) This release changes the from_std method on sockets to panic if a blocking socket
    # is provided.  We determined this change is not a breaking change as Tokio is not intended to operate using blocking
    # sockets.  Doing so results in runtime hangs and should be considered a bug.  Accidentally passing a blocking socket to
    # Tokio is one of the most common user mistakes.  If this change causes an issue for you, please comment on #7172.  Added
    # coop: add task::coop module (#7116) process: add Command::get_kill_on_drop() (#7086) sync: add broadcast::Sender::closed
    # (#6685, #7090) sync: add broadcast::WeakSender (#7100) sync: add oneshot::Receiver::is_empty() (#7153) sync: add
    # oneshot::Receiver::is_terminated() (#7152)
    # Fixed
    # fs: empty reads on File should not start a background read (#7139) process: calling start_kill on exited child should
    # not fail (#7160) signal: fix CTRL_CLOSE, CTRL_LOGOFF, CTRL_SHUTDOWN on windows (#7122) sync: properly handle panic
    # during mpsc drop (#7094)
    # Changes
    # runtime: clean up magic number in registration set (#7112) coop: make coop yield using waker defer strategy (#7185)
    # macros: make select!  budget-aware (#7164) net: panic when passing a blocking socket to from_std (#7166) io: clean up
    # buffer casts (#7142)
    # Changes to unstable APIs
    # rt: add before and after task poll callbacks (#7120) tracing: make the task tracing API unstable public (#6972)
    # Documented
    # docs: fix nesting of sections in top-level docs (#7159) fs: rename symlink and hardlink parameter names (#7143) io: swap
    # reader/writer in simplex doc test (#7176) macros: docs about select!  alternatives (#7110) net: rename the argument for
    # send_to (#7146) process: add example for reading Child stdout (#7141) process: clarify Child::kill behavior (#7162)
    # process: fix grammar of the ChildStdin struct doc comment (#7192) runtime: consistently use worker_threads instead of
    # core_threads (#7186)
    # #6685: tokio-rs/tokio#6685 #6972: tokio-rs/tokio#6972 #7086: tokio-rs/tokio#7086 #7090: tokio-rs/tokio#7090
    # ... (truncated)
    # Commits
    # 8182ecf chore: prepare Tokio v1.44.0 (#7202) a258bff ci: enable printing in multi thread loom tests (#7200) e076d21
    # process: clarify Child::kill behavior (#7162) 042433c net: debug_assert on creating a tokio socket from a blocking one
    # (#7166) 0284d1b macros: make select!  budget-aware (#7164) 710bc80 rt: coop should yield using waker defer strategy
    # (#7185) a2b12bd readme: adjust release schedule to once per month (#7191) e7b593c process: fix grammar of the ChildStdin
    # struct doc comment (#7192) 3aaf4a5 coop: adjust grammar in tests/coop_budget.rs (#7173) 8e741c1 tokio: mark 1.43 as LTS
    # (#7189) Additional commits viewable in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=tokio&package-manager=cargo&pr
    # evious-version=1.43.0&new-version=1.44.0)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-dep
    # endabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35889	(@dependabot[bot], @dependabot[bot], #35889)	build(deps): bump app_units from 0.7.7 to 0.7.8 (#35889)
    # Bumps [app_units](https://github.com/servo/app_units) from 0.7.7 to 0.7.8.
    # Release notes Sourced from app_units's releases.
    # v0.7.8
    # Add from_f32_px_trunc and from_f64_px_trunc methods (#60)
    # Commits
    # 2e4e0e0 Add from_f32_px_trunc and from_f64_px_trunc methods (#60) See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=app_units&package-manager=carg
    # o&previous-version=0.7.7&new-version=0.7.8)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-d
    # ependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35887	(@dependabot[bot], @dependabot[bot], #35887)	build(deps): bump serde from 1.0.218 to 1.0.219 (#35887)
    # Bumps [serde](https://github.com/serde-rs/serde) from 1.0.218 to 1.0.219.
    # Release notes Sourced from serde's releases.
    # v1.0.219
    # Prevent absolute_paths Clippy restriction being triggered inside macro-generated code (#2906, thanks @​davidzeng0)
    # Commits
    # 49d098d Release 1.0.219 40f1d19 Wrap dummy.rs to 80 columns 514848b Merge pull request #2906 from davidzeng0/master
    # 168b6cf fix clippy absolute paths warning a8bdd17 Remove unused Punctuated import 1c96013 Resolve
    # mem_replace_with_default clippy lint f0d1ae0 Ignore elidable_lifetime_names pedantic clippy lint e3eaa6a Merge pull
    # request #2896 from dtolnay/stabledoc 6a630cf Also link to stable proc_macro See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=serde&package-manager=cargo&pr
    # evious-version=1.0.218&new-version=1.0.219)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-d
    # ependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35886	(@dependabot[bot], @dependabot[bot], #35886)	build(deps): bump syn from 2.0.99 to 2.0.100 (#35886)
    # Bumps [syn](https://github.com/dtolnay/syn) from 2.0.99 to 2.0.100.
    # Release notes Sourced from syn's releases.
    # 2.0.100
    # Add Visit::visit_token_stream, VisitMut::visit_token_stream_mut, Fold::fold_token_stream for processing TokenStream
    # during syntax tree traversals (#1852)
    # Commits
    # 5357c8f Release 2.0.100 78a1efb Merge pull request #1852 from dtolnay/tokenstream 01a9e6d Visit TokenStream in generated
    # syntax tree traversals 22bd069 Bypass instantiating Span-specific visit functions bf0a11d Generalize proc_macro2 path to
    # other terminal types c38857a Simplify reference-to-references 90381ea Sort TERMINAL_TYPES alphabetically 6a860b0 Update
    # test suite to nightly-2025-03-08 aed58d1 Update test suite to nightly-2025-03-05 See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=syn&package-manager=cargo&prev
    # ious-version=2.0.99&new-version=2.0.100)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-depe
    # ndabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35885	(@dependabot[bot], @dependabot[bot], #35885)	build(deps): bump serde_bytes from 0.11.16 to 0.11.17 (#35885)
    # Bumps [serde_bytes](https://github.com/serde-rs/bytes) from 0.11.16 to 0.11.17.
    # Release notes Sourced from serde_bytes's releases.
    # 0.11.17
    # Documentation improvements
    # Commits
    # dc4181f Release 0.11.17 f66c7f6 Merge pull request #55 from serde-rs/bincode 70d1db2 Update to new bincode standard
    # format 0cf9155 Merge pull request #54 from serde-rs/bincode 82e4149 Raise minimum compiler for tests to 1.85 4d75160
    # Update examples to bincode 2 ade06cc Resolve uninlined_format_args pedantic clippy lint 7c30eb0 Stop testing compilers
    # older than 1.68 ef19b8c Temporarily ignore outdated bincode dev-dependency See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=serde_bytes&package-manager=ca
    # rgo&previous-version=0.11.16&new-version=0.11.17)](https://docs.github.com/en/github/managing-security-vulnerabilities/a
    # bout-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
+https://github.com/servo/servo/pull/35871	(@simonwuelker, #35871)	Don't run scripts in documents that don't have a browsing context (#35871)
    # This is the same as #35848 because GitHub apparently won't let me re-open a pull request after I've force pushed the
    # branch (Apologies for the noise :/ ).
    dom
+https://github.com/servo/servo/pull/35865	(@boluochoufeng, #35865)	Fix the parsing error of PrefValue::Array, which is used for the parsing of Preferences shell_background_color_rgba field (#35865)
    # Fix the parsing error of PrefValue::Array, which is used for the parsing of Preferences shell_background_color_rgba
    # field.
    crash
+https://github.com/servo/servo/pull/35673	(@chickenleaf, #35673)	servoshell: Allow keyboard interaction with dialogs (enter / escape) (#35673)
    servosheell
+https://github.com/servo/servo/pull/35860	(@Loirooriol, #35860)	layout: Support min/max cross keywords sizes in flexbox (#35860)
    # Adds support for min-content, max-content, fit-content and stretch on the min and max cross size properties of a flex
    # item.  With one exception: when resolving the main sizes, transferred cross minimums and maximums will still ignore
    # keywords.
    layout flexbox
+https://github.com/servo/servo/pull/35882	(@Loirooriol, #35882)	layout: Only prevent fixed table layout when `inline-size` is `auto` (#35882)
    # We were ignoring `table-layout: fixed` both for `inline-size: auto` and `inline-size: max-content`.  However, the CSSWG
    # resolved that fixed table layout should be triggered except when `inline-size` is `auto`.
    # https://github.com/w3c/csswg-drafts/issues/10937#issuecomment-2669150397
    # Blink has already adopted this change, and they modified the WPT `/css/css-tables/fixed-layout-2.html` accordingly.
    # Here I'm doing some further cosmetic cleanups to the test.
    layout table
+https://github.com/servo/servo/pull/35870	(@stephenmuss, #35870)	Show correctly computed element display type in devtools (#35870)
    # Fixes an issue where devtools report all elements have block display.  Implementation follows suggestions in #35296.
    # Happy to take feedback on any improvements.
    devtools
-https://github.com/servo/servo/pull/35809	(@Loirooriol, #35809)	Add test for percentage sizes resolving against subpixel lengths (#35809)
    # Two floats with `width: 50%` each should fit on the same line, and four floats with `width: 25%` each should fit on the
    # same line.  That's even if the containing block width, expressed in layout units, cannot be divided by 2 or 4.  This
    # test checks cases that are tricky for browsers where 1 pixel are either 60, 64 or 100 layout units.  It passes on other
    # browsers but fails on Servo because of #34665.
+https://github.com/servo/servo/pull/35826	(@Loirooriol, #35826)	layout: Handle keyword sizes when computing the hypothetical cross size (#35826)
    layout
+https://github.com/servo/servo/pull/35849	(@xiaochengh, #35849)	Fix animation frame callback cancellation (#35849)
    # When two animation frame callbacks are fired in the same frame, the first one can cancel the second one.
    # This PR implements the logic properly by keeping all callbacks in the same deque.
    dom
+https://github.com/servo/servo/pull/35877	(@shanehandley, #35877)	script: use passive event listener option on AddEventListenerOptions (#35877)
    # Use the `passive` option provided by AddEventListenerOptions.
    # [Try](https://github.com/shanehandley/servo/actions/runs/13756676377)
    dom
+https://github.com/servo/servo/pull/35876	(@simonwuelker, #35876)	Implement `nonce` attribute to pass more CSP checks (#35876)
    # We currently stub out the nonce used for CSP checks in
    # https://github.com/servo/servo/blob/48aacc43b7d32bdb54cced28a2aa939356569a6a/components/net/fetch/methods.rs#L186
    # This change implements the `HTMLElement::nonce` attribute and uses it to set the cryptographic nonce value for fetches
    # initiated from both `` and `` elements.
    # With this change we can load at least one more script file from https://docs.google.com.
    # --- - [X] `./mach build -d` does not report any errors - [X] `./mach test-tidy` does not report any errors - [x] There
    # are tests for these changes
    dom csp
>>> 2025-03-12T06:02:20Z
+https://github.com/servo/servo/pull/35923	(@simonwuelker, #35923)	Implement `ElementInternals::shadowRoot` (#35923)
    dom shadowdom
-https://github.com/servo/servo/pull/35898	(@nicoburns, #35898)	Use new stylo crate renames (#35898)
    # Servo side companion PR for https://github.com/servo/stylo/pull/131
    # We are renaming Stylo crates in preparation for publishing to crates.io.  This PR just updates Servo to use the new
    # crate names.
    # --- - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors
+https://github.com/servo/servo/pull/34714	(@asun0204@163.com, @Loirooriol, #34714)	Bump Stylo to from a93e7ef to 4add86f (#34714)
    # The conversion from percentage * basis to Au is unreasonably.  Round method is used in this process and the size of box
    # is larger.
    upgrade
+https://github.com/servo/servo/pull/35904	(@Loirooriol, #35904)	layout: Fix interaction of margin and stretch size on block-level boxes (#35904)
    # The CSSWG resolved that `block-size: stretch` on a block-level box stretches the margin box to fill the parent.
    # However, if the parent doesn't have padding nor border, and doesn't establish an independent formatting context, then we
    # assume that the margins will collapse.  Therefore, we treat the margins as zero when resolving the stretch size,
    # regardless of whether they will actually end up collapsing.
    # https://github.com/w3c/csswg-drafts/issues/11044#issuecomment-2599101601
    # https://drafts.csswg.org/css-sizing-4/#stretch-fit-sizing
    layout
-https://github.com/servo/servo/pull/35921	(@jschwe, #35921)	ohos: Remove direct link to ace_napi.z (#35921)
    # The underlying issue was solved in napi-ohos 1.0.2, and we have already updated to 1.0.4
    # --- - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors - [x] These
    # changes fix #35913 - [x] There are tests for these changes
-https://github.com/servo/servo/pull/35911	(@sagudev, #35911)	Allow try runs to all users with label permissions (#35911)
    # https://servo.zulipchat.com/#narrow/channel/263398-general/topic/Contributors.20do.20not.20seem.20to.20have.20try.20job.
    # 20permissions/with/504859292
-https://github.com/servo/servo/pull/35918	(@dependabot[bot], @dependabot[bot], #35918)	build(deps): bump clap from 4.5.31 to 4.5.32 (#35918)
    # Bumps [clap](https://github.com/clap-rs/clap) from 4.5.31 to 4.5.32.
    # Release notes Sourced from clap's releases.
    # v4.5.32 [4.5.32] - 2025-03-10 Features
    # Add Error::remove
    # Documentation
    # (cookbook) Switch from humantime to jiff (tutorial) Better cover required vs optional
    # Internal
    # Update pulldown-cmark
    # Changelog Sourced from clap's changelog.
    # [4.5.32] - 2025-03-10 Features
    # Add Error::remove
    # Documentation
    # (cookbook) Switch from humantime to jiff (tutorial) Better cover required vs optional
    # Internal
    # Update pulldown-cmark
    # Commits
    # 81b9db2 chore: Release d3d7a17 chore: Merge branch 'master' into upstream/master 361114e chore: Release b693fc0 docs:
    # Update changelog 7100091 Merge pull request #5765 from epage/complete e90b2da refactor(complete): Pull our registration
    # writing 95e99ef refactor(complete): Pull out shell lookup 4af0cd6 fix(complete): Loosen requirements on Command factory
    # f40b37f chore: Release 63bfe1a docs: Update changelog Additional commits viewable in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=clap&package-manager=cargo&pre
    # vious-version=4.5.31&new-version=4.5.32)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-depe
    # ndabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35919	(@dependabot[bot], @dependabot[bot], #35919)	build(deps): bump indexmap from 2.7.1 to 2.8.0 (#35919)
    # Bumps [indexmap](https://github.com/indexmap-rs/indexmap) from 2.7.1 to 2.8.0.
    # Changelog Sourced from indexmap's changelog.
    # 2.8.0 (2025-03-10)
    # Added indexmap_with_default!  and indexset_with_default!  to be used with alternative hashers, especially when using the
    # crate without std.  Implemented PartialEq between each Slice and []/arrays.  Removed the internal rustc-rayon feature
    # and dependency.
    # Commits
    # dd06e57 Merge pull request #381 from cuviper/release-2.8.0 ab5c2df Release 2.8.0 b10b273 Merge pull request #380 from
    # iajoiner/feat/macros-no-std 5fd8971 feat: add indexmap_with_default and indexset_with_default macros 5b133ae Merge pull
    # request #376 from cuviper/slice-eq b56f035 Merge pull request #378 from cuviper/indexes e7e4de4 Correct
    # &quot;indexes&quot; to &quot;indices&quot; in Keys doc a34d7ae Merge pull request #377 from
    # waywardmonkeys/update-to-rand-0.9 b8bdead Upgrade dev-dependency rand to 0.9 3c1aa95 Make slice PartialEq more generic
    # Additional commits viewable in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=indexmap&package-manager=cargo
    # &previous-version=2.7.1&new-version=2.8.0)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-de
    # pendabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35916	(@dependabot[bot], @dependabot[bot], #35916)	build(deps): bump once_cell from 1.20.3 to 1.21.0 (#35916)
    # Bumps [once_cell](https://github.com/matklad/once_cell) from 1.20.3 to 1.21.0.
    # Changelog Sourced from once_cell's changelog.
    # 1.21.0
    # Outline initialization in race: #273.  Add OnceNonZereUsize::get_unchecked: #274.  Add OnceBox::clone and
    # OnceBox::with_value: #275.
    # 1.20.2
    # Remove portable_atomic from Cargo.lock if it is not, in fact, used: #267 This is a work-around for this cargo bug:
    # rust-lang/cargo#10801.
    # 1.20.1
    # Allow using race module using just portable_atomic, without critical_section and provide better error messages on
    # targets without atomic CAS instruction, #265.
    # 1.19.0
    # Use portable-atomic instead of atomic-polyfill, #251.
    # 1.18.0
    # MSRV is updated to 1.60.0 to take advantage of dep: syntax for cargo features, removing &quot;implementation
    # details&quot; from publicly visible surface.
    # 1.17.2
    # Avoid unnecessary synchronization in Lazy::{force,deref}_mut(), #231.
    # 1.17.1
    # Make OnceRef implementation compliant with strict provenance.
    # 1.17.0
    # Add race::OnceRef for storing a &amp;'a T.
    # 1.16.0
    # Add no_std implementation based on critical-section, #195.  Deprecate atomic-polyfill feature (use the new
    # critical-section instead)
    # 1.15.0
    # Increase minimal supported Rust version to 1.56.0.  Implement UnwindSafe even if the std feature is disabled.
    # 1.14.0
    # ... (truncated)
    # Commits
    # 0d6bc31 fix tests f27d156 v1.21.0 5b7b16c Merge pull request #275 from klkvr/klkvr/once-box-helpers 73da483 Merge pull
    # request #274 from briansmith/b/get_unchecked 15154b0 Add OnceNonZeroUsize::get_unchecked.  f15c633 feat: add helpers for
    # OnceBox See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=once_cell&package-manager=carg
    # o&previous-version=1.20.3&new-version=1.21.0)](https://docs.github.com/en/github/managing-security-vulnerabilities/about
    # -dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35915	(@dependabot[bot], @dependabot[bot], #35915)	build(deps): bump http from 1.2.0 to 1.3.0 (#35915)
    # Bumps [http](https://github.com/hyperium/http) from 1.2.0 to 1.3.0.
    # Changelog Sourced from http's changelog.
    # 1.3.0 (March 11, 2025)
    # Allow most UTF-8 characters in URI path and query.  Fix HeaderMap::reserve() to allocate sufficient capacity.
    # Commits
    # d0dd91e v1.3.0 64bd92b docs: Fixed encryption/compression typo for 'accept-encoding: identity'.  (#695) b03ed6a chore:
    # use range.contains in StatusCode methods (#748) a463fb5 chore(ci): use yq to get rust-version in manifest (#746) 68845bd
    # fix: HeaderMap::reserve allocates insufficient capacity (#741) 4e02046 refactor(header): remove BytesMut inline
    # optimization when creating (#738) 091ee9a feat(uri): allow utf8 char, not rfc 3986 compliant, in path and query (#715)
    # See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=http&package-manager=cargo&pre
    # vious-version=1.2.0&new-version=1.3.0)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-depend
    # abot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35895	(@mrobinson, #35895)	mach: Remove the `create-wpt` command (#35895)
    # WPT tests are very specific to the directory in which they are created.  In addition, since `create-wpt` takes care of
    # running `update-manifest` it hides the fact that any future changes to tests need this command run again.  No other
    # browser has a `create-wpt` command, instead developers are expected to craft their own tests, usually by starting from
    # an example in the directory they create the test in.  I think this works fine for Servo.
    # Closes #35726.  Closes #8427.
    # Signed-off-by: Martin Robinson
+https://github.com/servo/servo/pull/35899	(@simonwuelker, #35899)	Enable ShadowDom support by default (#35899)
    # As per previous discussion on zulip: [#general > Turn Shadow DOM on by
    # default](https://servo.zulipchat.com/#narrow/channel/263398-general/topic/Turn.20Shadow.20DOM.20on.20by.20default)
    dom shadowdom
-https://github.com/servo/servo/pull/35896	(@mrobinson, #35896)	base: Finish rename of `TopLevelBrowsingContextId` to `WebViewId` (#35896)
    # The `WebViewId` name is a lot more descriptive these days to the casual reader, so I think we can go ahead and finish
    # the rename.
    # Signed-off-by: Martin Robinson
-https://github.com/servo/servo/pull/35906	(@Loirooriol, #35906)	Update env_logger to 0.11 to fix RUSTSEC-2025-0014 (#35906)
>>> 2025-03-13T06:07:10Z
+https://github.com/servo/servo/pull/35934	(@DevGev, #35934)	compositing: Move `cursor_pos` member and update it in `update_cursor()` (#35934)
    # Previously a member of IOCompositor, the `cursor_pos` DevicePoint did not reflect the true position of the cursor.  This
    # caused flickering on mouse hover, see [issue #35875.](https://github.com/servo/servo/issues/35875) The value of
    # `cursor_pos` within IOCompositor was always (x=0, y=0) regardless of the true cursor position (it was never updated,
    # must be a bug or an oversight?).
    # Moving `cursor_pos` to `ServoRenderer`, updating `cursor_pos` on `dispatch_input_event()`, and storing cursor position
    # in `ServoRenderer` through method `update_cursor()` fixes the flickering previously observed.
    embedding
+https://github.com/servo/servo/pull/35275	(@Loirooriol, #35275)	layout: Remove special height logic of replaced element with auto width (#35275)
    # When computing the intrinsic block size of a replaced element with a computed preferred inline size of `auto`, instead
    # of transferring the final inline size through the aspect ratio, we were only transferring the min and max constraints.
    # We did this to match other browsers, but Ian Kilpatrick agreed that this is a bug and plans to change Blink.
    # CSSWG issue: https://github.com/w3c/csswg-drafts/issues/11236
    layout
-https://github.com/servo/servo/pull/35946	(@Loirooriol, #35946)	Change github workflows to not compile legacy layout (#35946)
    # Since it will be removed in #35943
-https://github.com/servo/servo/pull/35938	(@dependabot[bot], @dependabot[bot], #35938)	build(deps): bump http from 1.3.0 to 1.3.1 (#35938)
    # Bumps [http](https://github.com/hyperium/http) from 1.3.0 to 1.3.1.
    # Release notes Sourced from http's releases.
    # v1.3.1 What's Changed
    # fix: validate path bytes are at least utf8 by @​seanmonstar in hyperium/http#756
    # Full Changelog: https://github.com/hyperium/http/compare/v1.3.0...v1.3.1
    # Changelog Sourced from http's changelog.
    # 1.3.1 (March 11, 2025)
    # Fix validation that all characters are UTF-8 in URI path and query.
    # Commits
    # 8c1fb20 v1.3.1 6637a72 fix: validate path bytes are at least utf8 (#756) See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=http&package-manager=cargo&pre
    # vious-version=1.3.0&new-version=1.3.1)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-depend
    # abot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
+https://github.com/servo/servo/pull/35930	(@simonwuelker, #35930)	Set `is` value when constructing custom elements with the `new` operator (#35930)
    # Additionally, this change allows custom elements to extend slot elements (which required adding the slot elements to a
    # couple of lists) and adds doc comments that i added during debugging.
    dom
-https://github.com/servo/servo/pull/35941	(@dependabot[bot], @dependabot[bot], #35941)	build(deps): bump quote from 1.0.39 to 1.0.40 (#35941)
    # Bumps [quote](https://github.com/dtolnay/quote) from 1.0.39 to 1.0.40.
    # Release notes Sourced from quote's releases.
    # 1.0.40
    # Optimize construction of lifetime tokens (#293, thanks @​aatifsyed)
    # Commits
    # ab1e92c Release 1.0.40 3ff6882 Merge pull request 293 from aatifsyed/master 7a143c7 fix: set span on tick 5998437
    # refactor: push_lifetime* goes through an array instead of a manual iterator See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=quote&package-manager=cargo&pr
    # evious-version=1.0.39&new-version=1.0.40)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-dep
    # endabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35940	(@dependabot[bot], @dependabot[bot], #35940)	build(deps): bump winnow from 0.7.3 to 0.7.4 (#35940)
    # Bumps [winnow](https://github.com/winnow-rs/winnow) from 0.7.3 to 0.7.4.
    # Changelog Sourced from winnow's changelog.
    # [0.7.4] - 2025-03-12 Documentation
    # Clarify empty Clarify dispatch!  (cookbook) Discuss lexing (tutorial) Iterate on how we discuss errors
    # Commits
    # 2061c77 chore: Release 03cce15 docs: Update changelog 691746a Merge pull request #757 from montmorill/main e725f92
    # docs(topic): remove useless braces fcb0057 docs(topic): remove useless braces 2720ab4 Merge pull request #756 from
    # epage/docs 2141cce docs(comb): Clarify dispatch 1f855a3 docs(comb): Update 'empty' from when it was named 'value'
    # a6e7c9b Merge pull request #754 from epage/lex ab9830d docs(topic): Split out a dedicated lexing section Additional
    # commits viewable in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=winnow&package-manager=cargo&p
    # revious-version=0.7.3&new-version=0.7.4)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-depe
    # ndabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35937	(@dependabot[bot], @dependabot[bot], #35937)	build(deps): bump aws-lc-rs from 1.12.5 to 1.12.6 (#35937)
    # Bumps [aws-lc-rs](https://github.com/aws/aws-lc-rs) from 1.12.5 to 1.12.6.
    # Release notes Sourced from aws-lc-rs's releases.
    # aws-lc-rs v1.12.6 What's Changed
    # Align aws-lc-sys v0.27.0 w/ AWS-LC v1.48.2 by @​justsmth in aws/aws-lc-rs#726 No paste dependency by @​justsmth in
    # aws/aws-lc-rs#724 Pregenerated bindings for riscv64gc-unknown-linux-gnu by @​justsmth in aws/aws-lc-rs#720
    # Build improvements
    # Improve handling of CFLAGS by @​justsmth in aws/aws-lc-rs#712
    # Issues Being Resolved
    # Could not compile on Windows with crate rustls with config debug=&quot;limited&quot; #707 -sys: issues with CFLAGS from
    # environment being passed through to CMake #710 Pregenerate bindings for riscv64 #714 Prefixed BoringSSL symbols are
    # re-exported when linked into a shared library #715 CMakeLists.txt wrong minimum required version #716 paste - no longer
    # maintained #722
    # Other Merged PRs
    # Support new randomness generation in AWS-LC by @​torben-hansen in aws/aws-lc-rs#708 Run compiler tests on ubuntu-22.04
    # by @​justsmth in aws/aws-lc-rs#718
    # Full Changelog: https://github.com/aws/aws-lc-rs/compare/v1.12.5...v1.12.6
    # Commits
    # 2fd7016 Align aws-lc-sys v0.27.0 w/ AWS-LC v1.48.2 (#726) 21f1861 Improve handling of CFLAGS (#712) 6178df0 No paste
    # dependency (#724) 337a85d Align aws-lc-sys v0.27.0 w/ AWS-LC v1.48.1 (#720) dc07058 Run compiler tests on ubuntu-22.04
    # (#718) b18e227 Support new randomness generation in AWS-LC (#708) See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=aws-lc-rs&package-manager=carg
    # o&previous-version=1.12.5&new-version=1.12.6)](https://docs.github.com/en/github/managing-security-vulnerabilities/about
    # -dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35936	(@dependabot[bot], @dependabot[bot], #35936)	build(deps): bump ring from 0.17.13 to 0.17.14 (#35936)
    # Bumps [ring](https://github.com/briansmith/ring) from 0.17.13 to 0.17.14.
    # Changelog Sourced from ring's changelog.
    # Version 0.17.14 (2025-03-11) Fixed a performance bug in the AVX2-based AES-GCM implementation added in ring 0.17.13.
    # This will be another notable performance improvement for most newish x86-64 systems.  The performance issue impacted not
    # just AES-GCM.  Compatibility with GNU binutils 2.29 (used on Amazon Linux 2), and probably even earlier versions, was
    # restored.  It is expected that ring 0.17.14 will build on all the systems that 0.17.12 would build on.
    # Commits
    # See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=ring&package-manager=cargo&pre
    # vious-version=0.17.13&new-version=0.17.14)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-de
    # pendabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35939	(@dependabot[bot], @dependabot[bot], #35939)	build(deps): bump http-body-util from 0.1.2 to 0.1.3 (#35939)
    # Bumps [http-body-util](https://github.com/hyperium/http-body) from 0.1.2 to 0.1.3.
    # Release notes Sourced from http-body-util's releases.
    # http-body-util v0.1.3 Features
    # Add Channel, a body type backed by an async channel.  Make Empty::new() to be const fn.
    # Thanks!
    # @​cratelyn @​wgyt @​tottoto @​jplatte @​goto-bus-stop @​seanmonstar
    # Commits
    # ad4a9c9 http-body-util: v0.1.3 c86632e feat(util): introduce Sender::{capacity, max_capacity} (#147) f904761 update
    # copyright year (#148) 5d21ad1 feat(util): introduce channel::Sender::try_send() (#146) 1090bff docs: notes on poll_frame
    # return values (#144) 261b2df docs: is_end_stream is a hint (#143) 86fdf00 util: add a channel body (#140) 7339aec
    # chore(http-body): update msrv to 1.61 (#141) 98d0886 feat(util): allow Empty constructor in const context (#129) fed1452
    # chore(util): update msrv to 1.61 Additional commits viewable in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=http-body-util&package-manager
    # =cargo&previous-version=0.1.2&new-version=0.1.3)](https://docs.github.com/en/github/managing-security-vulnerabilities/ab
    # out-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35917	(@dependabot[bot], @dependabot[bot], #35917)	build(deps): bump libc from 0.2.170 to 0.2.171 (#35917)
    # Bumps [libc](https://github.com/rust-lang/libc) from 0.2.170 to 0.2.171.
    # Release notes Sourced from libc's releases.
    # 0.2.171 Added
    # Android: Add if_nameindex/if_freenameindex support (#4247) Apple: Add missing proc types and constants (#4310) BSD: Add
    # devname (#4285) Cygwin: Add PTY and group API (#4309) Cygwin: Add support (#4279) FreeBSD: Make spawn.h interfaces
    # available on all FreeBSD-like systems (#4294) Linux: Add AF_XDP structs for all Linux environments (#4163) Linux: Add
    # SysV semaphore constants (#4286) Linux: Add F_SEAL_EXEC (#4316) Linux: Add SO_PREFER_BUSY_POLL and SO_BUSY_POLL_BUDGET
    # (#3917) Linux: Add devmem structs (#4299) Linux: Add socket constants up to SO_DEVMEM_DONTNEED (#4299) NetBSD, OpenBSD,
    # DragonflyBSD: Add closefrom (#4290) NuttX: Add pw_passwd field to passwd (#4222) Solarish: define IP_BOUND_IF and
    # IPV6_BOUND_IF (#4287) Wali: Add bindings for wasm32-wali-linux-musl target (#4244)
    # Changed
    # AIX: Use sa_sigaction instead of a union (#4250) Make msqid_ds.__msg_cbytes public (#4301) Unix: Make all major, minor,
    # makedev into const fn (#4208)
    # Deprecated
    # Linux: Deprecate obsolete packet filter interfaces (#4267)
    # Fixed
    # Cygwin: Fix strerror_r (#4308) Cygwin: Fix usage of f!  (#4308) Hermit: Make stat::st_size signed (#4298) Linux: Correct
    # values for SI_TIMER, SI_MESGQ, SI_ASYNCIO (#4292) NuttX: Update tm_zone and d_name fields to use c_char type (#4222)
    # Xous: Include the prelude to define c_int (#4304)
    # Other
    # Add labels to FIXMEs (#4231, #4232, #4234, #4235, #4236) CI: Fix &quot;cannot find libc&quot; error on Sparc64 (#4317)
    # CI: Fix &quot;cannot find libc&quot; error on s390x (#4317) CI: Pass --no-self-update to rustup update (#4306) CI:
    # Remove tests for the i586-pc-windows-msvc target (#4311) CI: Remove the check_cfg job (#4322) Change the range syntax
    # that is giving ctest problems (#4311) Linux: Split out the stat struct for gnu/b32/mips (#4276)
    # ... (truncated)
    # Changelog Sourced from libc's changelog.
    # 0.2.171 - 2025-03-11 Added
    # Android: Add if_nameindex/if_freenameindex support (#4247) Apple: Add missing proc types and constants (#4310) BSD: Add
    # devname (#4285) Cygwin: Add PTY and group API (#4309) Cygwin: Add support (#4279) FreeBSD: Make spawn.h interfaces
    # available on all FreeBSD-like systems (#4294) Linux: Add AF_XDP structs for all Linux environments (#4163) Linux: Add
    # SysV semaphore constants (#4286) Linux: Add F_SEAL_EXEC (#4316) Linux: Add SO_PREFER_BUSY_POLL and SO_BUSY_POLL_BUDGET
    # (#3917) Linux: Add devmem structs (#4299) Linux: Add socket constants up to SO_DEVMEM_DONTNEED (#4299) NetBSD, OpenBSD,
    # DragonflyBSD: Add closefrom (#4290) NuttX: Add pw_passwd field to passwd (#4222) Solarish: define IP_BOUND_IF and
    # IPV6_BOUND_IF (#4287) Wali: Add bindings for wasm32-wali-linux-musl target (#4244)
    # Changed
    # AIX: Use sa_sigaction instead of a union (#4250) Make msqid_ds.__msg_cbytes public (#4301) Unix: Make all major, minor,
    # makedev into const fn (#4208)
    # Deprecated
    # Linux: Deprecate obsolete packet filter interfaces (#4267)
    # Fixed
    # Cygwin: Fix strerror_r (#4308) Cygwin: Fix usage of f!  (#4308) Hermit: Make stat::st_size signed (#4298) Linux: Correct
    # values for SI_TIMER, SI_MESGQ, SI_ASYNCIO (#4292) NuttX: Update tm_zone and d_name fields to use c_char type (#4222)
    # Xous: Include the prelude to define c_int (#4304)
    # Other
    # Add labels to FIXMEs (#4231, #4232, #4234, #4235, #4236) CI: Fix &quot;cannot find libc&quot; error on Sparc64 (#4317)
    # CI: Fix &quot;cannot find libc&quot; error on s390x (#4317) CI: Pass --no-self-update to rustup update (#4306) CI:
    # Remove tests for the i586-pc-windows-msvc target (#4311) CI: Remove the check_cfg job (#4322) Change the range syntax
    # that is giving ctest problems (#4311) Linux: Split out the stat struct for gnu/b32/mips (#4276)
    # ... (truncated)
    # Commits
    # 78b0f8a chore: release v0.2.171 b988ca5 Merge pull request #4318 from tgross35/backport-morel 5746f8e Add missing macos
    # proc types and constants 29a40e2 linux: add devmem structs 85f6836 linux: add socket constants up to SO_DEVMEM_DONTNEED
    # ff17476 linux_like: add F_SEAL_EXEC 67352ee ci: sparc64: fix 'cannot find libc' error 10af5a6 ci: s390x: fix 'cannot
    # find libc' error c6ad434 Merge pull request #4315 from tgross35/backport-porcini 5726b3c Cygwin: Add PTY and group API
    # Additional commits viewable in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=libc&package-manager=cargo&pre
    # vious-version=0.2.170&new-version=0.2.171)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-de
    # pendabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
+https://github.com/servo/servo/pull/35719	(@sagudev, #35719)	canvas: Do not update ImageKey during canvas layout (#35719)
    # https://github.com/servo/servo/pull/35695 made 2d canvas reuse one ImageKey, so we can simply send it on 2d canvas
    # creation.  This avoids receiving image key from paint thread on every layout and brings 2d canvas context closer to
    # other canvas ctxs.  This also brings in a lot of simplifications.
    # Currently we still send ipc message (to update wr image) on layouting and await that update image cmd is sent to WR (or
    # else we get problems, because we can built/send display list before update image is sent to WR), but I plan to tackle
    # this in followup PR.
    # PR is reviewable per commits.
    performance canvas
-https://github.com/servo/servo/pull/35932	(@mrobinson, #35932)	deps: Correct stylo branch name (#35932)
    # The `mirror` script in the stylo repository should determine the branch name after an upgrade.  By accident the wrong
    # branch name was assigned manually.
    # Signed-off-by: Martin Robinson
-https://github.com/servo/servo/pull/35924	(@mrobinson, #35924)	bhs: Remove direct link to `liblzma` (#35924)
    # This workaround doesn't seem to be necessary any longer.
    # Fixes #35914.
    # Signed-off-by: Martin Robinson
-https://github.com/servo/servo/pull/35791	(@sagudev, #35791)	Remove message from WebGL subtest name and remove stale expectations (#35791)
    # Firstly I removed messages from subtest names, then update all subtest names in expectations using regexes.  Then used
    # [patched `moz-webgpu-cts`](https://github.com/sagudev/moz-webgpu-cts/tree/servo-webgl) to remove duplicates and finally
    # update some expectations to make CI pass (all where PASS expect FAIL).
    # For layout2020 this resulted -7k lines, but layout2013 was missing some expectations so add/remove ration is off.
+https://github.com/servo/servo/pull/35925	(@nicoburns, #35925)	Upgrade Stylo to 2025-03-01 (#35925)
    # This continues #35782
    # Changelog:
    #  - Upstream:
    #  https://github.com/servo/stylo/compare/42c338a67a96909aed5499c88fba1b265f4375d3...6e0d9968e11364b1601718a96b050063fcf3c
    # b68
    #  - Servo fixups: None yet
    # Stylo tracking issue: https://github.com/servo/stylo/issues/139
    upgrade
>>> 2025-03-14T06:05:12Z
+https://github.com/servo/servo/pull/35965	(@Loirooriol, #35965)	layout: Allow lazy resolution of automatic minimum sizes (#35965)
    # `Size::resolve_for_min()` had an `Au` parameter, representing the value to be used for an automatic minimum size.
    # However, this amount isn't trivial to compute in flexbox, so this patch changes the parameter to a function that can be
    # called lazily.
    # Note flexbox isn't currently using `Size::resolve_for_min()`, but it will in #35961.
    layout
+https://github.com/servo/servo/pull/35960	(@xiaochengh, #35960)	Check whether an element is custom in the spec-compliant way (#35960)
    # Current code checks whether an element is custom by checking whether it has an associated custom element definition.
    # This is different from the [spec](https://dom.spec.whatwg.org/#concept-element-custom), which says:
    # > An [element](https://dom.spec.whatwg.org/#concept-element) whose [custom element
    # state](https://dom.spec.whatwg.org/#concept-element-custom-element-state) is "custom" is said to be custom.
    # The two definitions are identical in almost all cases, except during [custom element
    # upgrade](https://html.spec.whatwg.org/multipage/custom-elements.html#upgrades), where the custom element state is set to
    # `failed` until finished.
    # As a result, the current implementation may erroneously fire custom element callbacks for mutations during the upgrade.
    # This PR fixes it.
    dom
-https://github.com/servo/servo/pull/35963	(@dependabot[bot], @dependabot[bot], #35963)	build(deps): bump tokio-util from 0.7.13 to 0.7.14 (#35963)
    # Bumps [tokio-util](https://github.com/tokio-rs/tokio) from 0.7.13 to 0.7.14.
    # Commits
    # b663abe chore: update tokio-util version number (#7215) 9a11efc chore: prepare tokio-util v0.7.14 (#7215) d760b26 Merge
    # tokio-1.44.1 into master (#7218) d413c9c chore: prepare Tokio v1.44.1 (#7217) addbfb9 rt: skip defer queue in
    # block_in_place context (#7216) 5687043 test: remove unused dependencies (#7214) 72c87a7 test: add io::Builder::name for
    # better panic messages (#7212) 8507e28 Remove an old custom OnceCell implementation in favor of std (#7208) 7efcab4 Do
    # not require Unpin for some trait impls (#7204) e4a39d2 sync: add CancellationToken::run_until_cancelled_owned (#7081)
    # Additional commits viewable in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=tokio-util&package-manager=car
    # go&previous-version=0.7.13&new-version=0.7.14)](https://docs.github.com/en/github/managing-security-vulnerabilities/abou
    # t-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35962	(@dependabot[bot], @dependabot[bot], #35962)	build(deps): bump tokio from 1.44.0 to 1.44.1 (#35962)
    # Bumps [tokio](https://github.com/tokio-rs/tokio) from 1.44.0 to 1.44.1.
    # Release notes Sourced from tokio's releases.
    # Tokio v1.44.1 1.44.1 (March 13th, 2025) Fixed
    # rt: skip defer queue in block_in_place context (#7216)
    # #7216: tokio-rs/tokio#7216
    # Commits
    # d413c9c chore: prepare Tokio v1.44.1 (#7217) addbfb9 rt: skip defer queue in block_in_place context (#7216) See full
    # diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=tokio&package-manager=cargo&pr
    # evious-version=1.44.0&new-version=1.44.1)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-dep
    # endabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35959	(@mrobinson, #35959)	script: Remove ThreadSafeLayoutNode::is_ignorable_whitespace (#35959)
    # This is now unused with the removal of legacy layout.  I didn't see any others methods in this trait that were unused.
    # Signed-off-by: Martin Robinson
+https://github.com/servo/servo/pull/35958	(@simonwuelker, #35958)	Hide servo internal shadow roots from the inspector by default (#35958)
    # These shadow roots are used for things like the `details` element and are now hidden unless the
    # `inspector_show_servo_internal_shadow_roots` preference is set.
    devtools
-https://github.com/servo/servo/pull/35957	(@Loirooriol, #35957)	Fix Cargo.toml instructions for building Servo with a local Stylo (#35957)
    # And bump Stylo to servo/stylo#143
-https://github.com/servo/servo/pull/35933	(@mrobinson, #35933)	Use `strum` to iterate through enum variants and get their names (#35933)
    # `strum` allows us to avoid manually listing enum variant names and also to get their names as static strings.  We cannot
    # use this for all cases due to https://github.com/Peternator7/strum/issues/152, but we can still use it to remove a lot
    # of code.
+https://github.com/servo/servo/pull/35884	(@atbrakhi, #35884)	devtools: use correct id for browser_id and outer_window_id (#35884)
    # Currently, DevTools fails to respond when multiple tabs are open.  This can also happen if you have a single tab open
    # but then open a different one in the same tab.  This issue occurs because we are using `active_pipeline` as the
    # `browser_id`.
    # Every time we navigate, `active_pipeline` (also known as `pipeline_id` in some parts of the codebase) gets updated,
    # while `browser_id` remains the same for a tab.  This PR uses `browser_context_id` for `browser_id`, which aligns with
    # what servo sends to the client.  `outer_window_id` is `active_pipeline`, which is correct.  Initially, we were using
    # `active_pipeline` for `browser_id`, which caused the bug.
    # Signed-off-by: atbrakhi
    devtools
+https://github.com/servo/servo/pull/35883	(@xiaochengh, #35883)	Don't run disconnected callback on already disconnected custom elements (#35883)
    dom
-https://github.com/servo/servo/pull/35952	(@Taym95, #35952)	script: refactor create_buffer_source_with_constructor (#35952)
    # Part of https://github.com/servo/servo/issues/34676, refactor create_buffer_source_with_constructor function
+https://github.com/servo/servo/pull/35755	(@simonwuelker, #35755)	Migrate to the 2024 edition (#35755)
    # Now that we use rustc `1.85` we might as well migrate to the latest edition.
    # The main changes are the following:
    # * Added appropriate `+ use<>` bounds to `impl Trait` in return types to indicate the generic parameters that the
    # returned type may use * Removed binding modifiers where they're not needed (`let Some(ref r) = &f` -> `let Some(r) =
    # &f`) * Removed any `gen` identifiers, which are now reserved, or used `r#gen` if that's not possible * mark `extern`
    # blocks as `unsafe`
    # I have set the default lint level for the `unsafe_op_in_unsafe_fn` lint to "allow" (the same as it was by default in the
    # 2021 edition).  In 2024 edition it triggers a warning by default, but the lint is incredibly noisy for servo, causing
    # around 60.000 warnings.
    upgrade
-https://github.com/servo/servo/pull/35942	(@atbrakhi, #35942)	devtools: improve ID Naming for better readability and context (#35942)
    # Renamed various IDs such as `stream_id`, `pipeline_id` `browsing_context_it` for better readability and context
+https://github.com/servo/servo/pull/35943	(@Loirooriol, #35943)	Remove legacy layout (layout 2013) (#35943)
    # We were already not compiling it and not running tests on it by default.  So it's simpler to just completely remove it.
    cleanup
+https://github.com/servo/servo/pull/35947	(@Loirooriol, #35947)	Improve logic for establishing a stacking context (#35947)
    # In particular:
    #  - `z-index` will now work on unpositioned grid items.  - `will-change: z-index` will only establish a stacking context
    #  if `z-index` applies, i.e.  if the box is positioned or a flex/grid item.  - The conditions in
    #  `establishes_stacking_context()` are reordered, so that the most likely ones are checked first.
    layout
>>> 2025-03-15T06:14:11Z
-https://github.com/servo/servo/pull/35900	(@Loirooriol, #35900)	layout: Unify `FlexItem::new()` and `FlexItemBox::main_content_size_info()` (#35900)
    # These methods were doing virtually the same thing.  So this patch moves the common logic into a new
    # `FlexItemBox::to_flex_item()`, which is then called by `FlexItem::new()` and `FlexItemBox::main_content_size_info()`.
+https://github.com/servo/servo/pull/35970	(@simonwuelker, #35970)	script: Implement HTMLOptgroupElement::Label (#35970)
    # Part of #35684.
    # Additionally, this corrects the logic for finding the `` element that a given `` belongs to.  The previous code returned
    # the first select element in the ancestor chain of the optgroup - which is not what the spec says.  Optgroups must be
    # direct children of their select element.
    dom
-https://github.com/servo/servo/pull/35975	(@dependabot[bot], @dependabot[bot], #35975)	build(deps): bump half from 2.4.1 to 2.5.0 (#35975)
    # Bumps [half](https://github.com/starkat99/half-rs) from 2.4.1 to 2.5.0.
    # Release notes Sourced from half's releases.
    # 2.5.0 Changed
    # Updated optional dependencies to latest major versions:
    # zercopy 0.6 -&gt; 0.8 rand 0.8 -&gt; 0.9 rand_distr 0.4 -&gt; 0.5 rkyv 0.7 -&gt; 0.8 (dev) criterion 0.4 -&gt; 0.5
    # Minimum supported Rust version has been changed to 1.81 due to above dependency updates.  Minor restructing of included
    # license file locations to be more consistent with crates ecosystem.
    # Added
    # Added support for arbitrary crate.  Fixes #110.  By @​FL33TW00D.  New num-traits implementations: FromBytes and ToBytes
    # for f16 and bf16.  By @​kpreid.
    # Fixed
    # Suppressed unexpected_cfg lint warnings on newer versions of stable Rust.  Resolved ambiguous rustdoc warnings due to
    # new unstable f16 primitive in compiler.
    # Changelog Sourced from half's changelog.
    # [2.5.0] - 2024-03-13 Changed
    # Updated optional dependencies to latest major versions:
    # zercopy 0.6 -&gt; 0.8 rand 0.8 -&gt; 0.9 rand_distr 0.4 -&gt; 0.5 rkyv 0.7 -&gt; 0.8 (dev) criterion 0.4 -&gt; 0.5
    # Minimum supported Rust version has been changed to 1.81 due to above dependency updates.  Minor restructing of included
    # license file locations to be more consistent with crates ecosystem.
    # Added
    # Added support for arbitrary crate.  Fixes #110.  By [@​FL33TW00D].  New num-traits implementations: FromBytes and
    # ToBytes for f16 and bf16.  By [@​kpreid].
    # Fixed
    # Suppressed unexpected_cfg lint warnings on newer versions of stable Rust.  Resolved ambiguous rustdoc warnings due to
    # new unstable f16 primitive in compiler.
    # Commits
    # 989d270 move license files and bump to versoin 2.5.0 c55579a fix doc reference c00bced disambiguate docs from new
    # primitive d02f32e bump MSRV to 1.81 0ce0933 remove unnecessary feature for optional dependency 545938a upgrade to
    # criterion 0.5 7f29a96 upgrade to rkyv 0.8 0adf011 Merge pull request #122 from kpreid/tobytes db1940e Merge branch
    # 'main' into tobytes 0bebc34 update docs Additional commits viewable in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=half&package-manager=cargo&pre
    # vious-version=2.4.1&new-version=2.5.0)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-depend
    # abot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35974	(@dependabot[bot], @dependabot[bot], #35974)	build(deps): bump once_cell from 1.21.0 to 1.21.1 (#35974)
    # Bumps [once_cell](https://github.com/matklad/once_cell) from 1.21.0 to 1.21.1.
    # Changelog Sourced from once_cell's changelog.
    # 1.21.1
    # Reduce MSRV to 1.65: #277.
    # Commits
    # a70d907 Merge pull request #277 from briansmith/b/as-ptr 9173b99 Reduce MSRV to 1.65 by polyfilling
    # AtomicUsize::as_ptr().  See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=once_cell&package-manager=carg
    # o&previous-version=1.21.0&new-version=1.21.1)](https://docs.github.com/en/github/managing-security-vulnerabilities/about
    # -dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35973	(@dependabot[bot], @dependabot[bot], #35973)	build(deps): bump prettyplease from 0.2.30 to 0.2.31 (#35973)
    # Bumps [prettyplease](https://github.com/dtolnay/prettyplease) from 0.2.30 to 0.2.31.
    # Release notes Sourced from prettyplease's releases.
    # 0.2.31
    # Format multiple array elements on the same line (#108)
    # Commits
    # 3ee5818 Release 0.2.31 9f3d76f Merge pull request #108 from dtolnay/arraywrap 69da125 Multiple array elements on the
    # same line 1effcba Merge pull request #107 from dtolnay/vecarray 9ecdb58 Retain punctuated structure of VecArray 425a6d0
    # Merge pull request #106 from dtolnay/badoffset 26af784 Blame caller for bad offset call See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=prettyplease&package-manager=c
    # argo&previous-version=0.2.30&new-version=0.2.31)](https://docs.github.com/en/github/managing-security-vulnerabilities/ab
    # out-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
+https://github.com/servo/servo/pull/35926	(@chocolate-pie, @Loirooriol, #35926)	layout: Add support for basic transform css properties (#35926)
    # This PR adds support for basic transform CSS properties, `rotate`, `scale` and `translate`.  There are no WPT tests for
    # this, but I checked this works correctly by running
    # `css/css-transforms/individual-transform/individual-transform-1.html`.
    # --- - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors - [x] These
    # changes fix #35800
    layout
+https://github.com/servo/servo/pull/35949	(@sebsebmc@gmail.com, #35949)	Bring back DOM GC checkpoint to script_thread (#35949)
    # This brings back the calls that were removed in a0743f60b36e
    # Not sure if we should be filtering the documents to just active documents.
    dom
>>> 2025-03-16T06:07:40Z
+https://github.com/servo/servo/pull/35831	(@jdm, #35831)	Refactor common boilerplate out of serialize/transfer implementations (#35831)
    # Following up on my original work from #33811, I've got a new set of changes that should make future
    # Serializable/Transferable implementations much easier to write.  Unlike #33811, I have not changed anything about how
    # the structured clone implementation is designed—these changes only lift common boilerplate out of the interface-specific
    # logic, and use static types to ensure all known interfaces are handled the same way.
    # There are two main issues with the current implementation of structured cloning: * there are many places that need to be
    # updated when adding a new serializable/transferable interface, and the compiler cannot verify that they are all updated
    # * the interface-specific logic is mixed in with logic that is identical across all interfaces
    # These changes start by introducing two enums in components/shared/script: Serializable and Transferable.  These enums
    # drive all of the logic for cloning/serializing/transfering, ensuring that the compiler will complain if any code
    # requiring interface-specific logic has been missed.
    # The next important piece of these changes is making the Serializable and Transferable _traits_ from components/script
    # identify which field of StructuredDataReader/Writer should be used for a given type.  This ensures that the compiler
    # will complain if those fields are not added when necessary, and allows hoisting the logic for storing/reading
    # serialized/deserialized values out of the interface-specific logic.
    # The final important piece of these changes is in the trait interfaces for Serializable/Transferable.  Now that the
    # common logic is extracted into the common structured cloning implementation, users of these traits only need to write
    # their implementations in terms of their serialized and deserialized types, leading to much simpler code.
    # [Try run](https://github.com/servo/servo/actions/runs/13714043021/job/38355664511)
    # --- - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors - [x] There
    # are tests for these changes
    dom
+https://github.com/servo/servo/pull/35737	(@jdm, #35737)	Various fixes for webdriver conformance tests (#35737)
    # I'm working through test failures under tests/wpt/tests/webdriver/tests/classic/execute_script/execute.py, and these
    # changes allow many of the tests in that file to pass.
    # --- - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors - [x] These
    # changes are part of #34683 - [x] There are tests for these changes (but they don't run in CI yet)
    webdriver
-https://github.com/servo/servo/pull/35972	(@mrobinson, #35972)	constellation: Remove two unused messages to the Constellation (#35972)
    # This also removes supporting code which becomes unused as well.
    # Signed-off-by: Martin Robinson
>>> 2025-03-17T06:07:34Z
-https://github.com/servo/servo/pull/35992	(@nicoburns, #35992)	Upgrade to html5ever 0.30, xml5ever 0.21, markup5ever 0.15 (#35992)
    # This also does a patch-level upgrade of Stylo so that it has a matching markup5ever version.
    # --- - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors
+https://github.com/servo/servo/pull/35988	(@jdm, #35988)	Move CustomTraceable to script_bindings. (#35988)
    # Since the record binding support relies on CustomTraceable, we need to move it to script_bindings.  This requires some
    # adjustment of the HTML parser code that relies on it, since we start running into the orphan rule since both the parser
    # types and CustomTraceable are from different crates.
    # --- - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors - [x] These
    # changes are part of #1799 - [x] There are existing tests for these changes
    dom split
+https://github.com/servo/servo/pull/35987	(@jdm, #35987)	Cleanups for future script crate split (#35987)
    # These changes are extracted from my latest branch implementing the script crate split.  We can't directly implement
    # methods on generated dictionary and union types, so we need to rewrite the uses to avoid the orphan rule.
    # --- - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors - [x] These
    # changes are part of #1799 - [x] There are existing tests for these changes
    dom split
+https://github.com/servo/servo/pull/35969	(@gterzian, #35969)	Use stream in file read operation (#35969)
    # Use the stream of the blob in file read operation.
    dom stream
>>> 2025-03-18T06:09:09Z
-https://github.com/servo/servo/pull/36018	(@Loirooriol, #36018)	Fix WPT importer (#36018)
    # In #35946 I accidentally removed a necessary line of code.
+https://github.com/servo/servo/pull/36014	(@aryaajitnair@gmail.com, #36014)	feat: add CanGc argument to Error::to_jsval (#36014)
    dom crash
-https://github.com/servo/servo/pull/36011	(@Loirooriol, #36011)	Bump Stylo to df459ec (#36011)
    # Changelog:
    # https://github.com/servo/stylo/compare/6aa5733a36de47b6f22879ee664266a1d59877d4...df459eca2e8e71b5e85c7c20a64208f3410184
    # e0
    # This fixes some potential compilation problems since servo/stylo#150 renamed some crates.
-https://github.com/servo/servo/pull/36006	(@dependabot[bot], @dependabot[bot], #36006)	build(deps): bump foldhash from 0.1.4 to 0.1.5 (#36006)
    # Bumps [foldhash](https://github.com/orlp/foldhash) from 0.1.4 to 0.1.5.
    # Commits
    # 6822931 Version 0.1.5.  ce9f127 Fix clippy warning.  (#26) a02c758 Add SharedSeed and SeedableRandomState.  (#25)
    # a845460 Perform smarter selection for 32-bit rotation.  (#24) 1ef861f Lower MSRV to 1.60.  (#23) 97b210c Use 128-bit
    # widening multiply on more platforms.  (#17) b760ffa Improve mixing on 32-bit.  (#22) 07d8a8f Fix length-extension attack
    # due to overlapping reads.  (#21) f4203fb Fix per-hasher-random seed-independence for some string collisions.  (#20)
    # 88669b1 Use wrapping_mul to improve debug build performance.  (#16) Additional commits viewable in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=foldhash&package-manager=cargo
    # &previous-version=0.1.4&new-version=0.1.5)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-de
    # pendabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36007	(@dependabot[bot], @dependabot[bot], #36007)	build(deps): bump aws-lc-sys from 0.27.0 to 0.27.1 (#36007)
    # Bumps [aws-lc-sys](https://github.com/aws/aws-lc-rs) from 0.27.0 to 0.27.1.
    # Commits
    # 9990c83 Regenerate aws-lc-sys @ v1.48.3 (#734) f7d299c Bump aws-lc-fips-sys to v0.13.4 (#731) See full diff in compare
    # view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=aws-lc-sys&package-manager=car
    # go&previous-version=0.27.0&new-version=0.27.1)](https://docs.github.com/en/github/managing-security-vulnerabilities/abou
    # t-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36004	(@dependabot[bot], @dependabot[bot], #36004)	build(deps): bump async-compression from 0.4.20 to 0.4.21 (#36004)
    # Bumps [async-compression](https://github.com/Nullus157/async-compression) from 0.4.20 to 0.4.21.
    # Changelog Sourced from async-compression's changelog.
    # 0.4.21 - 2025-03-15 Fixed
    # When flate encoding, do not mark internal state as flushed if it ran out of buffer space.  Add debug assertion in
    # produce method to check buffer capacity in implementations for BufWriter.
    # Commits
    # f16d42f docs: update changelog 88c912c Update CHANGELOG.md: fix wording 6bbeae2 Update CHANGELOG.md afb7ac5 chore:
    # release v0.4.21 6e68abe Merge pull request #333 from link2xt/link2xt/internal-flush c695fc2 Merge pull request #316 from
    # pluveto/main 292ea4c Update buf_writer.rs 6372a14 Update buf_writer.rs a21d8a2 fix(flate encoder): do not mark internal
    # state as flushed if we ran out of ou...  f3e9742 Merge pull request #330 from Nullus157/release-plz-2025-02-28T06-33-34Z
    # See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=async-compression&package-mana
    # ger=cargo&previous-version=0.4.20&new-version=0.4.21)](https://docs.github.com/en/github/managing-security-vulnerabiliti
    # es/about-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36001	(@dependabot[bot], @dependabot[bot], #36001)	build(deps): bump libz-sys from 1.1.21 to 1.1.22 (#36001)
    # Bumps [libz-sys](https://github.com/rust-lang/libz-sys) from 1.1.21 to 1.1.22.
    # Commits
    # See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=libz-sys&package-manager=cargo
    # &previous-version=1.1.21&new-version=1.1.22)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-
    # dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36000	(@dependabot[bot], @dependabot[bot], #36000)	build(deps): bump rustls from 0.23.23 to 0.23.25 (#36000)
    # Bumps [rustls](https://github.com/rustls/rustls) from 0.23.23 to 0.23.25.
    # Commits
    # 1e2b4f3 Prepare 0.23.25 317c5bf Map webpki RequiredEkuNotFound error to InvalidPurpose 3ab8a8e Prepare 0.23.24 70e2b1c
    # Add warning about server-side cross-config resumption 1c318bc Refactor: prefer to take reference on match scrutinee
    # 7a64c74 admin/coverage: only measure core crate coverage 94d4cb7 chore(deps): update dependency go to v1.24.1 a209a0e
    # docs: link to manual from front page 8464356 Mark unreachable functions with coverage(off) 4f2d21e Prefer to put
    # check-cfg data in Cargo.toml Additional commits viewable in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=rustls&package-manager=cargo&p
    # revious-version=0.23.23&new-version=0.23.25)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-
    # dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
+https://github.com/servo/servo/pull/35990	(@nicoburns, #35990)	Upgrade Stylo to 2025-03-15 (#35990)
    # Upgrade Stylo to version 2025-03-15.  Currently uses a git version of `cssparser` as the new version of Stylo requires
    # unreleased cssparser changes.
    # - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors
    upgrade
+https://github.com/servo/servo/pull/34964	(@longvatrong111, #34964)	Implement declarative shadow dom (#34964)
    # Implement declarative shadow dom
    # html5ever PR: https://github.com/servo/html5ever/pull/568 https://github.com/servo/html5ever/pull/578
    # Test cases: servo/tests/wpt/tests/shadow-dom/declarative
    # - Implement DOD parsing in InTemplate mode - Expose HTMLTemplate Element's attributes to js - Some other minor updates
    # cc: @xiaochengh
    dom shadowdom
>>> 2025-03-19T06:03:34Z
+https://github.com/servo/servo/pull/35878	(@pewsheen, #35878)	feat: fetch notification image resources (#35878)
    # Part of https://github.com/servo/servo/issues/34841
    # Fetch image resources in `Notification` https://notifications.spec.whatwg.org/#fetch-steps
    dom notification
+https://github.com/servo/servo/pull/36030	(@Loirooriol, #36030)	layout: Fix intrinsic contributions of indefinite `stretch` keyword (#36030)
    # In #35630 I treated an indefinite `stretch` as 0px on min sizing properties, and as `none` on max sizing properties.
    # However, this was only for final layout sizes, I forgot about intrinsic contributions.
    # Blink already modified the relevant test, I'm just reordering it a bit since we are no longer treating `stretch` as
    # `fit-content`, so it seems better to test it at the end.
    layout
+https://github.com/servo/servo/pull/35967	(@sebsebmc@gmail.com, #35967)	bugfix: servoshell: prevent 0 pixel dimensions for render area (#35967)
    # This prevents the compositor from crashing from having a 0px dimension for the rendering surface.
    # I intend to submit a separate PR for preventing this upstream in the compositor as well.
    # --- - [X] `./mach build -d` does not report any errors - [X] `./mach test-tidy` does not report any errors - [X] These
    # changes fix #35714 (GitHub issue number if applicable)
    # - [X] These changes do not require tests because this would require testing servoshell.  If there are servoshell tests
    # please let me know where so I can add to them.
    crash
+https://github.com/servo/servo/pull/35761	(@yezhizhen, #35761)	Create `config_dir` if none exist for caching (#35761)
    # 1.  Print like `println!("successfully read from {}", display)` changed to debug, to not [TIMEOUT] wpt-test 2.  Create
    # `config_dir` and use default `fn default_config_dir` if none exists 3.  For OHOS, pass `this.context.cacheDir` as a new
    # field in `InitOpts` interface during the NAPI integration.  It is used as `config_dir`.
    # `auth_cache.json`, `cookie_jar.json`, `local_data.json` etc.  can now be saved in device storage in default setting, to
    # be reused when relaunching the app.
    embedding
-https://github.com/servo/servo/pull/36040	(@dependabot[bot], @dependabot[bot], #36040)	build(deps): bump libgit2-sys from 0.18.0+1.9.0 to 0.18.1+1.9.0 (#36040)
    # Bumps [libgit2-sys](https://github.com/rust-lang/git2-rs) from 0.18.0+1.9.0 to 0.18.1+1.9.0.
    # Changelog Sourced from libgit2-sys's changelog.
    # Changelog 0.20.1 - 2025-03-17 0.20.0...0.20.1 Added
    # Added Repository::branch_upstream_merge() #1131 Added Index::conflict_get() #1134 Added Index::conflict_remove() #1133
    # Added opts::set_cache_object_limit() #1118 Added Repo::merge_file_from_index() and associated MergeFileOptions and
    # MergeFileResult.  #1062
    # Changed
    # The url dependency minimum raised to 2.5.4 #1128 Changed the tracing callback to abort the process if the callback
    # panics instead of randomly detecting the panic in some other function.  #1121 Credential helper config (loaded with
    # CredentialHelper::config) now checks for helpers that start with something that looks like an absolute path, rather than
    # checking for a / or \ anywhere in the helper string (which resolves an issue if the helper had arguments with / or \).
    # #1137
    # Fixed
    # Fixed panic in Remote::url_bytes if the url is empty.  #1120 Fixed incorrect lifetimes on Patch::delta, Patch::hunk, and
    # Patch::line_in_hunk.  The return values must not outlive the Patch.  #1141 Bumped requirement to libgit2-sys 0.18.1,
    # which fixes linking of advapi32 on Windows.  #1143
    # 0.20.0 - 2025-01-04 0.19.0...0.20.0 Added
    # Debug is now implemented for transport::Service #1074 Added Repository::commondir #1079 Added
    # Repository::merge_base_octopus #1088 Restored impls for PartialOrd, Ord, and Hash for bitflags types that were
    # inadvertently removed in a prior release.  #1096
    # ... (truncated)
    # Commits
    # dc63db5 Merge pull request #990 from ehuss/new-release 83c0d98 Release 0.18.1 a66496a Merge pull request #989 from
    # ehuss/fix-tree-walk-cb 67fcacc Merge pull request #988 from ehuss/fix-visibility 2b2fb37 Merge pull request #979 from
    # blyxyas/shallow-clone 7a80cc2 Add shallow cloneing capability 6008651 Don't pretend that TreeWalkCbData is transparent.
    # 952ada3 Fix visibility of StashSaveOptions and DiffPatchidOptions.  ff9dca2 Merge pull request #985 from
    # ehuss/fix-publish-submodule 8775a68 Fix publish of submodule.  See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=libgit2-sys&package-manager=ca
    # rgo&previous-version=0.18.0+1.9.0&new-version=0.18.1+1.9.0)](https://docs.github.com/en/github/managing-security-vulnera
    # bilities/about-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36039	(@dependabot[bot], @dependabot[bot], #36039)	build(deps): bump time from 0.3.39 to 0.3.40 (#36039)
    # Bumps [time](https://github.com/time-rs/time) from 0.3.39 to 0.3.40.
    # Release notes Sourced from time's releases.
    # v0.3.40 See the changelog for details.
    # Changelog Sourced from time's changelog.
    # 0.3.40 [2025-03-18] Added
    # Visibility modifiers may now be added to the mod generated by time::sere::format_description!.
    # Commits
    # 6de297b v0.3.40 release c386cac Move days_in_month to time-core 84f3a75 Remove two-way conversion in arithmetic 79a4b62
    # Move interop between datetime types to single mod 56187f1 Remove region markers 1bc4ce0 Update to deranged 0.4 ad945a9
    # Fix UI tests, build on MSRV b2b602a Permit visibility in serde::format_description!  e3dcbd3 Pull floored division
    # algorithm from stdlib See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=time&package-manager=cargo&pre
    # vious-version=0.3.39&new-version=0.3.40)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-depe
    # ndabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36038	(@dependabot[bot], @dependabot[bot], #36038)	build(deps): bump windows-link from 0.1.0 to 0.1.1 (#36038)
    # Bumps [windows-link](https://github.com/microsoft/windows-rs) from 0.1.0 to 0.1.1.
    # Commits
    # See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=windows-link&package-manager=c
    # argo&previous-version=0.1.0&new-version=0.1.1)](https://docs.github.com/en/github/managing-security-vulnerabilities/abou
    # t-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
+https://github.com/servo/servo/pull/35650	(@gterzian, @Taym95, #35650)	Streams: Implement stream pipe-to (#35650)
    # Implement https://streams.spec.whatwg.org/#rs-pipe-to
    # Part of https://github.com/servo/servo/issues/34676
    dom stream
+https://github.com/servo/servo/pull/35551	(@stevennovaryo, #35551)	dom: Implement minimal IntersectionObserver workflow (#35551)
    # Implement minimal IntersectionObserver [processing
    # model](https://w3c.github.io/IntersectionObserver/#intersection-observer-processing-model) which includes the
    # [processing model algorithm](https://w3c.github.io/IntersectionObserver/#algorithms), omitting the implementation
    # documented in the tracking issue.  Most of the major implementations would depends on other API/module.
    # ### WPT Result
    # We are not experiencing timeouts in the many of IntersectionObserver WPT tests that happens because no intersection is
    # reported.  Although the intersection reported is not accurate because of the aforementioned reasons.  More of "first
    # rAF" started to pass too, presumably because in the initial observations, many of the intersections cases is still not
    # stimulated yet.
    # Test `/intersection-observer/nested-cross-origin-iframe.sub.html` produces quite flaky result, either between `TIMEOUT`
    # or `FAIL`.  Due to `scrollIntoView` is yet to be implemented, test is supposed to fail.  I guess it might be caused by
    # the bad timing of event loop.  Update: this test seems to be quite stable after several additional commits.  Still could
    # create a different issue for this specific test.
    # cc: @xiaochengh
    # [Try](https://github.com/stevennovaryo/servo/actions/runs/13608414761)
    dom
+https://github.com/servo/servo/pull/36010	(@simonwuelker, #36010)	Set composed flag for mouse events dispatched by the UA (#36010)
    # Part of https://github.com/servo/servo/issues/35997 Supports https://github.com/servo/servo/pull/35684
    dom
-https://github.com/servo/servo/pull/36017	(@dklassic, #36017)	chore: Move unsafe operations in unsafe functions to unsafe blocks (#36017)
    # This PR addresses parts of low-hanging tasks of #35955 by removing `unsafe_op_in_unsafe_fn = { level = "allow" }` lint
    # and cleaning up the unsafe codes in the following three crates:
    # - `allocator` - `background_hang_monitor` - `servoshell`
    # I have checked all platform builds and confirmed that there is no unsafe operation warning:
    # https://github.com/dklassic/servo/actions/runs/13908206395
-https://github.com/servo/servo/pull/36019	(@servo-wpt-sync, #36019)	Update web-platform-tests to revision b'18fda923cafeb4e3e0546ffcfb2302c3b1b11f98' (#36019)
    # Automated downstream sync of changes from upstream as of 18-03-2025 [no-wpt-sync]
>>> 2025-03-20T06:06:12Z
+https://github.com/servo/servo/pull/36043	(@aryaajitnair@gmail.com, #36043)	feat: add can_gc argument to to_frozen_array (#36043)
    dom crash
-https://github.com/servo/servo/pull/36060	(@dependabot[bot], @dependabot[bot], #36060)	build(deps): bump bytemuck_derive from 1.8.1 to 1.9.1 (#36060)
    # Bumps [bytemuck_derive](https://github.com/Lokathor/bytemuck) from 1.8.1 to 1.9.1.
    # Changelog Sourced from bytemuck_derive's changelog.
    # 1.9.1
    # Bumped the minimum bytemuck_derive dependency version from 1.0 to 1.1.  The fact that bytemuck and bytemuck_derive are
    # separate crates at all is an unfortunate technical limit of current Rust, woe and calamity.
    # 1.9.0
    # fu5ha added the NoUninit, AnyBitPattern, and CheckedBitPattern traits.  This allows for a more fine-grained level of
    # detail in what casting operations are allowed for a type.  Types that already implement Zeroable and Pod will have a
    # blanket impl for these new traits.  This is a &quot;preview&quot; of the direction that the crate will probably go in
    # the eventual 2.0 version.  We're still waiting on Project Safe Transmute for an actual 2.0 version of the crate, but
    # until then please enjoy this preview.  Also Fusha added better support for union types in the derive macros.  I still
    # don't know how any of the proc-macro stuff works at all, so please direct questions to her.
    # 1.8.0
    # try_pod_read_unaligned and pod_read_unaligned let you go from &amp;[u8] to T:Pod without worrying about alignment.
    # 1.7.3
    # Experimental support for the portable_simd language extension under the nightly_portable_simd cargo feature.  As the
    # name implies, this is an experimental crate feature and it's not part of the semver contract.  All it does is add the
    # appropriate Zeroable and Pod impls.
    # 1.7.2
    # Why does this repo keep being hit with publishing problems?  What did I do to deserve this curse, Ferris?  This doesn't
    # ever happen with tinyvec or fermium, only bytemuck.
    # 1.7.1
    # Soundness Fix: The wrap/peel methods for owned value conversion, added to TransparentWrapper in 1.6, can cause a
    # double-drop if used with types that impl Drop.  The fix was simply to add a ManuallyDrop layer around the value before
    # doing the transmute_copy that is used to wrap/peel.  While this fix could technically be backported to the 1.6 series,
    # since 1.7 is semver compatible anyway the 1.6 series has simply been yanked.
    # 1.7
    # In response to [Unsafe Code Guidelines Issue
    # ... (truncated)
    # Commits
    # 9b087bb chore: Release bytemuck_derive version 1.9.1 2a60e3e derive changlog 920e1c7 fix deriving CheckedBitPattern on
    # packed struct (#291) d1d918b chore: Release bytemuck version 1.22.0 f48810f changelog.  ee2f71f Add pod_saturating
    # feature (#303) e023695 bump bytemuck_derive dependency to &gt;= 1.4.1 (#301) 9ec593d Implement Send and Sync for
    # BoxBytes.  (#299) 1f6afb3 Add a pack1 as a related crate for packed integers etc.  (#296) c254af3 chore: Release
    # bytemuck_derive version 1.9.0 Additional commits viewable in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=bytemuck_derive&package-manage
    # r=cargo&previous-version=1.8.1&new-version=1.9.1)](https://docs.github.com/en/github/managing-security-vulnerabilities/a
    # bout-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
+https://github.com/servo/servo/pull/36024	(@longvatrong111, #36024)	Make Element::attach_shadow() and ShadowRoot closer to spec (#36024)
    # - Update `attach_shadow()` according to the spec - Make necessary changes in `ShadowRoot`
    # Test: `tests/wpt/tests/shadow-dom/Element-interface-attachShadow.html`
    # cc: @xiaochengh
    dom shadowdom
+https://github.com/servo/servo/pull/35574	(@longvatrong111, #35574)	Fix UA style value for textarea (#35574)
    # Update UA style value for textarea.  `overflow: hidden !important;` should not be applied to `textarea`
    css
+https://github.com/servo/servo/pull/36022	(@rego@igalia.com, @Loirooriol, #36022)	Add --enable-experimental-web-platform-features command line (#36022)
    # This command line argument will enable a set of web platform features that are under development but not ready to be
    # enabled by default.
    servoshell
+https://github.com/servo/servo/pull/36051	(@Loirooriol, #36051)	layout: Stop ignoring containing block padding for the static position (#36051)
    # The static position rect is calculated assuming that the containing block would be established by the content box of
    # some ancestor, but the actual containing block is established by the padding box.  So we need to add the padding of that
    # ancestor.
    layout
+https://github.com/servo/servo/pull/36015	(@Loirooriol, #36015)	layout: Obey sizing keywords in `layout_for_block_content_size()` (#36015)
    # We were ignoring sizing keywords on the min and max sizing properties.  With this, flexbox layout has full support for
    # sizing keywords.
    layout
-https://github.com/servo/servo/pull/36032	(@delan, #36032)	Devtools parser: add --json output mode (#36032)
    # This patch adds a --json mode for a more diff-friendly and human-analysis-friendly format:
    # ``` $ etc/devtools_parser.py --json --use servo.pcap {"_from": "root", "message": {"applicationType": "browser", "from":
    # "root", "traits": {"customHighlighters": true, "highlightable": true, "networkMonitor": false, "sources": true}}}
    # {"_to": "root", "message": {"frontendVersion": "135.0.1", "to": "root", "type": "connect"}} {"_from": "root", "message":
    # {"from": "root"}} {"_to": "root", "message": {"to": "root", "type": "getRoot"}} {"_from": "root", "message":
    # {"deviceActor": "server1.conn0.device1", "from": "root", "performanceActor": "server1.conn0.performance0",
    # "preferenceActor": "server1.conn0.preference2", "selected": 0}} {"_to": "server1.conn0.device1", "message": {"to":
    # "server1.conn0.device1", "type": "getDescription"}} {"_from": "server1.conn0.device1", "message": {"from":
    # "server1.conn0.device1", "value": {"appbuildid": "20250318210028", "apptype": "servo", "brandName": "Servo",
    # "platformversion": "133.0", "version": "0.0.1"}}} {"_to": "server1.conn0.device1", "message": {"to":
    # "server1.conn0.device1", "type": "getDescription"}} {"_from": "server1.conn0.device1", "message": {"from":
    # "server1.conn0.device1", "value": {"appbuildid": "20250318210028", "apptype": "servo", "brandName": "Servo",
    # "platformversion": "133.0", "version": "0.0.1"}}} ```
+https://github.com/servo/servo/pull/35961	(@Loirooriol, #35961)	layout: Support min/max main keyword sizes in flexbox (#35961)
    # Adds support for min-content, max-content, fit-content and stretch on the min and max main size properties of a flex
    # item.
    # I'm removing `automatic_min_size()` and `flex_base_size()` because they would need to share so much code among
    # themselves and their one caller that it's simpler to just inline the code.
    layout flexbox
-https://github.com/servo/servo/pull/35956	(@atbrakhi, #35956)	devtools: Use `webview_id` as `browser_id` (#35956)
    # This PR refactors DevTools to use `webview_id` as `browser_id`
    # These changes do not affect the current behavior of the DevTools in Servo.
-https://github.com/servo/servo/pull/36046	(@Loirooriol, #36046)	Cleanup Stylo dependencies (#36046)
    # Now that Stylo considers `servo` as the default feature, Servo doesn't need to specify `features = ["servo"]`.
    # Also use the same crate names as Stylo, rather than renaming them with `package`.
+https://github.com/servo/servo/pull/36045	(@Loirooriol, #36045)	layout: Don't consider a definite `stretch` size as intrinsic (#36045)
    # `block_size_is_zero_or_intrinsic()` was always returning true for `stretch`.  This function is used for the margin
    # collapse heuristics in block layout, so we were considering that an empty element with `height: stretch` would
    # self-collapse.
    layout
+https://github.com/servo/servo/pull/35993	(@simonwuelker, #35993)	script: Implement `Range::getClientRects` and `Range::getBoundingClientRect` (#35993)
    # This allows the scripts on https://www.shadertoy.com/view/MdyGRW to run long enough for the shader to load and run.
    # The implementation is not complete, as we can't query the client rects of ranges within a text node yet, but it's a
    # start.
    dom
+https://github.com/servo/servo/pull/36054	(@stephenmuss, #36054)	Support align attribute on HTMLParagraphElement interface (#36054)
    # Adds support for the `align` attribute in `HTMLParagraphElement`.
    dom
+https://github.com/servo/servo/pull/35668	(@delan, #35668)	libservo: Notify delegates of send errors in request objects (#35668)
    # This patch centralises IPC error handling for delegate request objects by adding a new ServoError variant that gets
    # passed to ServoDelegate::notify_error().  These errors come from request objects via an internal crossbeam channel.
    embedding
>>> 2025-03-21T06:09:05Z
-https://github.com/servo/servo/pull/36073	(@nicoburns, #36073)	Upgrade cssparser to 0.35 (#36073)
    # Upgrades: - cssparser to 0.35 - stylo to a version that uses cssparser 0.35
    # Both Servo and Stylo were already using the same version of cssparser (just as a git dependency).  This updates them to
    # pull it in as a crates.io dependency now that it has been published.
    # Stylo PR (to be merged first): - [x] https://github.com/servo/stylo/pull/155
-https://github.com/servo/servo/pull/36067	(@dependabot[bot], @dependabot[bot], #36067)	build(deps): bump bytemuck_derive from 1.9.1 to 1.9.2 (#36067)
    # Bumps [bytemuck_derive](https://github.com/Lokathor/bytemuck) from 1.9.1 to 1.9.2.
    # Changelog Sourced from bytemuck_derive's changelog.
    # bytemuck changelog 1.22
    # Add the pod_saturating feature, which adds Pod impls for Saturating&lt;T&gt; when T is already Pod.  A bump in the
    # minimum bytemuck_derive dependency from 1.4.0 to 1.4.1 to avoid a bug if you have a truly ancient cargo.lock file
    # sitting around.  Adds Send and Sync impls to BoxBytes.
    # 1.21
    # Implement Pod and Zeroable for core::arch::{x86, x86_64}::__m512, __m512d and __m512i without nightly.  Requires Rust
    # 1.72, and is gated through the avx512_simd cargo feature.  Allow the use of must_cast_mut and must_cast_slice_mut in
    # const contexts.  Requires Rust 1.83, and is gated through the must_cast_extra cargo feature.  internal: introduced the
    # maybe_const_fn macro that allows defining some function to be const depending upon some cfg predicate.
    # 1.20
    # New functions to allocate zeroed Arc and Rc.  Requires Rust 1.82 TransparentWrapper impls for core::cmp::Reverse and
    # core::num::Saturating.  internal: Simplified the library's fill_zeroes calls to write_bytes
    # 1.19
    # Adds the #[track_caller] attribute to functions which may panic.
    # 1.18
    # Adds the latest_stable_rust cargo feature, which is a blanket feature that turns all other features on that are both
    # sound and compatible with Stable rust.
    # 1.17.1
    # Adds #[repr(C)] to the union Transmute&lt;A, B&gt; type that's used internally for most of the transmutations.
    # 1.17.0
    # Makes the must_cast versions of the by-value and by-ref casts be const.  The mut ref cast is unaffected for now (mut
    # references aren't yet stable in const fn).  This increases the MSRV of using that particular feature from 1.57 to 1.64.
    # 1.16.3
    # Fully described in Lokathor/bytemuck#256, This makes casting slices to/from ZST elements more consistent between the
    # crate's core module and other modules.
    # ... (truncated)
    # Commits
    # 66569e6 chore: Release bytemuck_derive version 1.9.2 5c301b1 remove resolver from the Cargo.toml 3053413 update the
    # .cargo/config.toml to use the &quot;stable rust&quot; feature.  See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=bytemuck_derive&package-manage
    # r=cargo&previous-version=1.9.1&new-version=1.9.2)](https://docs.github.com/en/github/managing-security-vulnerabilities/a
    # bout-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36037	(@TG199, #36037)	chore: simplify linux workflow (#36037)
>>> 2025-03-22T06:08:37Z
-https://github.com/servo/servo/pull/36068	(@richarddushime, #36068)	[New]Simplify mac-wpt workflow. (#36068)
-https://github.com/servo/servo/pull/36087	(@dependabot[bot], @dependabot[bot], #36087)	build(deps): bump cc from 1.2.16 to 1.2.17 (#36087)
    # Bumps [cc](https://github.com/rust-lang/cc-rs) from 1.2.16 to 1.2.17.
    # Release notes Sourced from cc's releases.
    # cc-v1.2.17 Other
    # Regenerate target info (#1439) Regenerate windows sys bindings (#1437) Fix wasm32-wali-linux-musl target parsing (#1434)
    # Parse rustc target names (#1413) Regenerate target info (#1429) Added base support for wasm32-wali-linux-musl target
    # (#1373)
    # Changelog Sourced from cc's changelog.
    # 1.2.17 - 2025-03-21 Other
    # Regenerate target info (#1439) Regenerate windows sys bindings (#1437) Fix wasm32-wali-linux-musl target parsing (#1434)
    # Parse rustc target names (#1413) Regenerate target info (#1429) Added base support for wasm32-wali-linux-musl target
    # (#1373)
    # Commits
    # d9dd20e chore: release v1.2.17 (#1435) c964f0e Regenerate target info (#1439) a140cc7 Regenerate windows sys bindings
    # (#1437) 55051eb Update windows-bindgen requirement from 0.60 to 0.61 (#1436) 8054df0 Fix wasm32-wali-linux-musl target
    # parsing (#1434) d2a5991 ci: fix creating issue comment (#1433) cfb6a7c Fix failure from cargo not propagating because of
    # pipe (#1432) 968da78 Parse rustc target names (#1413) 20300d5 Regenerate target info (#1429) 830eea9 Added base support
    # for wasm32-wali-linux-musl target (#1373) Additional commits viewable in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=cc&package-manager=cargo&previ
    # ous-version=1.2.16&new-version=1.2.17)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-depend
    # abot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35985	(@mrobinson, #35985)	metrics: Simplify `ProgressiveWebMetrics` (#35985)
    # Simply how `ProgressiveWebMetrics` works:
    # 1.  Keep only a single struct instead of one in layout and one script
    #    that both implement the `ProgressiveWebMetrics` trait.  Since layout and script are the same thread these can now
    #    just be a single `ProgressiveWebMetrics` struct stored in script.
    # 2.  Have the compositor be responsible for informing the Constellation
    #    (which informs the ScripThread) about paint metrics.  This makes communication flow one way and removes one
    #    dependency between the compositor and script (of two).
    # 3.  All units tests are moved into the `metrics` crate itself since there
    #    is only one struct there now.
    # Signed-off-by: Martin Robinson
-https://github.com/servo/servo/pull/36062	(@mrobinson, #36062)	constellation: Proxy `ScrollState` through the `Constellation` (#36062)
    # This will allow removing the dependency of the compositor on `script_traits`, which should make our internal dependency
    # chain a lot easier to deal with.
    # Part of #35984.
    # Signed-off-by: Martin Robinson
+https://github.com/servo/servo/pull/36058	(@rayguo17, #36058)	pixels: Extend Image to allow for multiple frames (#36058)
    # Partial of https://github.com/servo/servo/issues/36057
    # Add the ability to parse `Gif` animated image into multiple `ImageFrame`.
    animated-images
>>> 2025-03-23T06:10:06Z
+https://github.com/servo/servo/pull/35892	(@greg-morenz@droid.cafe, #35892)	Use explicit reborrows with mozjs::MutableHandle (#35892)
    # `mozjs` allowed copying `MutableHandle`.  `MutableHandle` currently implements `DerefMut`, allowing trivial undefined
    # behavior (copy a Mutable handle, deref_mut both the original and the new one, and you have an aliasing violation).  The
    # `DerefMut` implementation itself needs to go eventually, but the principle of a unique-writer is probably going to stay.
    crash
+https://github.com/servo/servo/pull/35908	(@kenzieradityatirtarahardja18@gmail.com, @kenzieradityatirtarahardja.18@gmail.com, #35908)	Make input element display-inside always flow-root (#35908)
    # Make so that inner display type of an input element always `flow-root`
    # - [X] `./mach build -d` does not report any errors - [X] `./mach test-tidy` does not report any errors - [X] These
    # changes fix #33669 - [X] There are
    # [tests](https://github.com/servo/servo/pull/35908/files#diff-a5c4b30fe962daa68bf1b6213a8bb864a545e49818202da0da29b62dbb7
    # d3f49)
    # for these changes OR
    # Try: https://github.com/PotatoCP/servo/actions/runs/13891284110
    # cc @xiaochengh
    layout
+https://github.com/servo/servo/pull/36064	(@kenzieradityatirtarahardja18@gmail.com, @kenzieradityatirtarahardja.18@gmail.com, #36064)	Max assign outer block size to cell measures (#36064)
    # Previously, we have a bug for height of a row that span > 1.
    # ```
    #       lorem ipsum
    # ```
    # ![image](https://github.com/user-attachments/assets/1aba50e0-5339-43d3-8651-fbd27b9ffdf3)
    # After the change, it looks much better
    # ![image](https://github.com/user-attachments/assets/29b00c9a-85b2-4003-9cd9-06a6cfd0d5cf)
    # However we still have some issue with property `border-collapse: collapse`
    # ![image](https://github.com/user-attachments/assets/612e4d1b-5ff0-42c2-847b-b5e8b9627ffa)
    # This change also pass the previously failed subtest of `rowspan-height-redistribution.html` (test 22 and 23)
    # --- - [X] `./mach build -d` does not report any errors - [X] `./mach test-tidy` does not report any errors - [ ] This is
    # discussed here [comment](https://github.com/servo/servo/issues/35113)
    # - [X] There are
    # [tests](https://github.com/servo/servo/pull/36064/files#diff-ffa437be03e46134f3688076223d9e5eecb1af3f03ccb9d10ed2962332b
    # a6fe7)
    # for these changes
    # Try: https://github.com/PotatoCP/servo/actions/runs/13962809558
    # @Loirooriol cc: @xiaochengh @d-desiatkin
    layout
+https://github.com/servo/servo/pull/36095	(@jdm, #36095)	crown: Do not check trait item projections. (#36095)
    # When crown recurses on a trait method like `fn id(&self) -> Self::ID`, the `Self::ID` is an alias type that is a
    # projection.  The type walker will first consider the alias, then recurse to the Self type.  This is overly conservative,
    # since it doesn't matter if the Self type must be rooted, since we're only referring to an associated item here.
    # --- - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors - [x] These
    # changes fix #35570 - [x] There are tests for these changes
    dom
+https://github.com/servo/servo/pull/36090	(@elomscansio, #36090)	Fix form validation for readonly inputs and update WPT expectations (#36090)
    # This PR fixes an issue where certain non-text form inputs failed the `willValidate` property test due to an unnecessary
    # check in `is_instance_validatable`.
    # ### **What Changed?** - Removed the `does_readonly_apply()` check, as the HTML specification states that any input with
    # the `readonly` attribute must be barred from constraint validation.  - **Updated the expected test results** in the
    # `.ini` file to match the correct behavior.
    # ### **Why?** - The HTML spec does not require checking if `readonly` applies to an input type for validation purposes.
    # - The extra check (`does_readonly_apply()`) caused test failures in:
    #   ``` tests/wpt/meta/html/semantics/forms/constraints/form-validation-willValidate.html.ini ```
    # - Updating the test expectations ensures the tests reflect the correct behavior.
    # ### **How to Test?** Run the following command to verify the fix and updated expectations: ```sh
    # ./mach test-wpt tests/wpt/tests/html/semantics/forms/constraints/form-validation-willValidate.html
    # ```
    #  Expected result: **All previously failing tests should now pass.**
    # ### **References** - [Servo Testing Guide - Updating WPT
    # Expectations](https://book.servo.org/hacking/testing.html#updating-web-platform-test-expectations) - [HTML Spec -
    # Readonly and Constraint Validation](https://html.spec.whatwg.org/multipage/)
    dom
https://github.com/servo/servo/pull/36088	(@mrobinson, #36088)	Create a `constellation_traits` crate (#36088)
    # This change creates a `constellation_traits` crate.  Previously messages to the `Constellation` were in the
    # `compositing_traits` crate, which came about organically.  This change moves these to a new crate which also contains
    # data types that are used in both compositing/libservo and script (ie types that cross the process boundary).  The idea
    # is similar to `embedding_traits`, but this is meant for types *not* exposed to the API.
    # This change allows deduplicating `UntrustedNodeAddress`, which previously had two versions to avoid circular
    # dependencies.
    # Signed-off-by: Martin Robinson
-https://github.com/servo/servo/pull/36093	(@jerensl, #36093)	devtools: refactor network related (#36093)
    # This is refactoring network related to new file for future network monitor support
>>> 2025-03-24T06:07:17Z
+https://github.com/servo/servo/pull/36103	(@jerensl, #36103)	fix: radio input element don't trigger validity state (#36103)
    # This fix sibling radio input elements don't trigger validity state updates
    # ![xdph_screenshot_24179d53](https://github.com/user-attachments/assets/37d31bcb-0bda-4635-b8de-46f650660629)
    dom
+https://github.com/servo/servo/pull/36106	(@simonwuelker, #36106)	script: Implement `Element::GetHTML` and `ShadowRoot::GetHTML` (#36106)
    # These are fairly new (part of [baseline 2024](https://web.dev/baseline/2024)).  The main difference to things like
    # `outerHTML` is that they also serialize shadow roots.
    # An significant part of this change is that serializing html fragments[^1] no longer uses the `Serialize` trait[^2] from
    # html5ever.  The trait tries to cover both XML[^4] and HTML[^1] serialization, despite them having different parameters
    # and being defined in different specifications.  It also doesn't really do anything (it is only used for `serialize`[^3],
    # which is very short).  So instead of rewiring html5ever to support the parameters we need, it's easier to just drive the
    # serializer ourselves.
    # [^1]: https://html.spec.whatwg.org/multipage/parsing.html#html-fragment-serialisation-algorithm [^2]:
    # https://docs.rs/html5ever/latest/html5ever/serialize/trait.Serialize.html [^3]:
    # https://docs.rs/html5ever/latest/html5ever/serialize/fn.serialize.html [^4]:
    # https://w3c.github.io/DOM-Parsing/#dfn-xml-serialization
    dom shadowdom
-https://github.com/servo/servo/pull/35859	(@webbeef, #35859)	webgpu: leverage routed_promise in calls returning promises (#35859)
    # Using the RoutedPromiseListener let us define a different response types for each promise.  This removes unreachable
    # branches that used to exist when they all shared the same WebGPUResponse.
https://github.com/servo/servo/pull/36107	(@jdm, #36107)	script: Ensure promises are considered DOM interfaces when generating bindings. (#36107)
    # Promises in the generated bindings rely on the `` generics which is driven by the containsDomType function.  In code
    # that only considers the Promise type (such as a typedef), we were not adding the generics correctly because promises
    # were not considered DOM types.
    # --- - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors - [x] These
    # changes fix #36083 - [x] There are tests for these changes
    dom split
+https://github.com/servo/servo/pull/36056	(@Loirooriol, #36056)	layout: Implement the `fit-content()` sizing function (#36056)
    # Spec: https://drafts.csswg.org/css-sizing-3/#funcdef-width-fit-content
    # It's similar to the `fit-content` keyword but, instead of clamping the stretch size between `min-content` and
    # `max-content`, it clamps the provided argument.
    # So now that we support `fit-content`, it's quite straightforward to add.  It's just not completely clear what should
    # happen when the argument has a cyclic percentage, so this may need some further adjustments depending on the outcome of
    # https://github.com/w3c/csswg-drafts/issues/11805
    # Stylo PR: https://github.com/servo/stylo/pull/153
    layout
+https://github.com/servo/servo/pull/36104	(@simonwuelker, #36104)	Don't clear children of declarative shadow hosts when imperatively attaching another shadow root (#36104)
    # Instead we should remove all children of the existing shadow root.  (As stated in the spec comment)
    dom shadowdm
-https://github.com/servo/servo/pull/36089	(@mrobinson, #36089)	compositor: Remove the script channel from the compositor (#36089)
    # This is a clean up after #36062 and #35985.  It removes the script channel for each pipeline from the compositor.  Now
    # all messages are sent via the `Constellation` first, which will allow breaking the dependency on script in the
    # compositor.
    # In addition, scroll states are actually sent via the `Constellation`, which was an oversight from #36062.  Finally, a
    # typo in a method name is fixed.
    # Signed-off-by: Martin Robinson
    # --- - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors - [x] These
    # changes are part of #35984.  - [x] These changes are covered by existing WPT tests and have no observable behavior
    # effects.
-https://github.com/servo/servo/pull/36102	(@mrobinson, #36102)	Remove `components/shared/compositing/constellation_msg.rs` (#36102)
    # This file is dead code and I mistakenly did not remove it in #36088.
    # Signed-off-by: Martin Robinson
+https://github.com/servo/servo/pull/35017	(@webbeef, @mrobinson, #35017)	script: Allow opening links in a new `WebView` (#35017)
    #    This changes starts tracking the keyboard modifier state in the
    # `Constellation` and forwards it with every input event.  The state is used to modify the target of link click so when
    # the platform-dependent alternate action key is enabled, the target is overriden to "_blank".
    # In addition, specification step numbers and text is updated.
    # Co-authored-by: Martin Robinson Signed-off-by: webbeef Signed-off-by: Martin Robinson
    embedding
-https://github.com/servo/servo/pull/36101	(@sagudev, #36101)	Fix WPT Import (#36101)
    # Log files were renamed in #36037
    # related https://github.com/servo/servo/pull/36098
-https://github.com/servo/servo/pull/36099	(@simonwuelker, #36099)	Add commented patch definition for html5ever crates (#36099)
    # I find myself frequently needing to build with a local html5ever version.  We have similar blocks for stylo and
    # webrender, and I think it makes sense to have them for every group of dependencies that is owned by servo.
-https://github.com/servo/servo/pull/36098	(@sagudev, #36098)	ci: Fix WPT import (#36098)
    # Log files were renamed in https://github.com/servo/servo/pull/36037
>>> 2025-03-25T06:08:25Z
+https://github.com/servo/servo/pull/35683	(@IsaacMarovitz, #35683)	servoshell: Use sRGB colorspace on macOS (#35683)
    # By default, macOS will use a `NSWindow` in Display P3, in the case of Servo, which lacks proper color space management,
    # this results in sRGB colors becoming oversaturated and bright as they are improperly displayed.  To resolve this, we can
    # force macOS to use an sRGB `NSWindow`.
    # This will of course need to be changed/removed if and when Servo gains proper wide color gamut support.
    # This change does not fix the improper clipping of wide color gamut values observed in the original issue.
    # Before:
    # After:
    # --- - [X] `./mach build -d` does not report any errors - [X] `./mach test-tidy` does not report any errors - [X] These
    # changes improve, but don't fix #33676, #33356 - [X] These changes do not require tests because they only affect
    # servoshell presentation
    servoshell macOS
-https://github.com/servo/servo/pull/36135	(@aryaajitnair@gmail.com, #36135)	fix: does_settings_prohibit_mixed_security_contexts typo (#36135)
-https://github.com/servo/servo/pull/36127	(@dependabot[bot], @dependabot[bot], #36127)	build(deps): bump log from 0.4.26 to 0.4.27 (#36127)
    # Bumps [log](https://github.com/rust-lang/log) from 0.4.26 to 0.4.27.
    # Release notes Sourced from log's releases.
    # 0.4.27 What's Changed
    # A few minor lint fixes by @​nyurik in rust-lang/log#671 Enable clippy support for format-like macros by @​nyurik in
    # rust-lang/log#665 Add an optional logger param by @​tisonkun in rust-lang/log#664 Pass global logger by value, supplied
    # logger by ref by @​KodrAus in rust-lang/log#673 Prepare for 0.4.27 release by @​KodrAus in rust-lang/log#674
    # Full Changelog: https://github.com/rust-lang/log/compare/0.4.26...0.4.27
    # Changelog Sourced from log's changelog.
    # [0.4.27] - 2025-03-24 What's Changed
    # A few minor lint fixes by @​nyurik in rust-lang/log#671 Enable clippy support for format-like macros by @​nyurik in
    # rust-lang/log#665 Add an optional logger param by @​tisonkun in rust-lang/log#664 Pass global logger by value, supplied
    # logger by ref by @​KodrAus in rust-lang/log#673
    # Full Changelog: https://github.com/rust-lang/log/compare/0.4.26...0.4.27
    # Commits
    # 35161d0 Merge pull request #674 from rust-lang/cargo/0.4.27 cc131ef prepare for 0.4.27 release ea6f54d Merge pull
    # request #673 from rust-lang/feat/logger-by-ref d229c73 fix unclosed code block 02486e4 fill in more tests for logger
    # argument 71e034f expand logger tests dfa067e fix up kv passing 39d4c3a run fmt 7aacc8f pass global logger by value,
    # supplied logger by ref a438c6e Merge pull request #664 from tisonkun/logger-field Additional commits viewable in compare
    # view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=log&package-manager=cargo&prev
    # ious-version=0.4.26&new-version=0.4.27)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-depen
    # dabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
+https://github.com/servo/servo/pull/36055	(@pewsheen, #36055)	feat(notification): add `EmbedderMsg::ShowNotification` (#36055)
    # Part of: https://github.com/servo/servo/issues/34841
    # I think we can have a rough message for now to play around on the embedder and improve it after we have more ideas.
https://github.com/servo/servo/pull/36082	(@Loirooriol, @mrobinson, #36082)	layout: Cache `IndependentNonReplacedContents::layout()` (#36082)
    # This replaces `IndependentLayout` with `CacheableLayoutResult` and stores it in `LayoutBoxBase` so it can be reused when
    # we need to lay out a box multiple times.
    # This is a generalization of the caching that we had for flexbox, which is now removed in favor of the new one.
    # With this, the number of runs per second in the Chromium perf test `flexbox-deeply-nested-column-flow.html` are
    # multiplied by 3.
    dom notification
>>> 2025-03-26T06:13:36Z
+https://github.com/servo/servo/pull/36136	(@mrees@noeontheend.com, #36136)	Fix check in get_array_index_from_id to return early on ASCII char (#36136)
    dom
+https://github.com/servo/servo/pull/36156	(@aryaajitnair@gmail.com, #36156)	feat: add CanGc argument in get_dictionary_property (#36156)
    dom crash
-https://github.com/servo/servo/pull/36154	(@atouchet, #36154)	Update Dependabot stylo crates again (#36154)
    # This aligns dependabot.yml with the current stylo crates.
-https://github.com/servo/servo/pull/36145	(@simonwuelker, #36145)	Import URLPattern tests (#36145)
    # In preparation for https://github.com/servo/servo/pull/36144
-https://github.com/servo/servo/pull/36153	(@dependabot[bot], @dependabot[bot], #36153)	build(deps): bump rustls-webpki from 0.103.0 to 0.103.1 (#36153)
    # Bumps [rustls-webpki](https://github.com/rustls/webpki) from 0.103.0 to 0.103.1.
    # Release notes Sourced from rustls-webpki's releases.
    # 0.103.1 Release Notes
    # Avoids a possible type inference error when building in projects that also use jhpratt/deranged.
    # What's Changed
    # Add new test case to integration tests by @​dwhjames in rustls/webpki#324 Cargo: ring 0.17.8 -&gt; 0.17.13 by @​cpu in
    # rustls/webpki#329 avoid inference hazard usize comparison by @​cpu in rustls/webpki#334
    # New Contributors
    # @​dwhjames made their first contribution in rustls/webpki#324
    # Full Changelog: https://github.com/rustls/webpki/compare/v/0.103.0...v/0.103.1
    # Commits
    # ab50614 Cargo: version 0.103.0 -&gt; 0.103.1 6488bcc avoid inference hazard usize comparison 51ca321 deny: ignore
    # RUSTSEC-2024-0436 fdb8917 deny: remove LicenseRef-ring eadd17a Cargo: ring 0.17.8 -&gt; 0.17.13 7cb0aa7 split amazon
    # test case into separate source file bd991d2 Add new test case to integration tests See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=rustls-webpki&package-manager=
    # cargo&previous-version=0.103.0&new-version=0.103.1)](https://docs.github.com/en/github/managing-security-vulnerabilities
    # /about-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36150	(@dependabot[bot], @dependabot[bot], #36150)	build(deps): bump thin-vec from 0.2.13 to 0.2.14 (#36150)
    # Bumps [thin-vec](https://github.com/gankra/thin-vec) from 0.2.13 to 0.2.14.
    # Changelog Sourced from thin-vec's changelog.
    # Version 0.2.14 (2025-02-19)
    # Add &quot;malloc_size_of&quot; feature for heap size measurement support
    # Commits
    # See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=thin-vec&package-manager=cargo
    # &previous-version=0.2.13&new-version=0.2.14)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-
    # dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36152	(@dependabot[bot], @dependabot[bot], #36152)	build(deps): bump async-compression from 0.4.21 to 0.4.22 (#36152)
    # Bumps [async-compression](https://github.com/Nullus157/async-compression) from 0.4.21 to 0.4.22.
    # Changelog Sourced from async-compression's changelog.
    # 0.4.22 - 2025-03-25 Other
    # Add lz4 encoder/decoder Expose total_in/total_out in DeflateEncoder
    # Commits
    # 6657e67 Update CHANGELOG.md 7a33560 chore: release v0.4.22 0ed8747 Merge pull request #337 from ardurin/main ca9cd30
    # Merge pull request #331 from arpankapoor/lz4 a45581e Expose total_in/total_out in DeflateEncoder 49375b4 refactor: use
    # actual dst size instead of min_dst_size 2060bb7 refactor: calculate src size just once e189f86 refactor: avoid
    # unwrap_unchecked 9e3774f refactor: drain buffer inside write 1aba65b refactor: rewrite encoder to minimize internal
    # buffer usage Additional commits viewable in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=async-compression&package-mana
    # ger=cargo&previous-version=0.4.21&new-version=0.4.22)](https://docs.github.com/en/github/managing-security-vulnerabiliti
    # es/about-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36149	(@dependabot[bot], @dependabot[bot], #36149)	build(deps): bump time from 0.3.40 to 0.3.41 (#36149)
    # Bumps [time](https://github.com/time-rs/time) from 0.3.40 to 0.3.41.
    # Release notes Sourced from time's releases.
    # v0.3.41 See the changelog for details.
    # Changelog Sourced from time's changelog.
    # 0.3.41 [2025-03-23] Fixed
    # Compatibility with the latest release of deranged.  This fix is permanent and covers future similar changes upstream.
    # Commits
    # cc35dcf v0.3.41 release See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=time&package-manager=cargo&pre
    # vious-version=0.3.40&new-version=0.3.41)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-depe
    # ndabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36148	(@dependabot[bot], @dependabot[bot], #36148)	build(deps): bump stylo_malloc_size_of from `e941241` to `bc4717c` (#36148)
    # Bumps [stylo_malloc_size_of](https://github.com/servo/stylo) from `e941241` to `bc4717c`.
    # Commits
    # bc4717c Prepare for Stylo v0.2.0 release (#151) See full diff in compare view
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
+https://github.com/servo/servo/pull/36097	(@jdm, #36097)	script: Support converting JS values to Rc<Promise> with FromJSValConvertible. (#36097)
    # Depends on https://github.com/servo/mozjs/pull/568.
    # --- - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors - [x] These
    # changes fix #36086 - [x] There are tests for these changes
    dom
-https://github.com/servo/servo/pull/36137	(@sagudev, #36137)	Update names of stylo crates in dependabot.yml (#36137)
    # This is response to https://github.com/servo/servo/pull/36128 that is caused by renames that happened in upstream
    # https://github.com/servo/stylo/pull/150.
    # I want over all PRs that dependabot opened and fix names of those crates.
-https://github.com/servo/servo/pull/36140	(@mukilan, #36140)	build: bump nixpkgs to nixos-unstable (#36140)
    # This fixes an issue with cargo-deny 0.16.3 that causes all crates to be reported as "yanked" even though they are not.
    # This patch upgrades cargo-deny to 0.18.2 which works correctly.
    # --- - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors - [x] These
    # changes do not require tests because they only modify nixos build setup.  I've tested that we are able to build and run
    # servo with the bumped `nixpkgs` version.
-https://github.com/servo/servo/pull/36047	(@MDCODE247, @mukilan, #36047)	Remove references to 2020 layout in try_parser.py (#36047)
    # I have removed all references to 2020 layout in try_parser.py.  I also made sure to change the unit tests and that all
    # the tests were passed.  I clearly commented all of my changes as well.
-https://github.com/servo/servo/pull/36120	(@nicoburns, #36120)	Upgrade to Stylo e941241 (#36120)
    # Ensure that Servo is using the latest Stylo `main`
+https://github.com/servo/servo/pull/36123	(@mrobinson, #36123)	layout: Ensure compatible positioning context during flexbox block content sizing calculation (#36123)
    # Sometimes column Flexbox needs to do an early layout pass to determine the preferred block content size of flex items.
    # Previously the absolutely positioned children created during this pass were discarded, but now they are cached to be
    # possibly used during the final layout phase of the flex item.  Since they are not thrown away, it is necessary that the
    # `PositioningContext` used to collect them is compatible with their final `PositioningContext`.
    # Fixes #36121.
    layout flexbox
-https://github.com/servo/servo/pull/36131	(@dependabot[bot], @dependabot[bot], #36131)	build(deps): bump jiff from 0.2.4 to 0.2.5 (#36131)
    # Bumps [jiff](https://github.com/BurntSushi/jiff) from 0.2.4 to 0.2.5.
    # Changelog Sourced from jiff's changelog.
    # 0.2.5 (2025-03-22) This release updates Jiff's bundled copy of the [IANA Time Zone Database] to 2025b.  See the 2025b
    # release announcement for more details.  Enhancements:
    # #300: Update jiff-tzdb to 2025b.
    # Commits
    # 8d9ff39 0.2.5 86e1497 deps: bump to jiff-tzdb-platform 0.1.3 9395495 jiff-tzdb-platform-0.1.3 ebd7ee4 deps: bump to
    # jiff-tzdb 0.1.4 3ff4513 jiff-tzdb-0.1.4 a93e71a changelog: 0.2.5 e616bf9 jiff-tzdb: update to tzdb 2025b 83c0688 fmt:
    # fix ISO 8601 week date example deee5c4 doc: clarify the guaranteeds for Zoned::{since,until} See full diff in compare
    # view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=jiff&package-manager=cargo&pre
    # vious-version=0.2.4&new-version=0.2.5)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-depend
    # abot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35996	(@sagudev, @mrobinson, #35996)	canvas: Update the image as part of update the rendering (#35996)
    # This moves update the image from layout to update the rendering which is more conceptually correct.  Partial fix of
    # https://github.com/servo/servo/issues/35733.  Simplifies layouting of 2d canvas.
>>> 2025-03-27T06:11:58Z
+https://github.com/servo/servo/pull/35388	(@Legend-Master, #35388)	Allow setting userscripts directly without the need of files (#35388)
    # - Remove userscripts from all places and move it to servoshell - Introduce `UserContentManager` struct and passing it
    # through `Servo::new` all the way down to script thread instead of using `Opts::userscripts`
    # > https://github.com/servo/servo/pull/35388#issuecomment-2749160727
    embedding
+https://github.com/servo/servo/pull/35989	(@jdm, @mrobinson, #35989)	Make DOMPoint and DOMPointReadOnly serializable (#35989)
    # Building on the work from #35831, these changes make two new DOM interfaces serializable via postMessage.  It still
    # involves more copying and pasting than I would prefer, but I let the compiler errors guide me the entire way and I felt
    # much more confident about the end result.
    # --- - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors - [x] There
    # are tests for these changes
    dom
+https://github.com/servo/servo/pull/36116	(@jdm, #36116)	script: Expose new methods for obtaining a global that require a realm. (#36116)
    # Similarly to the ongoing campaign to propagate CanGc arguments, we need to start being more diligent about InRealm
    # arguments.  The realm required for calling `global()` is one of the widest impact, so this PR makes it possible to
    # migrate callsites incrementally.
    # --- - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors - [x] These
    # changes are part of #27037 - [x] These changes do not require tests because they do not affect runtime behaviour
    dom crash
-https://github.com/servo/servo/pull/36172	(@TG199, #36172)	chore: Remove unused generation counter field from LayoutThread (#36172)
-https://github.com/servo/servo/pull/36172	(@TG199, #36172)	chore: Remove unused generation counter field from LayoutThread (#36172)
+https://github.com/servo/servo/pull/36112	(@elomscansio, @jdm, #36112)	Fix Backspace deleting entire previous line in `<textarea>` (#36112)
    # This PR addresses issue **#27523**, where pressing backspace at the beginning of a line in a `` incorrectly deletes the
    # entire contents of the previous line instead of just merging the lines.
    dom
-https://github.com/servo/servo/pull/36170	(@dependabot[bot], @dependabot[bot], #36170)	build(deps): bump quick-xml from 0.37.2 to 0.37.3 (#36170)
    # Bumps [quick-xml](https://github.com/tafia/quick-xml) from 0.37.2 to 0.37.3.
    # Release notes Sourced from quick-xml's releases.
    # v0.37.3 - support for xsi:nil in Deserializer What's Changed New Features
    # #850: Add Attribute::as_bool() method to get an attribute value as a boolean.  #850: Add Attributes::has_nil() method to
    # check if attributes has xsi:nil attribute set to true.  #497: Handle xsi:nil attribute in serde Deserializer to better
    # process optional fields.
    # Full Changelog: https://github.com/tafia/quick-xml/compare/v0.37.2...v0.37.3
    # Changelog Sourced from quick-xml's changelog.
    # 0.37.3 -- 2025-03-25 New Features
    # #850: Add Attribute::as_bool() method to get an attribute value as a boolean.  #850: Add Attributes::has_nil() method to
    # check if attributes has xsi:nil attribute set to true.  #497: Handle xsi:nil attribute in serde Deserializer to better
    # process optional fields.
    # #497: tafia/quick-xml#497 #850: tafia/quick-xml#850
    # Commits
    # 2cedfe1 Release 0.37.3 44644b3 Merge pull request #850 from Mingun/fix/honor_xsi_nil 3c4de88 Migrate to
    # actions/upload-artifact@v4 in fuzzer sub-project 6176c33 Properly use xsi:nil to deserialize null values via serde
    # 10b37f7 Add tests for xsi:nil handling 521707c Add regression tests for #497 b8ce862 Use namespace-aware reader in serde
    # deserializer 341db46 Add helper method to check if xsi:nil value is set in attributes 41b6dc1 Add helper method to check
    # if attribute value represents boolean value 40538b7 Improve debug representation of Attribute and Attributes Additional
    # commits viewable in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=quick-xml&package-manager=carg
    # o&previous-version=0.37.2&new-version=0.37.3)](https://docs.github.com/en/github/managing-security-vulnerabilities/about
    # -dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
+https://github.com/servo/servo/pull/35783	(@lukas@lihotzki.de, #35783)	Add `Path2D` (#35783)
    # This adds Path2D support for 2D canvas.
    # First, I wanted to implement Path2D by sending the corresponding existing messages to the render process, but this does
    # not work because stroking or filling a Path2D must not affect the current path of the canvas.  Therefore, IPC changes
    # are needed.  For now, the path segments are stored in the script thread and sent as part of the new StrokePath,
    # FillPath, or ClipPath messages.  This causes some duplication, because paths can be described as `[PathSegment]` or as
    # multiple Canvas messages.  It is also inconsistent, because Path2D are stored in the script process while the current
    # path of a canvas is stored in the render process.  This inconsistency can be solved by: - Storing the current path of a
    # canvas in the script process and use StrokePath, FillPath, and ClipPath exclusively - Storing Path2D objects in the
    # render process by giving them IDs and add message types for adding single segments to a Path2D ID.  This is inconsistent
    # with the handling of other canvas objects such as gradients.  Also, IDs assigned by the script process would be great to
    # avoid a round-trip per Path2D construction.
    # I think either way would be reasonable, or leaving the basic design as-is.  When the basic design is kept, the
    # individual canvas message types could also be replaced by a single variant that carries a PathSegment.
    # There are some tests in WPT which use Path2D, but this change does not seem to cause any difference of passing.  Can
    # existing WPT tests be used?  Are they sufficient?
    # My motivation for Path2D was to build a very simple SVG-to-canvas renderer to work around the missing SVG support, and
    # to get some experience with the Servo code base.
+https://github.com/servo/servo/pull/36160	(@greg-morenz@droid.cafe, #36160)	Stop using MutableHandle's DerefMut impl (#36160)
    # `MutableHandle`'s `DerefMut` impl cannot be safe, because it allows holding a `&mut` pointer to the pointee over a GC
    # pause, violating aliasing guarantees.  This PR clears the way for servo/mozjs#573 which removes the impl, similar to
    # #36158 which does the same for `RootedGuard`.
    # We actually stop using mutable handle all together in the two cases where the `DerefMut` impl is used, since we can just
    # use the `RootedGuard` we created the mutable handle from directly.  This is merely a coincidence, e.g.  we could do
    # `allowed_id.handle_mut().set(...)` instead of `allowed_id.set(...)`, the latter is just cleaner so while we're making
    # the change we might as well remove the unnecessary `handle_mut()` calls.
    dom crash
+https://github.com/servo/servo/pull/36048	(@gterzian, #36048)	Use read all bytes when consuming body (#36048)
    dom stream
+https://github.com/servo/servo/pull/36161	(@greg-morenz@droid.cafe, #36161)	Stop using JS::MutableHandle's DerefMut impl (#36161)
    # `JS::MutableHandle`'s `DerefMut` impl cannot be safe, because it allows holding a `&mut` pointer to the pointee over a
    # GC pause, violating aliasing guarantees.  Furthermore `JS::MutableHandle` doesn't track lifetimes, so it allows outright
    # use after frees.  This PR clears the way for https://github.com/servo/mozjs/pull/574 which removes the impl, similar to
    # https://github.com/servo/servo/pull/36160 which does the same for `MutableHandle` and
    # https://github.com/servo/servo/pull/36158 which does the same for `RootedGuard.`
    dom crash
-https://github.com/servo/servo/pull/36146	(@mrobinson, #36146)	script: Eliminate `PseudoElementType` (#36146)
    # Servo has a `PseudoElementType` which more or less duplicate's Stylo's `PseudoElement` with the addition of a non-pseudo
    # element variant.  This type needs to be converted into `PseudoElement` anyway when asking for the style of an element
    # from Stylo, so eliminate Servo's version and simply use `Option` with the `None` variant meaning the non-pseudo.
    # This is preparation for adding support for the `::marker` pseudo element.
    # Signed-off-by: Martin Robinson
>>> 2025-03-28T06:07:47Z
-https://github.com/servo/servo/pull/36179	(@aniebietafia, #36179)	Replace some uses of window.global() with upcast. (#36179)
    # All Window objects are also GlobalScope objects, made changes in `servo/components/script/script_thread.rs` and
    # `servo/components/script/dom/windowproxy.rs` to obtain the global scope with `window.upcast::()`.
+https://github.com/servo/servo/pull/36173	(@elomscansio, #36173)	fix(parser): Set shadow’s available to element internals in attach_declarative_shadow (#36173)
    # This PR ensures that the Servo parser correctly follows step 8.5 of the HTML spec when handling `` elements by setting
    # `shadow_root.set_available_to_element_internals(true)` in `attach_declarative_shadow`.
    # #### **Changes** - **Fix:** Added `shadow_root.set_available_to_element_internals(true);` after setting the template's
    # contents property.  - **Cleanup:** Removed
    # `tests/wpt/meta/shadow-dom/declarative/declarative-shadow-dom-available-to-element-internals.html.ini` as the test now
    # passes.
    # #### **Spec Reference** [HTML Spec - Parsing a `` in the InHead
    # state](https://html.spec.whatwg.org/multipage/#parsing-main-inhead) (Step 8.5)
    # #### **Testing** - Confirmed WPT tests pass with the updated behavior.  - Verified that
    # `shadow-dom/declarative/declarative-shadow-dom-available-to-element-internals.html` now behaves as expected.
    dom shadowdom
-https://github.com/servo/servo/pull/36189	(@dependabot[bot], @dependabot[bot], #36189)	build(deps): bump icu_segmenter_data from 1.5.0 to 1.5.1 (#36189)
    # Bumps [icu_segmenter_data](https://github.com/unicode-org/icu4x) from 1.5.0 to 1.5.1.
    # Changelog Sourced from icu_segmenter_data's changelog.
    # Changelog Unreleased
    # Components
    # General
    # ...
    # icu_calendar
    # Rename Islamic calendars to Hijri (unicode-org#6214)
    # icu_collections
    # Remove some panics from CodePointTrie, which should no longer pull in panic machinery even with arithmetic panics
    # enabled for lookup (unicode-org#6204)
    # Data model and providers
    # icu_experimental
    # dimension
    # units
    # Update unit conversion to accept unit constant denominator (unicode-org#6199)
    # General
    # ...
    # icu_provider
    # Put MaybeEncodeAsVarULE behind the &quot;export&quot; feature (unicode-org#6221)
    # icu_provider_fs
    # AbstractSerializer is now a sealed trait (unicode-org#6263)
    # Utils
    # General
    # ...
    # calendrical_calculations
    # Parametrise the HijriObservational calendar by location (unicode-org#6332)
    # icu4x 2.0-beta2
    # Components
    # General
    # Update data to CLDR 47 Beta 1, ICU 77 RC, TZDB 2025a Some crates have been given the ability to be built without alloc
    # (unicode-org#6077, unicode-org#6078, unicode-org#6166) Consistently wrap all options in None in Rust and FFI
    # (unicode-org#6084) Options now consistently live in options modules (unicode-org#6138) Remove compiled_data Default
    # constructors from types which are prone to change sufficiently often (unicode-org#5958) Move types over to uniform
    # ::new() constructor convention (unicode-org#6141) Implement display on all error types (unicode-org#5969) Use
    # core::error, remove unused std features (unicode-org#5973) Remove bench features (unicode-org#5986)
    # icu_calendar
    # Rename IsoWeekday to Weekday (unicode-org#6140) Add Date::wrap_calendar_in_ref (unicode-org#6016) Time and DateTime
    # moved to icu_time component (unicode-org#5961) Audit exhaustiveness of icu_calendar::types (unicode-org#5978) Add
    # calendar argument to IXDTF parsing, making it available without compiled_data feature (unicode-org#5982) Use correct day
    # of year for Japanese (unicode-org#5992)
    # icu_casemap
    # Add borrowed variants to casemapper types (unicode-org#6088)
    # ... (truncated)
    # Commits
    # 6336fc8 Release icu_capi 1.5.1 (#5123) b648017 Fix CHANGELOG.md formatting (#5111) e1193d0 Uplift repr(packed) fix to
    # 1.5 (#5079) 21e7a0b Update changelog 16da579 twox-hash is a dep of zerovec so it should be no_std (#5007) 8510660
    # icu_datetime 1.5.1, icu_calendar 1.5.1 a9186ff Fix Japanese calendar year 0 (#5006) c892e80 Add 1.5.x changelog (#5004)
    # 126c927 fix: assert &gt;= 14 on num days not given day (#4986) See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=icu_segmenter_data&package-man
    # ager=cargo&previous-version=1.5.0&new-version=1.5.1)](https://docs.github.com/en/github/managing-security-vulnerabilitie
    # s/about-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36188	(@dependabot[bot], @dependabot[bot], #36188)	build(deps): bump icu_normalizer_data from 1.5.0 to 1.5.1 (#36188)
    # Bumps [icu_normalizer_data](https://github.com/unicode-org/icu4x) from 1.5.0 to 1.5.1.
    # Changelog Sourced from icu_normalizer_data's changelog.
    # Changelog Unreleased
    # Components
    # General
    # ...
    # icu_calendar
    # Rename Islamic calendars to Hijri (unicode-org#6214)
    # icu_collections
    # Remove some panics from CodePointTrie, which should no longer pull in panic machinery even with arithmetic panics
    # enabled for lookup (unicode-org#6204)
    # Data model and providers
    # icu_experimental
    # dimension
    # units
    # Update unit conversion to accept unit constant denominator (unicode-org#6199)
    # General
    # ...
    # icu_provider
    # Put MaybeEncodeAsVarULE behind the &quot;export&quot; feature (unicode-org#6221)
    # icu_provider_fs
    # AbstractSerializer is now a sealed trait (unicode-org#6263)
    # Utils
    # General
    # ...
    # calendrical_calculations
    # Parametrise the HijriObservational calendar by location (unicode-org#6332)
    # icu4x 2.0-beta2
    # Components
    # General
    # Update data to CLDR 47 Beta 1, ICU 77 RC, TZDB 2025a Some crates have been given the ability to be built without alloc
    # (unicode-org#6077, unicode-org#6078, unicode-org#6166) Consistently wrap all options in None in Rust and FFI
    # (unicode-org#6084) Options now consistently live in options modules (unicode-org#6138) Remove compiled_data Default
    # constructors from types which are prone to change sufficiently often (unicode-org#5958) Move types over to uniform
    # ::new() constructor convention (unicode-org#6141) Implement display on all error types (unicode-org#5969) Use
    # core::error, remove unused std features (unicode-org#5973) Remove bench features (unicode-org#5986)
    # icu_calendar
    # Rename IsoWeekday to Weekday (unicode-org#6140) Add Date::wrap_calendar_in_ref (unicode-org#6016) Time and DateTime
    # moved to icu_time component (unicode-org#5961) Audit exhaustiveness of icu_calendar::types (unicode-org#5978) Add
    # calendar argument to IXDTF parsing, making it available without compiled_data feature (unicode-org#5982) Use correct day
    # of year for Japanese (unicode-org#5992)
    # icu_casemap
    # Add borrowed variants to casemapper types (unicode-org#6088)
    # ... (truncated)
    # Commits
    # 6336fc8 Release icu_capi 1.5.1 (#5123) b648017 Fix CHANGELOG.md formatting (#5111) e1193d0 Uplift repr(packed) fix to
    # 1.5 (#5079) 21e7a0b Update changelog 16da579 twox-hash is a dep of zerovec so it should be no_std (#5007) 8510660
    # icu_datetime 1.5.1, icu_calendar 1.5.1 a9186ff Fix Japanese calendar year 0 (#5006) c892e80 Add 1.5.x changelog (#5004)
    # 126c927 fix: assert &gt;= 14 on num days not given day (#4986) See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=icu_normalizer_data&package-ma
    # nager=cargo&previous-version=1.5.0&new-version=1.5.1)](https://docs.github.com/en/github/managing-security-vulnerabiliti
    # es/about-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36187	(@dependabot[bot], @dependabot[bot], #36187)	build(deps): bump icu_collator_data from 1.5.0 to 1.5.1 (#36187)
    # Bumps [icu_collator_data](https://github.com/unicode-org/icu4x) from 1.5.0 to 1.5.1.
    # Changelog Sourced from icu_collator_data's changelog.
    # Changelog Unreleased
    # Components
    # General
    # ...
    # icu_calendar
    # Rename Islamic calendars to Hijri (unicode-org#6214)
    # icu_collections
    # Remove some panics from CodePointTrie, which should no longer pull in panic machinery even with arithmetic panics
    # enabled for lookup (unicode-org#6204)
    # Data model and providers
    # icu_experimental
    # dimension
    # units
    # Update unit conversion to accept unit constant denominator (unicode-org#6199)
    # General
    # ...
    # icu_provider
    # Put MaybeEncodeAsVarULE behind the &quot;export&quot; feature (unicode-org#6221)
    # icu_provider_fs
    # AbstractSerializer is now a sealed trait (unicode-org#6263)
    # Utils
    # General
    # ...
    # calendrical_calculations
    # Parametrise the HijriObservational calendar by location (unicode-org#6332)
    # icu4x 2.0-beta2
    # Components
    # General
    # Update data to CLDR 47 Beta 1, ICU 77 RC, TZDB 2025a Some crates have been given the ability to be built without alloc
    # (unicode-org#6077, unicode-org#6078, unicode-org#6166) Consistently wrap all options in None in Rust and FFI
    # (unicode-org#6084) Options now consistently live in options modules (unicode-org#6138) Remove compiled_data Default
    # constructors from types which are prone to change sufficiently often (unicode-org#5958) Move types over to uniform
    # ::new() constructor convention (unicode-org#6141) Implement display on all error types (unicode-org#5969) Use
    # core::error, remove unused std features (unicode-org#5973) Remove bench features (unicode-org#5986)
    # icu_calendar
    # Rename IsoWeekday to Weekday (unicode-org#6140) Add Date::wrap_calendar_in_ref (unicode-org#6016) Time and DateTime
    # moved to icu_time component (unicode-org#5961) Audit exhaustiveness of icu_calendar::types (unicode-org#5978) Add
    # calendar argument to IXDTF parsing, making it available without compiled_data feature (unicode-org#5982) Use correct day
    # of year for Japanese (unicode-org#5992)
    # icu_casemap
    # Add borrowed variants to casemapper types (unicode-org#6088)
    # ... (truncated)
    # Commits
    # 6336fc8 Release icu_capi 1.5.1 (#5123) b648017 Fix CHANGELOG.md formatting (#5111) e1193d0 Uplift repr(packed) fix to
    # 1.5 (#5079) 21e7a0b Update changelog 16da579 twox-hash is a dep of zerovec so it should be no_std (#5007) 8510660
    # icu_datetime 1.5.1, icu_calendar 1.5.1 a9186ff Fix Japanese calendar year 0 (#5006) c892e80 Add 1.5.x changelog (#5004)
    # 126c927 fix: assert &gt;= 14 on num days not given day (#4986) See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=icu_collator_data&package-mana
    # ger=cargo&previous-version=1.5.0&new-version=1.5.1)](https://docs.github.com/en/github/managing-security-vulnerabilities
    # /about-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36186	(@dependabot[bot], @dependabot[bot], #36186)	build(deps): bump dwrote from 0.11.2 to 0.11.3 (#36186)
    # Bumps [dwrote](https://github.com/servo/dwrote-rs) from 0.11.2 to 0.11.3.
    # Commits
    # See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=dwrote&package-manager=cargo&p
    # revious-version=0.11.2&new-version=0.11.3)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-de
    # pendabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36185	(@dependabot[bot], @dependabot[bot], #36185)	build(deps): bump icu_calendar_data from 1.5.0 to 1.5.1 (#36185)
    # Bumps [icu_calendar_data](https://github.com/unicode-org/icu4x) from 1.5.0 to 1.5.1.
    # Changelog Sourced from icu_calendar_data's changelog.
    # Changelog Unreleased
    # Components
    # General
    # ...
    # icu_calendar
    # Rename Islamic calendars to Hijri (unicode-org#6214)
    # icu_collections
    # Remove some panics from CodePointTrie, which should no longer pull in panic machinery even with arithmetic panics
    # enabled for lookup (unicode-org#6204)
    # Data model and providers
    # icu_experimental
    # dimension
    # units
    # Update unit conversion to accept unit constant denominator (unicode-org#6199)
    # General
    # ...
    # icu_provider
    # Put MaybeEncodeAsVarULE behind the &quot;export&quot; feature (unicode-org#6221)
    # icu_provider_fs
    # AbstractSerializer is now a sealed trait (unicode-org#6263)
    # Utils
    # General
    # ...
    # calendrical_calculations
    # Parametrise the HijriObservational calendar by location (unicode-org#6332)
    # icu4x 2.0-beta2
    # Components
    # General
    # Update data to CLDR 47 Beta 1, ICU 77 RC, TZDB 2025a Some crates have been given the ability to be built without alloc
    # (unicode-org#6077, unicode-org#6078, unicode-org#6166) Consistently wrap all options in None in Rust and FFI
    # (unicode-org#6084) Options now consistently live in options modules (unicode-org#6138) Remove compiled_data Default
    # constructors from types which are prone to change sufficiently often (unicode-org#5958) Move types over to uniform
    # ::new() constructor convention (unicode-org#6141) Implement display on all error types (unicode-org#5969) Use
    # core::error, remove unused std features (unicode-org#5973) Remove bench features (unicode-org#5986)
    # icu_calendar
    # Rename IsoWeekday to Weekday (unicode-org#6140) Add Date::wrap_calendar_in_ref (unicode-org#6016) Time and DateTime
    # moved to icu_time component (unicode-org#5961) Audit exhaustiveness of icu_calendar::types (unicode-org#5978) Add
    # calendar argument to IXDTF parsing, making it available without compiled_data feature (unicode-org#5982) Use correct day
    # of year for Japanese (unicode-org#5992)
    # icu_casemap
    # Add borrowed variants to casemapper types (unicode-org#6088)
    # ... (truncated)
    # Commits
    # 6336fc8 Release icu_capi 1.5.1 (#5123) b648017 Fix CHANGELOG.md formatting (#5111) e1193d0 Uplift repr(packed) fix to
    # 1.5 (#5079) 21e7a0b Update changelog 16da579 twox-hash is a dep of zerovec so it should be no_std (#5007) 8510660
    # icu_datetime 1.5.1, icu_calendar 1.5.1 a9186ff Fix Japanese calendar year 0 (#5006) c892e80 Add 1.5.x changelog (#5004)
    # 126c927 fix: assert &gt;= 14 on num days not given day (#4986) See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=icu_calendar_data&package-mana
    # ger=cargo&previous-version=1.5.0&new-version=1.5.1)](https://docs.github.com/en/github/managing-security-vulnerabilities
    # /about-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36184	(@dependabot[bot], @dependabot[bot], #36184)	build(deps): bump icu_list_data from 1.5.0 to 1.5.1 (#36184)
    # Bumps [icu_list_data](https://github.com/unicode-org/icu4x) from 1.5.0 to 1.5.1.
    # Changelog Sourced from icu_list_data's changelog.
    # Changelog Unreleased
    # Components
    # General
    # ...
    # icu_calendar
    # Rename Islamic calendars to Hijri (unicode-org#6214)
    # icu_collections
    # Remove some panics from CodePointTrie, which should no longer pull in panic machinery even with arithmetic panics
    # enabled for lookup (unicode-org#6204)
    # Data model and providers
    # icu_experimental
    # dimension
    # units
    # Update unit conversion to accept unit constant denominator (unicode-org#6199)
    # General
    # ...
    # icu_provider
    # Put MaybeEncodeAsVarULE behind the &quot;export&quot; feature (unicode-org#6221)
    # icu_provider_fs
    # AbstractSerializer is now a sealed trait (unicode-org#6263)
    # Utils
    # General
    # ...
    # calendrical_calculations
    # Parametrise the HijriObservational calendar by location (unicode-org#6332)
    # icu4x 2.0-beta2
    # Components
    # General
    # Update data to CLDR 47 Beta 1, ICU 77 RC, TZDB 2025a Some crates have been given the ability to be built without alloc
    # (unicode-org#6077, unicode-org#6078, unicode-org#6166) Consistently wrap all options in None in Rust and FFI
    # (unicode-org#6084) Options now consistently live in options modules (unicode-org#6138) Remove compiled_data Default
    # constructors from types which are prone to change sufficiently often (unicode-org#5958) Move types over to uniform
    # ::new() constructor convention (unicode-org#6141) Implement display on all error types (unicode-org#5969) Use
    # core::error, remove unused std features (unicode-org#5973) Remove bench features (unicode-org#5986)
    # icu_calendar
    # Rename IsoWeekday to Weekday (unicode-org#6140) Add Date::wrap_calendar_in_ref (unicode-org#6016) Time and DateTime
    # moved to icu_time component (unicode-org#5961) Audit exhaustiveness of icu_calendar::types (unicode-org#5978) Add
    # calendar argument to IXDTF parsing, making it available without compiled_data feature (unicode-org#5982) Use correct day
    # of year for Japanese (unicode-org#5992)
    # icu_casemap
    # Add borrowed variants to casemapper types (unicode-org#6088)
    # ... (truncated)
    # Commits
    # 6336fc8 Release icu_capi 1.5.1 (#5123) b648017 Fix CHANGELOG.md formatting (#5111) e1193d0 Uplift repr(packed) fix to
    # 1.5 (#5079) 21e7a0b Update changelog 16da579 twox-hash is a dep of zerovec so it should be no_std (#5007) 8510660
    # icu_datetime 1.5.1, icu_calendar 1.5.1 a9186ff Fix Japanese calendar year 0 (#5006) c892e80 Add 1.5.x changelog (#5004)
    # 126c927 fix: assert &gt;= 14 on num days not given day (#4986) See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=icu_list_data&package-manager=
    # cargo&previous-version=1.5.0&new-version=1.5.1)](https://docs.github.com/en/github/managing-security-vulnerabilities/abo
    # ut-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36183	(@dependabot[bot], @dependabot[bot], #36183)	build(deps): bump icu_casemap_data from 1.5.0 to 1.5.1 (#36183)
    # Bumps [icu_casemap_data](https://github.com/unicode-org/icu4x) from 1.5.0 to 1.5.1.
    # Changelog Sourced from icu_casemap_data's changelog.
    # Changelog Unreleased
    # Components
    # General
    # ...
    # icu_calendar
    # Rename Islamic calendars to Hijri (unicode-org#6214)
    # icu_collections
    # Remove some panics from CodePointTrie, which should no longer pull in panic machinery even with arithmetic panics
    # enabled for lookup (unicode-org#6204)
    # Data model and providers
    # icu_experimental
    # dimension
    # units
    # Update unit conversion to accept unit constant denominator (unicode-org#6199)
    # General
    # ...
    # icu_provider
    # Put MaybeEncodeAsVarULE behind the &quot;export&quot; feature (unicode-org#6221)
    # icu_provider_fs
    # AbstractSerializer is now a sealed trait (unicode-org#6263)
    # Utils
    # General
    # ...
    # calendrical_calculations
    # Parametrise the HijriObservational calendar by location (unicode-org#6332)
    # icu4x 2.0-beta2
    # Components
    # General
    # Update data to CLDR 47 Beta 1, ICU 77 RC, TZDB 2025a Some crates have been given the ability to be built without alloc
    # (unicode-org#6077, unicode-org#6078, unicode-org#6166) Consistently wrap all options in None in Rust and FFI
    # (unicode-org#6084) Options now consistently live in options modules (unicode-org#6138) Remove compiled_data Default
    # constructors from types which are prone to change sufficiently often (unicode-org#5958) Move types over to uniform
    # ::new() constructor convention (unicode-org#6141) Implement display on all error types (unicode-org#5969) Use
    # core::error, remove unused std features (unicode-org#5973) Remove bench features (unicode-org#5986)
    # icu_calendar
    # Rename IsoWeekday to Weekday (unicode-org#6140) Add Date::wrap_calendar_in_ref (unicode-org#6016) Time and DateTime
    # moved to icu_time component (unicode-org#5961) Audit exhaustiveness of icu_calendar::types (unicode-org#5978) Add
    # calendar argument to IXDTF parsing, making it available without compiled_data feature (unicode-org#5982) Use correct day
    # of year for Japanese (unicode-org#5992)
    # icu_casemap
    # Add borrowed variants to casemapper types (unicode-org#6088)
    # ... (truncated)
    # Commits
    # 6336fc8 Release icu_capi 1.5.1 (#5123) b648017 Fix CHANGELOG.md formatting (#5111) e1193d0 Uplift repr(packed) fix to
    # 1.5 (#5079) 21e7a0b Update changelog 16da579 twox-hash is a dep of zerovec so it should be no_std (#5007) 8510660
    # icu_datetime 1.5.1, icu_calendar 1.5.1 a9186ff Fix Japanese calendar year 0 (#5006) c892e80 Add 1.5.x changelog (#5004)
    # 126c927 fix: assert &gt;= 14 on num days not given day (#4986) See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=icu_casemap_data&package-manag
    # er=cargo&previous-version=1.5.0&new-version=1.5.1)](https://docs.github.com/en/github/managing-security-vulnerabilities/
    # about-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36182	(@dependabot[bot], @dependabot[bot], #36182)	build(deps): bump icu_experimental_data from 0.1.0 to 0.1.1 (#36182)
    # Bumps [icu_experimental_data](https://github.com/unicode-org/icu4x) from 0.1.0 to 0.1.1.
    # Changelog Sourced from icu_experimental_data's changelog.
    # Changelog Unreleased
    # Components
    # General
    # ...
    # icu_calendar
    # Rename Islamic calendars to Hijri (unicode-org#6214)
    # icu_collections
    # Remove some panics from CodePointTrie, which should no longer pull in panic machinery even with arithmetic panics
    # enabled for lookup (unicode-org#6204)
    # Data model and providers
    # icu_experimental
    # dimension
    # units
    # Update unit conversion to accept unit constant denominator (unicode-org#6199)
    # General
    # ...
    # icu_provider
    # Put MaybeEncodeAsVarULE behind the &quot;export&quot; feature (unicode-org#6221)
    # icu_provider_fs
    # AbstractSerializer is now a sealed trait (unicode-org#6263)
    # Utils
    # General
    # ...
    # calendrical_calculations
    # Parametrise the HijriObservational calendar by location (unicode-org#6332)
    # icu4x 2.0-beta2
    # Components
    # General
    # Update data to CLDR 47 Beta 1, ICU 77 RC, TZDB 2025a Some crates have been given the ability to be built without alloc
    # (unicode-org#6077, unicode-org#6078, unicode-org#6166) Consistently wrap all options in None in Rust and FFI
    # (unicode-org#6084) Options now consistently live in options modules (unicode-org#6138) Remove compiled_data Default
    # constructors from types which are prone to change sufficiently often (unicode-org#5958) Move types over to uniform
    # ::new() constructor convention (unicode-org#6141) Implement display on all error types (unicode-org#5969) Use
    # core::error, remove unused std features (unicode-org#5973) Remove bench features (unicode-org#5986)
    # icu_calendar
    # Rename IsoWeekday to Weekday (unicode-org#6140) Add Date::wrap_calendar_in_ref (unicode-org#6016) Time and DateTime
    # moved to icu_time component (unicode-org#5961) Audit exhaustiveness of icu_calendar::types (unicode-org#5978) Add
    # calendar argument to IXDTF parsing, making it available without compiled_data feature (unicode-org#5982) Use correct day
    # of year for Japanese (unicode-org#5992)
    # icu_casemap
    # Add borrowed variants to casemapper types (unicode-org#6088)
    # ... (truncated)
    # Commits
    # See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=icu_experimental_data&package-
    # manager=cargo&previous-version=0.1.0&new-version=0.1.1)](https://docs.github.com/en/github/managing-security-vulnerabili
    # ties/about-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
+https://github.com/servo/servo/pull/36144	(@simonwuelker, #36144)	Start implementing the `URLPattern` API (#36144)
    # The (experimental) [URLPattern API](https://developer.mozilla.org/en-US/docs/Web/API/URLPattern) allows defining and
    # matching regex-like patterns on the different components of an URL.  It is part of Interop 2025, so we should definitely
    # support it!
    # This change implements the basic procedure for parsing and compiling URL patterns.  Large parts of it are stubbed out
    # and will be implemented later.
    # For now the API is preference-gated behind "dom_urlpattern_enabled".
    # This is part 1 of upstreaming the changes in https://github.com/simonwuelker/servo/tree/urlpattern.
    dom
+https://github.com/servo/servo/pull/36169	(@virtualritz@protonmail.com, #36169)	Made MAX_TASK_NS u128. Also removed a superfluous into(). Both were required to fix #36122 with nightly 1.85.0 (4d91de4e4 2025-02-17). (#36169)
    # Both were required to fix #36122 with `1.87.0-nightly (307cbfda3 2025-03-20)`.
    # `MAX_TASK_NS` was changed from `u64` to `u128` in `components/metrics/lib.rs`.
    # A superfluous `into()` was removed from `MAX_TASK_NS.into()` in `components/script/script_thread.rs`.
    # Even if both sides of the `>` were `u128` `nightly` `rustc` would still barf about the `into()`.
    # The reason is that there were
    # ``` multiple `impl`s satisfying `u128: PartialOrd` found in the following crates: `core`, `deranged` ```
    # It seems `stable` `rustc` may pick one `PartialOrd` while `nightly` acknowledges that this is not correct and the user
    # must choose instead.
    # I.e.  both changes were required to make this build with `nightly`.
    # --- - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors - [x] These
    # changes fix #36122
    # - [x] These changes do not require tests because *this change is trivial*.
    upgrade
-https://github.com/servo/servo/pull/36129	(@dependabot[bot], @dependabot[bot], #36129)	build(deps): bump iana-time-zone from 0.1.61 to 0.1.62 (#36129)
    # Bumps [iana-time-zone](https://github.com/strawlab/iana-time-zone) from 0.1.61 to 0.1.62.
    # Changelog Sourced from iana-time-zone's changelog.
    # [0.1.62] - 2025-03-24 Changed
    # Bump MSRV (minimum supported rust version) to 1.61 (#157) Update to rust edition 2021 (#161) Address high and medium
    # severity zizmor findings (#163)
    # Added
    # Added support for tvOS, watchOS and visionOS (#146).  implement OpenHarmony support (#150)
    # Commits
    # 18469d8 Bump version number to 0.1.62 cf1dc8b update changelog with recent merged PRs 9d644fe Merge pull request #161
    # from strawlab/dev/lopopolo-2021-edition a843dde Merge pull request #163 from strawlab/dev/lopopolo-zizmor-gha bd03e1a
    # Add zizmor GitHub Actions workflow 101937b Address high and medium severity zizmor findings 35fcff1 Upgrade to 2021
    # edition e6bc833 Merge pull request #160 from strawlab/dev/astraw-fix-minimal-version-macos 03717ff ci: disable currently
    # failing cross compilations 6076833 fix typo in docstring Additional commits viewable in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=iana-time-zone&package-manager
    # =cargo&previous-version=0.1.61&new-version=0.1.62)](https://docs.github.com/en/github/managing-security-vulnerabilities/
    # about-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
>>> 2025-03-29T06:07:28Z
-https://github.com/servo/servo/pull/36214	(@greg-morenz@droid.cafe, #36214)	Remove redundant `rooted_vec` macro (#36214)
    # This macro was copied into mozjs in 2023, in servo/mozjs#352
    # The two versions are identical, and rooting infrastructure generally lives in mozjs.  Let's not keep this redundant copy
    # around.
    # The mozjs version is already imported evyerwhere via `#[macro_use]`.
+https://github.com/servo/servo/pull/36163	(@andrei.volykhin@gmail.com, #36163)	dom: Track "removed" event listener status (#36163)
    # The DOM event listener "removed" status should be supported to track the following situations (with immediate effect of
    # listener removal): - Removing a later event listener while an earlier listener for the same event is running - Nested
    # usage (recursively dispatch another event) of "once" listeners https://dom.spec.whatwg.org/#event-listener-removed
    # During event dispatching requires to clone event listeners list on "invoke" step
    # https://dom.spec.whatwg.org/#concept-event-listener-invoke and the lowercase "event listener" concept in Servo is
    # EventListenerEntry https://dom.spec.whatwg.org/#concept-event-listener
    # Bug: #25479, #25090
    # --- - [X] `./mach build -d` does not report any errors - [X] `./mach test-tidy` does not report any errors - [X] These
    # changes fix #25479, #25090
    # - [X] There are tests for these changes
    #   tests/wpt/tests/dom/events/remove-all-listeners.html
    #   tests/wpt/tests/html/webappapis/dynamic-markup-insertion/opening-the-input-stream/event-listeners.window.js
    dom
+https://github.com/servo/servo/pull/36141	(@rayguo17, #36141)	Animation: Aggregate Animated Image Info to Document (#36141)
    # Part of https://github.com/servo/servo/issues/36057
    # This PR tries to aggregate the Animated Image information that servo need to track, and store it in Document.  - The
    # animated Image is identify and queue into a `pending_image_animation_actions` during layout, and will be handled after
    # reflow.  - Stop tracking animated image in node that is no longer in fragment tree.
    animated-images
+https://github.com/servo/servo/pull/36200	(@kongbai1996, #36200)	Fixed the problem that touchmove cannot be disabled when preventDefault is invoked on touchstart. (#36200)
    # Fixed the problem that touchmove cannot be disabled when preventDefault is invoked on touchstart.
    # If preventDefault is set to Prevented when touchstart is performed, TouchMoveAllowed is set to Prevented.  However, when
    # touchmove is called back, TouchMoveAllowed is directly set to Allowed if it is allowed.  The situation that
    # TouchMoveAllowed has been prevented is not considered.
    do touchm
+https://github.com/servo/servo/pull/36192	(@abotella@igalia.com, #36192)	Consume BOM in the `text()` method of fetch bodies (#36192)
    # In the fetch spec, the `text()` method of `Body` (an interface mixin implemented by both `Request` and `Response`)
    # consumes the body with the Encoding spec "UTF-8 decode" algorithm, which skips the UTF-8 BOM if it is present at the
    # beginning of the body.  Servo's implementation does not do that.  This patch fixes this.
    dom
-https://github.com/servo/servo/pull/36213	(@dependabot[bot], @dependabot[bot], #36213)	build(deps): bump icu_plurals_data from 1.5.0 to 1.5.1 (#36213)
    # Bumps [icu_plurals_data](https://github.com/unicode-org/icu4x) from 1.5.0 to 1.5.1.
    # Changelog Sourced from icu_plurals_data's changelog.
    # Changelog Unreleased
    # Components
    # General
    # ...
    # icu_calendar
    # Rename Islamic calendars to Hijri (unicode-org#6214)
    # icu_collections
    # Remove some panics from CodePointTrie, which should no longer pull in panic machinery even with arithmetic panics
    # enabled for lookup (unicode-org#6204)
    # Data model and providers
    # icu_experimental
    # dimension
    # units
    # Update unit conversion to accept unit constant denominator (unicode-org#6199)
    # General
    # ...
    # icu_provider
    # Put MaybeEncodeAsVarULE behind the &quot;export&quot; feature (unicode-org#6221)
    # icu_provider_fs
    # AbstractSerializer is now a sealed trait (unicode-org#6263)
    # Utils
    # General
    # ...
    # calendrical_calculations
    # Parametrise the HijriObservational calendar by location (unicode-org#6332)
    # icu4x 2.0-beta2
    # Components
    # General
    # Update data to CLDR 47 Beta 1, ICU 77 RC, TZDB 2025a Some crates have been given the ability to be built without alloc
    # (unicode-org#6077, unicode-org#6078, unicode-org#6166) Consistently wrap all options in None in Rust and FFI
    # (unicode-org#6084) Options now consistently live in options modules (unicode-org#6138) Remove compiled_data Default
    # constructors from types which are prone to change sufficiently often (unicode-org#5958) Move types over to uniform
    # ::new() constructor convention (unicode-org#6141) Implement display on all error types (unicode-org#5969) Use
    # core::error, remove unused std features (unicode-org#5973) Remove bench features (unicode-org#5986)
    # icu_calendar
    # Rename IsoWeekday to Weekday (unicode-org#6140) Add Date::wrap_calendar_in_ref (unicode-org#6016) Time and DateTime
    # moved to icu_time component (unicode-org#5961) Audit exhaustiveness of icu_calendar::types (unicode-org#5978) Add
    # calendar argument to IXDTF parsing, making it available without compiled_data feature (unicode-org#5982) Use correct day
    # of year for Japanese (unicode-org#5992)
    # icu_casemap
    # Add borrowed variants to casemapper types (unicode-org#6088)
    # ... (truncated)
    # Commits
    # 6336fc8 Release icu_capi 1.5.1 (#5123) b648017 Fix CHANGELOG.md formatting (#5111) e1193d0 Uplift repr(packed) fix to
    # 1.5 (#5079) 21e7a0b Update changelog 16da579 twox-hash is a dep of zerovec so it should be no_std (#5007) 8510660
    # icu_datetime 1.5.1, icu_calendar 1.5.1 a9186ff Fix Japanese calendar year 0 (#5006) c892e80 Add 1.5.x changelog (#5004)
    # 126c927 fix: assert &gt;= 14 on num days not given day (#4986) See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=icu_plurals_data&package-manag
    # er=cargo&previous-version=1.5.0&new-version=1.5.1)](https://docs.github.com/en/github/managing-security-vulnerabilities/
    # about-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36212	(@dependabot[bot], @dependabot[bot], #36212)	build(deps): bump icu_decimal_data from 1.5.0 to 1.5.1 (#36212)
    # Bumps [icu_decimal_data](https://github.com/unicode-org/icu4x) from 1.5.0 to 1.5.1.
    # Changelog Sourced from icu_decimal_data's changelog.
    # Changelog Unreleased
    # Components
    # General
    # ...
    # icu_calendar
    # Rename Islamic calendars to Hijri (unicode-org#6214)
    # icu_collections
    # Remove some panics from CodePointTrie, which should no longer pull in panic machinery even with arithmetic panics
    # enabled for lookup (unicode-org#6204)
    # Data model and providers
    # icu_experimental
    # dimension
    # units
    # Update unit conversion to accept unit constant denominator (unicode-org#6199)
    # General
    # ...
    # icu_provider
    # Put MaybeEncodeAsVarULE behind the &quot;export&quot; feature (unicode-org#6221)
    # icu_provider_fs
    # AbstractSerializer is now a sealed trait (unicode-org#6263)
    # Utils
    # General
    # ...
    # calendrical_calculations
    # Parametrise the HijriObservational calendar by location (unicode-org#6332)
    # icu4x 2.0-beta2
    # Components
    # General
    # Update data to CLDR 47 Beta 1, ICU 77 RC, TZDB 2025a Some crates have been given the ability to be built without alloc
    # (unicode-org#6077, unicode-org#6078, unicode-org#6166) Consistently wrap all options in None in Rust and FFI
    # (unicode-org#6084) Options now consistently live in options modules (unicode-org#6138) Remove compiled_data Default
    # constructors from types which are prone to change sufficiently often (unicode-org#5958) Move types over to uniform
    # ::new() constructor convention (unicode-org#6141) Implement display on all error types (unicode-org#5969) Use
    # core::error, remove unused std features (unicode-org#5973) Remove bench features (unicode-org#5986)
    # icu_calendar
    # Rename IsoWeekday to Weekday (unicode-org#6140) Add Date::wrap_calendar_in_ref (unicode-org#6016) Time and DateTime
    # moved to icu_time component (unicode-org#5961) Audit exhaustiveness of icu_calendar::types (unicode-org#5978) Add
    # calendar argument to IXDTF parsing, making it available without compiled_data feature (unicode-org#5982) Use correct day
    # of year for Japanese (unicode-org#5992)
    # icu_casemap
    # Add borrowed variants to casemapper types (unicode-org#6088)
    # ... (truncated)
    # Commits
    # 6336fc8 Release icu_capi 1.5.1 (#5123) b648017 Fix CHANGELOG.md formatting (#5111) e1193d0 Uplift repr(packed) fix to
    # 1.5 (#5079) 21e7a0b Update changelog 16da579 twox-hash is a dep of zerovec so it should be no_std (#5007) 8510660
    # icu_datetime 1.5.1, icu_calendar 1.5.1 a9186ff Fix Japanese calendar year 0 (#5006) c892e80 Add 1.5.x changelog (#5004)
    # 126c927 fix: assert &gt;= 14 on num days not given day (#4986) See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=icu_decimal_data&package-manag
    # er=cargo&previous-version=1.5.0&new-version=1.5.1)](https://docs.github.com/en/github/managing-security-vulnerabilities/
    # about-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36211	(@dependabot[bot], @dependabot[bot], #36211)	build(deps): bump icu_properties_data from 1.5.0 to 1.5.1 (#36211)
    # Bumps [icu_properties_data](https://github.com/unicode-org/icu4x) from 1.5.0 to 1.5.1.
    # Changelog Sourced from icu_properties_data's changelog.
    # Changelog Unreleased
    # Components
    # General
    # ...
    # icu_calendar
    # Rename Islamic calendars to Hijri (unicode-org#6214)
    # icu_collections
    # Remove some panics from CodePointTrie, which should no longer pull in panic machinery even with arithmetic panics
    # enabled for lookup (unicode-org#6204)
    # Data model and providers
    # icu_experimental
    # dimension
    # units
    # Update unit conversion to accept unit constant denominator (unicode-org#6199)
    # General
    # ...
    # icu_provider
    # Put MaybeEncodeAsVarULE behind the &quot;export&quot; feature (unicode-org#6221)
    # icu_provider_fs
    # AbstractSerializer is now a sealed trait (unicode-org#6263)
    # Utils
    # General
    # ...
    # calendrical_calculations
    # Parametrise the HijriObservational calendar by location (unicode-org#6332)
    # icu4x 2.0-beta2
    # Components
    # General
    # Update data to CLDR 47 Beta 1, ICU 77 RC, TZDB 2025a Some crates have been given the ability to be built without alloc
    # (unicode-org#6077, unicode-org#6078, unicode-org#6166) Consistently wrap all options in None in Rust and FFI
    # (unicode-org#6084) Options now consistently live in options modules (unicode-org#6138) Remove compiled_data Default
    # constructors from types which are prone to change sufficiently often (unicode-org#5958) Move types over to uniform
    # ::new() constructor convention (unicode-org#6141) Implement display on all error types (unicode-org#5969) Use
    # core::error, remove unused std features (unicode-org#5973) Remove bench features (unicode-org#5986)
    # icu_calendar
    # Rename IsoWeekday to Weekday (unicode-org#6140) Add Date::wrap_calendar_in_ref (unicode-org#6016) Time and DateTime
    # moved to icu_time component (unicode-org#5961) Audit exhaustiveness of icu_calendar::types (unicode-org#5978) Add
    # calendar argument to IXDTF parsing, making it available without compiled_data feature (unicode-org#5982) Use correct day
    # of year for Japanese (unicode-org#5992)
    # icu_casemap
    # Add borrowed variants to casemapper types (unicode-org#6088)
    # ... (truncated)
    # Commits
    # 6336fc8 Release icu_capi 1.5.1 (#5123) b648017 Fix CHANGELOG.md formatting (#5111) e1193d0 Uplift repr(packed) fix to
    # 1.5 (#5079) 21e7a0b Update changelog 16da579 twox-hash is a dep of zerovec so it should be no_std (#5007) 8510660
    # icu_datetime 1.5.1, icu_calendar 1.5.1 a9186ff Fix Japanese calendar year 0 (#5006) c892e80 Add 1.5.x changelog (#5004)
    # 126c927 fix: assert &gt;= 14 on num days not given day (#4986) See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=icu_properties_data&package-ma
    # nager=cargo&previous-version=1.5.0&new-version=1.5.1)](https://docs.github.com/en/github/managing-security-vulnerabiliti
    # es/about-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36208	(@dependabot[bot], @dependabot[bot], #36208)	build(deps): bump icu_datetime_data from 1.5.0 to 1.5.1 (#36208)
    # Bumps [icu_datetime_data](https://github.com/unicode-org/icu4x) from 1.5.0 to 1.5.1.
    # Changelog Sourced from icu_datetime_data's changelog.
    # Changelog Unreleased
    # Components
    # General
    # ...
    # icu_calendar
    # Rename Islamic calendars to Hijri (unicode-org#6214)
    # icu_collections
    # Remove some panics from CodePointTrie, which should no longer pull in panic machinery even with arithmetic panics
    # enabled for lookup (unicode-org#6204)
    # Data model and providers
    # icu_experimental
    # dimension
    # units
    # Update unit conversion to accept unit constant denominator (unicode-org#6199)
    # General
    # ...
    # icu_provider
    # Put MaybeEncodeAsVarULE behind the &quot;export&quot; feature (unicode-org#6221)
    # icu_provider_fs
    # AbstractSerializer is now a sealed trait (unicode-org#6263)
    # Utils
    # General
    # ...
    # calendrical_calculations
    # Parametrise the HijriObservational calendar by location (unicode-org#6332)
    # icu4x 2.0-beta2
    # Components
    # General
    # Update data to CLDR 47 Beta 1, ICU 77 RC, TZDB 2025a Some crates have been given the ability to be built without alloc
    # (unicode-org#6077, unicode-org#6078, unicode-org#6166) Consistently wrap all options in None in Rust and FFI
    # (unicode-org#6084) Options now consistently live in options modules (unicode-org#6138) Remove compiled_data Default
    # constructors from types which are prone to change sufficiently often (unicode-org#5958) Move types over to uniform
    # ::new() constructor convention (unicode-org#6141) Implement display on all error types (unicode-org#5969) Use
    # core::error, remove unused std features (unicode-org#5973) Remove bench features (unicode-org#5986)
    # icu_calendar
    # Rename IsoWeekday to Weekday (unicode-org#6140) Add Date::wrap_calendar_in_ref (unicode-org#6016) Time and DateTime
    # moved to icu_time component (unicode-org#5961) Audit exhaustiveness of icu_calendar::types (unicode-org#5978) Add
    # calendar argument to IXDTF parsing, making it available without compiled_data feature (unicode-org#5982) Use correct day
    # of year for Japanese (unicode-org#5992)
    # icu_casemap
    # Add borrowed variants to casemapper types (unicode-org#6088)
    # ... (truncated)
    # Commits
    # 6336fc8 Release icu_capi 1.5.1 (#5123) b648017 Fix CHANGELOG.md formatting (#5111) e1193d0 Uplift repr(packed) fix to
    # 1.5 (#5079) 21e7a0b Update changelog 16da579 twox-hash is a dep of zerovec so it should be no_std (#5007) 8510660
    # icu_datetime 1.5.1, icu_calendar 1.5.1 a9186ff Fix Japanese calendar year 0 (#5006) c892e80 Add 1.5.x changelog (#5004)
    # 126c927 fix: assert &gt;= 14 on num days not given day (#4986) See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=icu_datetime_data&package-mana
    # ger=cargo&previous-version=1.5.0&new-version=1.5.1)](https://docs.github.com/en/github/managing-security-vulnerabilities
    # /about-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36209	(@dependabot[bot], @dependabot[bot], #36209)	build(deps): bump icu_timezone_data from 1.5.0 to 1.5.1 (#36209)
    # Bumps [icu_timezone_data](https://github.com/unicode-org/icu4x) from 1.5.0 to 1.5.1.
    # Changelog Sourced from icu_timezone_data's changelog.
    # Changelog Unreleased
    # Components
    # General
    # ...
    # icu_calendar
    # Rename Islamic calendars to Hijri (unicode-org#6214)
    # icu_collections
    # Remove some panics from CodePointTrie, which should no longer pull in panic machinery even with arithmetic panics
    # enabled for lookup (unicode-org#6204)
    # Data model and providers
    # icu_experimental
    # dimension
    # units
    # Update unit conversion to accept unit constant denominator (unicode-org#6199)
    # General
    # ...
    # icu_provider
    # Put MaybeEncodeAsVarULE behind the &quot;export&quot; feature (unicode-org#6221)
    # icu_provider_fs
    # AbstractSerializer is now a sealed trait (unicode-org#6263)
    # Utils
    # General
    # ...
    # calendrical_calculations
    # Parametrise the HijriObservational calendar by location (unicode-org#6332)
    # icu4x 2.0-beta2
    # Components
    # General
    # Update data to CLDR 47 Beta 1, ICU 77 RC, TZDB 2025a Some crates have been given the ability to be built without alloc
    # (unicode-org#6077, unicode-org#6078, unicode-org#6166) Consistently wrap all options in None in Rust and FFI
    # (unicode-org#6084) Options now consistently live in options modules (unicode-org#6138) Remove compiled_data Default
    # constructors from types which are prone to change sufficiently often (unicode-org#5958) Move types over to uniform
    # ::new() constructor convention (unicode-org#6141) Implement display on all error types (unicode-org#5969) Use
    # core::error, remove unused std features (unicode-org#5973) Remove bench features (unicode-org#5986)
    # icu_calendar
    # Rename IsoWeekday to Weekday (unicode-org#6140) Add Date::wrap_calendar_in_ref (unicode-org#6016) Time and DateTime
    # moved to icu_time component (unicode-org#5961) Audit exhaustiveness of icu_calendar::types (unicode-org#5978) Add
    # calendar argument to IXDTF parsing, making it available without compiled_data feature (unicode-org#5982) Use correct day
    # of year for Japanese (unicode-org#5992)
    # icu_casemap
    # Add borrowed variants to casemapper types (unicode-org#6088)
    # ... (truncated)
    # Commits
    # 6336fc8 Release icu_capi 1.5.1 (#5123) b648017 Fix CHANGELOG.md formatting (#5111) e1193d0 Uplift repr(packed) fix to
    # 1.5 (#5079) 21e7a0b Update changelog 16da579 twox-hash is a dep of zerovec so it should be no_std (#5007) 8510660
    # icu_datetime 1.5.1, icu_calendar 1.5.1 a9186ff Fix Japanese calendar year 0 (#5006) c892e80 Add 1.5.x changelog (#5004)
    # 126c927 fix: assert &gt;= 14 on num days not given day (#4986) See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=icu_timezone_data&package-mana
    # ger=cargo&previous-version=1.5.0&new-version=1.5.1)](https://docs.github.com/en/github/managing-security-vulnerabilities
    # /about-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36207	(@dependabot[bot], @dependabot[bot], #36207)	build(deps): bump bytemuck_derive from 1.9.2 to 1.9.3 (#36207)
    # Bumps [bytemuck_derive](https://github.com/Lokathor/bytemuck) from 1.9.2 to 1.9.3.
    # Commits
    # See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=bytemuck_derive&package-manage
    # r=cargo&previous-version=1.9.2&new-version=1.9.3)](https://docs.github.com/en/github/managing-security-vulnerabilities/a
    # bout-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36206	(@dependabot[bot], @dependabot[bot], #36206)	build(deps): bump once_cell from 1.21.1 to 1.21.2 (#36206)
    # Bumps [once_cell](https://github.com/matklad/once_cell) from 1.21.1 to 1.21.2.
    # Changelog Sourced from once_cell's changelog.
    # 1.21.2
    # Relax success ordering from AcqRel to Release in race: #278.
    # Commits
    # 7a310c6 Merge pull request #278 from briansmith/b/weaken-release 2a707ee race: Relax compare_exchange success ordering
    # from AcqRel to Release.  See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=once_cell&package-manager=carg
    # o&previous-version=1.21.1&new-version=1.21.2)](https://docs.github.com/en/github/managing-security-vulnerabilities/about
    # -dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36205	(@dependabot[bot], @dependabot[bot], #36205)	build(deps): bump clap from 4.5.32 to 4.5.34 (#36205)
    # Bumps [clap](https://github.com/clap-rs/clap) from 4.5.32 to 4.5.34.
    # Release notes Sourced from clap's releases.
    # v4.5.34 [4.5.34] - 2025-03-27 Fixes
    # (help) Don't add extra blank lines with flatten_help(true) and subcommands without arguments
    # v4.5.33 [4.5.33] - 2025-03-26 Fixes
    # (error) When showing the usage of a suggestion for an unknown argument, don't show the group
    # Changelog Sourced from clap's changelog.
    # [4.5.34] - 2025-03-27 Fixes
    # (help) Don't add extra blank lines with flatten_help(true) and subcommands without arguments
    # [4.5.33] - 2025-03-26 Fixes
    # (error) When showing the usage of a suggestion for an unknown argument, don't show the group
    # Commits
    # 5d2cdac chore: Release f1c10eb docs: Update changelog a4d1a7f chore(ci): Take a break from template updates e95ed39
    # Merge pull request #5775 from vivienm/master 18f8d4c chore(deps): Update Rust Stable to v1.82 (#5788) f35d8e0 Merge pull
    # request #5787 from epage/template 1389d7d chore: Update from '_rust/main' template dbc9faa chore(ci): Initialize git for
    # template update 3dac2f3 chore(ci): Get history for template update e1f77da chore(ci): Fix branch for template update
    # Additional commits viewable in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=clap&package-manager=cargo&pre
    # vious-version=4.5.32&new-version=4.5.34)](https://docs.github.com/en/github/managing-security-vulnerabilities/about-depe
    # ndabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36204	(@dependabot[bot], @dependabot[bot], #36204)	build(deps): bump string_cache from 0.8.8 to 0.8.9 (#36204)
    # Bumps [string_cache](https://github.com/servo/string-cache) from 0.8.8 to 0.8.9.
    # Commits
    # See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=string_cache&package-manager=c
    # argo&previous-version=0.8.8&new-version=0.8.9)](https://docs.github.com/en/github/managing-security-vulnerabilities/abou
    # t-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/35739	(@tomov@dilacero.org, #35739)	Check for existence of 'sudo' on Linux in ./mach bootstrap (#35739)
    # Update linux.py bootstrap script to check for the existence of the 'sudo' command before attempting to call it.  If it
    # does not find 'sudo', then it will gracefully notify the user, wait for a prompt, and then continue on with the
    # bootstrap process, exactly as is done when bootstrap does not recognize the distro.
    # Note that while this addresses the ugly stack trace mentioned in issue #35736, it does not address the desire for an
    # "opt-in" to sudo.  In other words, mach bootstrap will still automatically try to call sudo when not running as root.
+https://github.com/servo/servo/pull/36194	(@abotella@igalia.com, #36194)	Fix content-type when creating a `Request` with `FormData` body (#36194)
    # When you create a `Request` object with a `FormData` body, the spec says that the `Content-Type` header should start
    # with `multipart/form-data; boundary=`.  However, in Servo's implementation it started with
    # `multipart/form-data;boundary=`, without the space.
    # While all reasonable servers should be able to that headers whether the space is present or not, this brings Servo
    # closer to the spec, and also makes some WPT tests pass.
    # Note that submitting a form with `enctype="multipart/form-data"` does produce a `Content-Type` header with the space
    # (see `HTMLFormElement::submit_entity_body`).
    dom
+https://github.com/servo/servo/pull/36158	(@greg-morenz@droid.cafe, #36158)	Stop using `RootedGuard's` DerefMut impl (#36158)
    # Stop using the `RootedGuard::deref_mut` impl entirely, so it can be removed.  Notably including making `read_loop` not
    # hold an `&mut` reference to a rooted object while calling functions which use the garbage collector, almost certainly
    # resulting in undefined behavior.
    # This accompanies servo/mozjs#572, and prevents it from breaking servo.  It also needs it for crown to understand that
    # `MutableHandle` may point at a unrooted type without itself being rooted, and should not be merged until the `use
    # accompying mozjs pr` commit is updated to point at a merged version of the PR.
    dom crash
-https://github.com/servo/servo/pull/36193	(@jdm, #36193)	net: Add missing feature required for unit tests. (#36193)
    # Running `./mach test-unit -p net` fails to build because the unit tests rely on the aws-lc-rs feature of rustls being
    # enabled, but the net package does not actually enable it.
    # --- - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors - [x] These
    # changes do not require tests because we do not verify that individual packages can run their unit tests in isolation.
+https://github.com/servo/servo/pull/36197	(@barigbuenbira@gmail.com, #36197)	fix: prevent missing value error for radio button inputs without a name (#36197)
    # This fix explicitly checks if `self.radio_group_name()` is `None` and returns `false` from the constraint validation
    # implementation, ensuring we pass the relevant WPT test.
    # This fix removes references to the
    # `tests/wpt/tests/html/semantics/forms/constraints/form-validation-validity-valueMissing.htmltest` test, as its
    # expectation is now PASS, and deletes the .ini file since it no longer contains any expectations.
    dom
-https://github.com/servo/servo/pull/36198	(@mukilan, #36198)	doc: fix broken link to UnrootedMustRoot plugin (#36198)
-https://github.com/servo/servo/pull/36201	(@delan, #36201)	Install tshark for automated tests in #36033 (#36201)
    # This patch adds tshark(1) to the list of programs installed by mach bootstrap, for new automated tests in #36033.  See
    # also servo/book#63, which does the same in [_Setting up your
    # environment_](https://book.servo.org/hacking/setting-up-your-environment.html).
-https://github.com/servo/servo/pull/36190	(@dependabot[bot], @dependabot[bot], #36190)	build(deps): bump icu_locid_transform_data from 1.5.0 to 1.5.1 (#36190)
    # Bumps [icu_locid_transform_data](https://github.com/unicode-org/icu4x) from 1.5.0 to 1.5.1.
    # Changelog Sourced from icu_locid_transform_data's changelog.
    # Changelog Unreleased
    # Components
    # General
    # ...
    # icu_calendar
    # Rename Islamic calendars to Hijri (unicode-org#6214)
    # icu_collections
    # Remove some panics from CodePointTrie, which should no longer pull in panic machinery even with arithmetic panics
    # enabled for lookup (unicode-org#6204)
    # Data model and providers
    # icu_experimental
    # dimension
    # units
    # Update unit conversion to accept unit constant denominator (unicode-org#6199)
    # General
    # ...
    # icu_provider
    # Put MaybeEncodeAsVarULE behind the &quot;export&quot; feature (unicode-org#6221)
    # icu_provider_fs
    # AbstractSerializer is now a sealed trait (unicode-org#6263)
    # Utils
    # General
    # ...
    # calendrical_calculations
    # Parametrise the HijriObservational calendar by location (unicode-org#6332)
    # icu4x 2.0-beta2
    # Components
    # General
    # Update data to CLDR 47 Beta 1, ICU 77 RC, TZDB 2025a Some crates have been given the ability to be built without alloc
    # (unicode-org#6077, unicode-org#6078, unicode-org#6166) Consistently wrap all options in None in Rust and FFI
    # (unicode-org#6084) Options now consistently live in options modules (unicode-org#6138) Remove compiled_data Default
    # constructors from types which are prone to change sufficiently often (unicode-org#5958) Move types over to uniform
    # ::new() constructor convention (unicode-org#6141) Implement display on all error types (unicode-org#5969) Use
    # core::error, remove unused std features (unicode-org#5973) Remove bench features (unicode-org#5986)
    # icu_calendar
    # Rename IsoWeekday to Weekday (unicode-org#6140) Add Date::wrap_calendar_in_ref (unicode-org#6016) Time and DateTime
    # moved to icu_time component (unicode-org#5961) Audit exhaustiveness of icu_calendar::types (unicode-org#5978) Add
    # calendar argument to IXDTF parsing, making it available without compiled_data feature (unicode-org#5982) Use correct day
    # of year for Japanese (unicode-org#5992)
    # icu_casemap
    # Add borrowed variants to casemapper types (unicode-org#6088)
    # ... (truncated)
    # Commits
    # 6336fc8 Release icu_capi 1.5.1 (#5123) b648017 Fix CHANGELOG.md formatting (#5111) e1193d0 Uplift repr(packed) fix to
    # 1.5 (#5079) 21e7a0b Update changelog 16da579 twox-hash is a dep of zerovec so it should be no_std (#5007) 8510660
    # icu_datetime 1.5.1, icu_calendar 1.5.1 a9186ff Fix Japanese calendar year 0 (#5006) c892e80 Add 1.5.x changelog (#5004)
    # 126c927 fix: assert &gt;= 14 on num days not given day (#4986) See full diff in compare view
    # [![Dependabot compatibility
    # score](https://dependabot-badges.githubapp.com/badges/compatibility_score?dependency-name=icu_locid_transform_data&packa
    # ge-manager=cargo&previous-version=1.5.0&new-version=1.5.1)](https://docs.github.com/en/github/managing-security-vulnerab
    # ilities/about-dependabot-security-updates#about-compatibility-scores)
    # Dependabot will resolve any conflicts with this PR as long as you don't alter it yourself.  You can also trigger a
    # rebase manually by commenting `@dependabot rebase`.
    # [//]: # (dependabot-automerge-start) [//]: # (dependabot-automerge-end)
-https://github.com/servo/servo/pull/36195	(@servo-wpt-sync, #36195)	Update web-platform-tests to revision b'9d20f3ae600d00673a27a69f69e13d4cd8eca443' (#36195)
    # Automated downstream sync of changes from upstream as of 28-03-2025 [no-wpt-sync]
>>> 2025-03-30T06:13:40Z
-https://github.com/servo/servo/pull/36222	(@servo-wpt-sync, #36222)	Update web-platform-tests to revision b'efce5c7cd31b0e1add4f41758504c767b56abeed' (#36222)
    # Automated downstream sync of changes from upstream as of 30-03-2025 [no-wpt-sync]
-https://github.com/servo/servo/pull/36219	(@atouchet, #36219)	Cargo.toml cleanup (#36219)
+https://github.com/servo/servo/pull/36218	(@kongbai1996, #36218)	Fixed an incorrect touchmove event triggered when the second finger is pressed. (#36218)
    # Fixed an incorrect touchmove event triggered when the second finger is pressed.
    # When touchdown is enabled, if the number of touch points is 2, the touch status should not be set to Pinching.  A
    # pinching operation is performed only when both fingers are pressed and the moving distance of one finger exceeds a
    # certain threshold.
    # When touchdown is set to two or more touch points, the status is set to MultiTouch.  If the moving distance exceeds a
    # certain value during touchmove, the status is set to Pinching.
    dom touch
+https://github.com/servo/servo/pull/36210	(@chocolate-pie, #36210)	layout: Implement support for `image-set()` notation (#36210)
    # This PR adds support for `image-set()` notation described in https://drafts.csswg.org/css-images-4/#image-set-notation.
    layout
+https://github.com/servo/servo/pull/36180	(@abonghoderick@gmail.com, #36180)	Propagate CanGc arguments through HTMLCollection constructors (#36180)
    # Propagate CanGc arguments through HTMLCollection constructors
    dom crash
+https://github.com/servo/servo/pull/36111	(@abonghoderick@gmail.com, #36111)	resolve issue #36074 new_js_regex and matches_js_regex need a CanGc argument (#36111)
    # resolve issue https://github.com/servo/servo/issues/36074 new_js_regex and matches_js_regex need a CanGc argument
    dom crash
+https://github.com/servo/servo/pull/36202	(@mrobinson, #36202)	layout: Simplify and generalize the usage of pseudo-elements (#36202)
    # - Remove the last remaining Servo-specific PseudoElement enum from
    #   layout.  This was made to select `::before` and `::after` (both eager pseudo-elements), but now
    #   `traverse_pseudo_element` is called `traverse_eager_pseudo_element` and should work on any eager pseudo element.
    # - Expose a single way of getting psuedo-element variants of
    #   ThreadSafeLayoutElement in the Layout DOM, which returns `None` when the pseudo-element doesn't apply (not defined for
    #   eager pseudo-elements or when trying to get `` related pseudo-elements on elements that they don't apply to).
    # - Ensure that NodeAndStyleInfo always refers to a node.  This is done by
    #   making sure that anonymous boxes are all associated with their originating node.
    # These changes are prepatory work for implementation of the `::marker` pseudo-element as well as ensuring that all
    # anonymous boxes can be cached into the box tree eventually.
    # Signed-off-by: Martin Robinson
    layout
+https://github.com/servo/servo/pull/36216	(@jdm, #36216)	Miscellaneous script splitting preparation changes (#36216)
    # A grab bag of changes needed for #1799; mostly moving code from script to script_bindings, with some conversions to make
    # some code in script/dom/bindings more generic mixed in.
    # --- - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors - [x] These
    # changes are part of #1799 - [x] There are tests for these changes (existing WPT coverage)
    dom split
-https://github.com/servo/servo/pull/36033	(@delan, @ar1a, #36033)	Devtools parser: reassemble fragmented messages (#36033)
    # The old deserialisation code tried to match one or more occurrences of `\d+:{` within each line of tshark(1) output,
    # treating the next match as the implicit end of message.  This approach was incorrect if message records (`length:{...}`)
    # were split across packets or contained such a sequence in the JSON data.
    # This patch reworks the algorithm to handle message fragmentation and length prefixes correctly.
>>> 2025-03-31T06:04:30Z
+https://github.com/servo/servo/pull/36226	(@simonwuelker, #36226)	Only invoke resize observer callback when the observed element changed its size (#36226)
    # This change also adds a bunch of spec comments, because our ResizeObserver implementation deviates from the spec
    # significantly in ways that are not immediately intuitive.
    # Fixes https://github.com/servo/servo/issues/36096
    # There are no tests that pass as a result of this change, but when combined with
    # https://github.com/servo/servo/issues/36092#issuecomment-2744894786 then `resize-observer/calculate-depth-for-node.html`
    # does pass.
    dom
-https://github.com/servo/servo/pull/36224	(@atouchet, #36224)	Organize component Cargo.toml dependencies (#36224)
    # null
+https://github.com/servo/servo/pull/36220	(@jdm, #36220)	More miscellaneous script splitting changes (#36220)
    # A grab bag of changes needed for https://github.com/servo/servo/issues/1799; mostly moving code from script to
    # script_bindings, with some conversions to make some code in script/dom/bindings more generic mixed in.
    # This is the final preparatory PR; the next one will be the big finale.
    # --- - [x] `./mach build -d` does not report any errors - [x] `./mach test-tidy` does not report any errors - [x] These
    # changes are part of #1799 - [x] There are tests for these changes (existing WPT coverage)
    dom split
-https://github.com/servo/servo/pull/36203	(@mrobinson, #36203)	Use a simpler GitHub pull request template (#36203)
    # The idea here is that we can use the pull request description as the commit message, so that the git history is cleaner.
    # This requires:
    # 1.  Removing comments from the message, as GitHub doesn't remove them
    #    from the pull request descriptions when committing.
    # 2.  Remove the checklist, which is now verified by the CI instead, so
    #    is less important.
    # 3.  Ask the contributor to remove the lines expicitly.
    # Signed-off-by: Martin Robinson
>>> 2025-04-01T06:07:41Z
[/commits]-->

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