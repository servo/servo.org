---
layout:     post
tags:       blog
title:      "This month in Servo: ?????"
date:       2025-07-02
summary:    awooga awooga
categories:
---

<!--
- csp
    - https://github.com/servo/servo/pull/37154    (@TimvdLippe, @jdm, #37154)    net: Perform CSP checks on fetch responses. (#37154)
      csp
    - https://github.com/servo/servo/pull/37209    (@TimvdLippe, #37209)    Report URI with POST fetch request (#37209)
      csp
    - https://github.com/servo/servo/pull/37474    (@TimvdLippe, #37474)    script: Fix check for document root when targeting CSP events (#37474)
      csp
    - https://github.com/servo/servo/pull/37465    (@TimvdLippe, #37465)    Fix skipping CSP checks for styles when cloning nodes (#37465)
      csp
- devtools
    - https://github.com/servo/servo/pull/37197    (@atbrakhi, #37197)    DevTools: Fix empty `debugger > source` panel (#37197)
      devtools
    - https://github.com/servo/servo/pull/37247    (@eri@inventati.org, #37247)    devtools: Fix inspector on Firefox 139 (#37247)
      devtools
    - https://github.com/servo/servo/pull/37263    (@uthmaniv, #37263)    Update handle_network_event to use BrowsingContextActor for HttpRequest (#37263)
      devtools
    - https://github.com/servo/servo/pull/37384    (@uthmaniv, #37384)    Replace NetworkEventUpdateMsg with ResourcesUpdatedArray (#37384)
      devtools
    - https://github.com/servo/servo/pull/36774    (@atbrakhi, #36774)    DevTools: Implement support for showing `source_content` in `Debugger > Source` panel (#36774)
      devtools
    - https://github.com/servo/servo/pull/37501    (@simonwuelker, #37501)    Make layout build a display list when the highlighted DOM node changed (#37501)
      devtools
    - https://github.com/servo/servo/pull/37456    (@atbrakhi, @delan, #37456)    DevTools: sources for HTML files should be the whole HTML file (#37456)
      devtools
    - https://github.com/servo/servo/pull/37543    (@uthmaniv, #37543)    Fix network event update Message (#37543)
      devtools
    - https://github.com/servo/servo/pull/37707    (@uthmaniv, #37707)    Add common resourceId to network events (#37707)
      devtools
- dom
    - https://github.com/servo/servo/pull/37192    (@gterzian, #37192)    dom: implement signal abort on controller and signal (#37192)
      dom
    - https://github.com/servo/servo/pull/37190    (@dvt.tnhn.krlbs@icloud.com, #37190)    script: Set HTTP status code when aborting an `XMLHttpRequest` (#37190)
      dom
    - https://github.com/servo/servo/pull/34594    (@vlindhol, #34594)    XPath: implement lang() and id() core functions (#34594)
      dom
    - https://github.com/servo/servo/pull/37218    (@gterzian, #37218)    dom: implement aborted method of abort signal (#37218)
      dom
    - https://github.com/servo/servo/pull/37217    (@gterzian, #37217)    dom: implement signal method on abort controller (#37217)
      dom
    - https://github.com/servo/servo/pull/37227    (@gterzian, #37227)    dom: implement abort signal reason method (#37227)
      dom
    - https://github.com/servo/servo/pull/37251    (@sagudev, #37251)    canvas: ensure there is a subpath in `PathBuilderRef` (#37251)
      dom
    - https://github.com/servo/servo/pull/37245    (@Taym95, #37245)    Dom: Implement AbortSignal ThrowIfAborted method (#37245)
      dom
    - https://github.com/servo/servo/pull/37313    (@pewsheen, #37313)    feat(script): add `Supports()` to `htmlscriptelement` (#37313)
      dom
    - https://github.com/servo/servo/pull/37291    (@wusyong, @yuweiwu@YunoMacBook-Air.local, #37291)    HTMLScriptElement: add `ScriptType::ImportMap` (#37291)
      dom
    - https://github.com/servo/servo/pull/37293    (@simonwuelker, #37293)    Fix timing of change events for `<select>` elements (#37293)
      dom
    - https://github.com/servo/servo/pull/37281    (@simonwuelker, #37281)    Don't drain ranges across shadow boundaries (#37281)
      dom
    - https://github.com/servo/servo/pull/37279    (@vlindhol, #37279)    script: Fix two issues in the XPath parser to pass all `xml_xpath_tests.xml` tests (#37279)
      dom
    - https://github.com/servo/servo/pull/37340    (@pewsheen, #37340)    feat(script): add `resolve_url_like_module_specifier` to `ModuleTree` (#37340)
      dom
    - https://github.com/servo/servo/pull/37025    (@andrei.volykhin@gmail.com, #37025)    imagebitmap: Add missing basic functionality (#37025)
      dom
    - https://github.com/servo/servo/pull/37405    (@pewsheen, @wusyong, #37405)    feat(script): create import map parse result (#37405)
      dom
    - https://github.com/servo/servo/pull/37345    (@simonwuelker, #37345)    Support exporting shadow parts with the `exportparts` attribute (#37345)
      dom
    - https://github.com/servo/servo/pull/37244    (@gterzian, #37244)    AbortController: integrate with stream piping. (#37244)
      dom
    - https://github.com/servo/servo/pull/37466    (@TimvdLippe, #37466)    Implement script prepare text for Trusted Types (#37466)
      dom
    - https://github.com/servo/servo/pull/37455    (@simonwuelker, #37455)    Don't count <img> elements with both name and id twice in document's named getter (#37455)
      dom
    - https://github.com/servo/servo/pull/37471    (@xiaochengh, #37471)    Stop DedicatedWorker from handling remaining messages after closed (#37471)
      dom
    - https://github.com/servo/servo/pull/37486    (@yezhizhen, #37486)    layout: capitalize string for `TextTransformCase::Capitalize` in `fn rendered_text_collection_steps` (#37486)
      dom
    - https://github.com/servo/servo/pull/37397    (@andrei.volykhin@gmail.com, #37397)    imagebitmap: Crop bitmap data with formatting (#37397)
      dom
    - https://github.com/servo/servo/pull/37434    (@ville.lindholm@external.wolt.com, #37434)    fix(xpath): pass in correct context node for // and / in predicates (#37434)
      dom
    - https://github.com/servo/servo/pull/37488    (@andrei.volykhin@gmail.com, #37488)    imagebitmap: Resolve promise with ImageBitmap on bitmap task source (#37488)
      dom
    - https://github.com/servo/servo/pull/37511    (@Taym95, #37511)    implement Writablestreamdefaultcontroller abortcontroller (#37511)
      dom
    - https://github.com/servo/servo/pull/37504    (@pewsheen, #37504)    feat(script): register import map (#37504)
      dom
    - https://github.com/servo/servo/pull/37503    (@andrei.volykhin@gmail.com, #37503)    pixels: Multiply by alpha with less loss of precision (#37503)
      dom
    - https://github.com/servo/servo/pull/36687    (@kenzieradityatirtarahardja18@gmail.com, @kenzieradityatirtarahardja.18@gmail.com, @asun0204@163.com, #36687)    Implement scroll event (#36687)
      dom
    - https://github.com/servo/servo/pull/37594    (@TimvdLippe, #37594)    Use undefined as this in trusted type callbacks (#37594)
      dom
    - https://github.com/servo/servo/pull/37552    (@wusyong, #37552)    script: complete `resolve_module_specifier` (#37552)
      dom
    - https://github.com/servo/servo/pull/37509    (@mrobinson, #37509)    script: Get scroll offsets from layout (#37509)
      dom
    - https://github.com/servo/servo/pull/37560    (@andrei.volykhin@gmail.com, #37560)    imagebitmap: Add support of Blob as ImageBitmapSource (#37560)
      dom
    - https://github.com/servo/servo/pull/37556    (@simonwuelker, #37556)    Use the document encoding when parsing a `<video>` elements poster URL (#37556)
      dom
    - https://github.com/servo/servo/pull/37541    (@simonwuelker, #37541)    Handle nonmappable code points in Document::encoding_parse_a_url (#37541)
      dom
    - https://github.com/servo/servo/pull/37550    (@rodion.borovyk@gmail.com, #37550)    script Exclude `CDATASection` nodes from `Node::normalize()` (#37550)
      dom
    - https://github.com/servo/servo/pull/37461    (@kenzieradityatirtarahardja18@gmail.com, #37461)    script: Reverse wheel event delta sign to match specification-defined behavior (#37461)
      dom
    - https://github.com/servo/servo/pull/37547    (@pewsheen, #37547)    feat(script): parse script element `importmap` type (#37547)
      dom
    - https://github.com/servo/servo/pull/33044    (@arihant2math@gmail.com, @rasviitanen@gmail.com, @jdm, #33044)     Initial IndexedDB Support (#33044)
      dom
    - https://github.com/servo/servo/pull/37652    (@arihant2math@gmail.com, @jdm, #37652)    [IndexedDB] Reduce heed related panics (#37652)
      dom
    - https://github.com/servo/servo/pull/37635    (@andrei.volykhin@gmail.com, #37635)    webgl: Ignore pixel storage parameters for ImageBitmap source (#37635)
      dom
    - https://github.com/servo/servo/pull/37671    (@andrei.volykhin@gmail.com, #37671)    canvas: Reset the current path on canvas context resetting (#37671)
      dom
    - https://github.com/servo/servo/pull/37653    (@arihant2math@gmail.com, #37653)    [IndexedDB] Fix upgrade version operation (#37653)
      dom
    - https://github.com/servo/servo/pull/37620    (@sagudev, #37620)    Make ImageData more spec compliant (#37620)
      dom
    - https://github.com/servo/servo/pull/37692    (@andrei.volykhin@gmail.com, #37692)    canvas: Add CanvasTransform 'setTransform(transform)' method (#37692)
      dom
    - https://github.com/servo/servo/pull/37672    (@mrobinson, #37672)    script: Pass more information to the `MouseEvent` constructor (#37672)
      dom
    - https://github.com/servo/servo/pull/37704    (@simonwuelker, #37704)    Determine the initial state for fragment parsing using the scripting flag of the context element (#37704)
      dom
    - https://github.com/servo/servo/pull/37731    (@andrei.volykhin@gmail.com, #37731)    canvas: Add CanvasPattern 'setTranform(transform)' method (#37731)
      dom
    - https://github.com/servo/servo/pull/37634    (@andrei.volykhin@gmail.com, #37634)    imagebitmap: Add 'none' image orientation option (#37634)
      dom
- embedding
    - https://github.com/servo/servo/pull/35901    (@shubhamg13, @xiaochengh, #35901)    Add support for parsing and applying `viewport` `<meta>`  (#35901)
      embedding
    - https://github.com/servo/servo/pull/37317    (@Legend-Master, #37317)    libservo: Allow embedders to signal when the cursor has left the `WebView` (#37317)
      embedding
    - https://github.com/servo/servo/pull/37580    (@wusyong, #37580)    constellation: add multiprocess support on Windows (#37580)
      embedding
    - https://github.com/servo/servo/pull/37524    (@CarePackage17, #37524)    Upgrade version of Android in default user agent string (#37524)
      embedding
    - https://github.com/servo/servo/pull/36714    (@longvatrong111, #36714)    [webdriver] Move Webdriver to ServoShell (#36714)
      embedding
- layout
    - https://github.com/servo/servo/pull/37186    (@mrobinson, @Loirooriol, #37186)    script: Allow reflows that do not produce display lists (#37186)
      layout
    - https://github.com/servo/servo/pull/37211    (@simonwuelker, #37211)    Implement the `size` presentational hint for `<hr>` elements (#37211)
      layout
    - https://github.com/servo/servo/pull/37252    (@Loirooriol, #37252)    layout: Force outside ::marker to establish a BFC (#37252)
      layout
    - https://github.com/servo/servo/pull/34948    (@nicoburns, #34948)    CSS Grid: percentage sizing fixes (#34948)
      layout
    - https://github.com/servo/servo/pull/37307    (@simonwuelker, #37307)    Support `::part` selector (#37307)
      layout
    - https://github.com/servo/servo/pull/37380    (@Loirooriol, @mrobinson, #37380)    Have transform and related changes conditionally trigger only overflow damage (#37380)
      layout
    - https://github.com/servo/servo/pull/37362    (@Loirooriol, #37362)    layout: Floor free space by 0 in solve_inline_margins_avoiding_floats() (#37362)
      layout
    - https://github.com/servo/servo/pull/37412    (@mrobinson, #37412)    compositor: Do not allow script to scroll beyond node boundaries (#37412)
      layout
    - https://github.com/servo/servo/pull/37457    (@Loirooriol, #37457)    layout: Properly handle intrinsic min/max block sizes on replaced element (#37457)
      layout
    - https://github.com/servo/servo/pull/37464    (@Loirooriol, #37464)    layout: Ensure that min/max-content sizes ignore sizing properties (#37464)
      layout
    - https://github.com/servo/servo/pull/37475    (@mrobinson, #37475)    layout: Unify scrollable overflow calculation and include `position: absolute` (#37475)
      layout
    - https://github.com/servo/servo/pull/37507    (@mrobinson, @Loirooriol, #37507)    compositor: Always send an animating tick when a pipeline starts animating (#37507)
      layout
    - https://github.com/servo/servo/pull/37708    (@Loirooriol, #37708)    layout: Let `align-content: stretch` fall back to `unsafe flex-start` (#37708)
      layout
    - https://github.com/servo/servo/pull/37677    (@mrobinson, @Loirooriol, #37677)    script|layout: Do not force restyle when doing script queries (#37677)
      layout
- media
    - https://github.com/servo/servo/pull/37002    (@andrei.volykhin@gmail.com, #37002)    htmlmediaelement:  Fix fetch request race on "seek-data" event (#37002)
      media
    - https://github.com/servo/servo/pull/37264    (@andrei.volykhin@gmail.com, #37264)    htmlmediaelement: Support seek requests for non seekable fetch context (#37264)
      media
    - https://github.com/servo/servo/pull/37533    (@andrei.volykhin@gmail.com, @mrobinson, #37533)    htmlvideoelement: Fix poster frame processing algorithm (#37533)
      media
- network
    - https://github.com/servo/servo/pull/37277    (@TimvdLippe, #37277)    Fix Sec-Fetch-Site header (#37277)
      network
- servoshell
    - https://github.com/servo/servo/pull/37228    (@mrobinson, #37228)    servoshell: Fallback to light theme when initializing `egui` (#37228)
      servoshell
    - https://github.com/servo/servo/pull/36891    (@Narfinger, @jschwe, #36891)    Allow OHOS servoshell to have a simple multiple tab implementation. (#36891)
      servoshell
    - https://github.com/servo/servo/pull/37519    (@jdm, #37519)    servoshell: Enable accesskit integration. (#37519)
      servoshell
- stability
    - https://github.com/servo/servo/pull/37215    (@Narfinger, #37215)    Hitrace-bench will now report simple memory results to bencher.dev. (#37215)
      stability
    - https://github.com/servo/servo/pull/37239    (@simonwuelker, #37239)    Keep `winit::Window` alive until all rendering contexts are destroyed (#37239)
      stability
    - https://github.com/servo/servo/pull/37085    (@longvatrong111, #37085)    Add retry for hit tests with expired epoch in result (#37085)
      stability
    - https://github.com/servo/servo/pull/37261    (@willypuzzle, #37261)    [#26488] Moves the FetchCanceller to a separate droppable struct, in Event Source (#37261)
      stability
    - https://github.com/servo/servo/pull/37080    (@webbeef, #37080)    Use a VecDeque to manage timers (#37080)
      stability
    - https://github.com/servo/servo/pull/37310    (@willypuzzle, #37310)    [#26499] Refactors HTMLMediaElement drop logic (#37310)
      stability
    - https://github.com/servo/servo/pull/37195    (@jschwe, #37195)    mach: Add TSAN support (#37195)
      stability
    - https://github.com/servo/servo/pull/37332    (@willypuzzle, #37332)    [#26488] Refactored RTCDataChannel for safer dropping and added Promise comment (#37332)
      stability
    - https://github.com/servo/servo/pull/37459    (@webbeef, #37459)    Fix panic in formelement.rs (#37459)
      stability
    - https://github.com/servo/servo/pull/37460    (@wusyong, @yuweiwu@YunoMacBook-Air.local, #37460)    canvas: prevent unwrap on offscreen canvas (#37460)
      stability
    - https://github.com/servo/servo/pull/37505    (@mrobinson, @Loirooriol, #37505)    compositor: Wait for both Script and the Constellation when shutting down Pipelines (#37505)
      stability
    - https://github.com/servo/servo/pull/37534    (@mrobinson, #37534)    layout: Do not add empty border images to the display list (#37534)
      stability
    - https://github.com/servo/servo/pull/37512    (@willypuzzle, #37512)    [#26488] Improves WebGLBuffer drop impl (#37512)
      stability
    - https://github.com/servo/servo/pull/37628    (@jschwe, @mrobinson, #37628)    resource_thread: Optimize writing JSON (#37628)
      stability
    - https://github.com/servo/servo/pull/37589    (@willypuzzle, #37589)    [#26488] Refactors WebGLFramebuffer deletion (#37589)
      stability
    - https://github.com/servo/servo/pull/37551    (@mrobinson, #37551)    canvas: Don't do operations on paths with uninvertible transforms (#37551)
      stability
    - https://github.com/servo/servo/pull/37691    (@Narfinger, #37691)    script: Do not run garbage collection when shutting down a Pipeline (#37691)
      stability
    - https://github.com/servo/servo/pull/37765    (@sagudev, #37765)    Lazily initialize canvas paint thread in constellation (#37765)
      stability
    - https://github.com/servo/servo/pull/37666    (@Narfinger, @jschwe, #37666)    OHOS: Run speedometer in CI (#37666)
      stability
- upgrade
    - https://github.com/servo/servo/pull/37444    (@Loirooriol, #37444)    Upgrade Stylo to 2025-06-03 (#37444)
      upgrade
- webdriver
    - https://github.com/servo/servo/pull/37213    (@yezhizhen, #37213)    script: Upgrade `node_ids` to `pipeline_to_node_ids` to track the owner pipeline of the node (#37213)
      webdriver
    - https://github.com/servo/servo/pull/37095    (@longvatrong111, #37095)    Fix webdriver wait for response from constellation (#37095)
      webdriver
    - https://github.com/servo/servo/pull/37153    (@longvatrong111, #37153)    Implement actions_by_tick for webdriver (#37153)
      webdriver
    - https://github.com/servo/servo/pull/37224    (@kenzieradityatirtarahardja18@gmail.com, #37224)    Implement wb element send keys for file input (#37224)
      webdriver
    - https://github.com/servo/servo/pull/37280    (@longvatrong111, #37280)    [webdriver] Implement get shadow root (#37280)
      webdriver
    - https://github.com/servo/servo/pull/37385    (@yezhizhen, #37385)    [WebDriver] Properly report error: "No such window" (#37385)
      webdriver
    - https://github.com/servo/servo/pull/37393    (@yezhizhen, #37393)    [WebDriver: Dispatch Action] Check if browsing context still open for each tick action (#37393)
      webdriver
    - https://github.com/servo/servo/pull/37260    (@kenzieradityatirtarahardja18@gmail.com, #37260)    [webdriver] Add synchronization for wheel action (#37260)
      webdriver
    - https://github.com/servo/servo/pull/37406    (@yezhizhen, #37406)    [WebDriver] Improve some session/window handling (#37406)
      webdriver
    - https://github.com/servo/servo/pull/37423    (@longvatrong111, #37423)    Wait enough time for tick duration in webdriver dispatch actions (#37423)
      webdriver
    - https://github.com/servo/servo/pull/37411    (@longvatrong111, #37411)    Verify `webview` still open in webdriver switch frame command (#37411)
      webdriver
    - https://github.com/servo/servo/pull/37470    (@yezhizhen, #37470)    script: Support webdriver's Get Element Text operation for non-HTML elements (#37470)
      webdriver
    - https://github.com/servo/servo/pull/37425    (@yezhizhen, #37425)    [WebDriver] Improve get active element (#37425)
      webdriver
    - https://github.com/servo/servo/pull/37452    (@yezhizhen, #37452)    [WebDriver] Properly report error for `find_element` & `find_elements`; Get correct visible text when matching links (#37452)
      webdriver
    - https://github.com/servo/servo/pull/37502    (@yezhizhen, #37502)    script::webdriver_handlers: Replace `find_node_by_unique_id` with `get_known_element` (#37502)
      webdriver
    - https://github.com/servo/servo/pull/37532    (@yezhizhen, #37532)    script::webdriver_handler: Fully implement `get_known_element` (#37532)
      webdriver
    - https://github.com/servo/servo/pull/37403    (@kenzieradityatirtarahardja18@gmail.com, #37403)    [WebDriver] Add synchronization for key action (#37403)
      webdriver
    - https://github.com/servo/servo/pull/37521    (@yezhizhen, #37521)    `webdriver_server`: Implement find element(s) from element according to spec (#37521)
      webdriver
    - https://github.com/servo/servo/pull/37624    (@yezhizhen, #37624)    [WebDriver: Release Action] Fix panic by work around buggy spec (#37624)
      webdriver
    - https://github.com/servo/servo/pull/37578    (@yezhizhen, #37578)    [WebDriver] Implement "Find Element(s) From ShadowRoot" (#37578)
      webdriver
    - https://github.com/servo/servo/pull/37484    (@longvatrong111, #37484)    Implement webdriver release action (#37484)
      webdriver
    - https://github.com/servo/servo/pull/37546    (@yezhizhen, #37546)    script::webdriver_handlers: Implement "get a known shadow root" (#37546)
      webdriver
    - https://github.com/servo/servo/pull/37632    (@yezhizhen, #37632)    [WebDriver] Grant `top_level_script_command` and `browsing_context_script_command` freedom to not verify existence of pipeline (#37632)
      webdriver
    - https://github.com/servo/servo/pull/37685    (@yezhizhen, #37685)    [WebDriver] Fully implement "switch to (parent) frame" (#37685)
      webdriver
    - https://github.com/servo/servo/pull/37284    (@yezhizhen, #37284)    servoshell: Do not focus and raise new auxiliary WebDriver-created `WebView`s  (#37284)
      webdriver
-->

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
