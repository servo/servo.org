---
layout: download.html
title: Download
---

<div class="columns">
  <div class="column">

## macOS Instructions

* Click the macOS download button above to download the latest build
* Open the downloaded `servo-latest.dmg` file
* Drag `Servo.app` to the Applications folder
* Double-click on `Servo.app` to run Servo

### Troubleshooting

*Note*: `Servo.app` is not currently signed, Mac users may be unable to open the application.

**Error**: Dialogue stating "Servo can’t be opened because it is from an unidentified developer."

**Solution**: Right-click `Servo.app` and choose "Open." The dialogue may now allow Servo to be opened.

**Error**: Dialogue stating '“Servo.app” Not Opened'

**Solution** Dismiss the dialogue with "Done" and remove the quarantine attribute from Servo: `xattr -r -d com.apple.quarantine /Applications/Servo.app`

  </div>
  <div class="column">

## Linux Instructions

* Click the Linux download button above to download the latest build
* Expand the downloaded `.tar.gz` file (`tar zxf servo-latest.tar.gz`)
* `cd servo`
* Execute `./servo` to run Servo

### Troubleshooting

**Error**: `./servo: error while loading shared libraries: libgstwebrtc-1.0.so.0: cannot open shared object file: No such file or directory`

**Solution**: `sudo apt install libgstreamer-plugins-bad1.0-0`

**Error**: `./servo: symbol lookup error: ./servo: undefined symbol: gst_webrtc_data_channel_state_get_type`

**Solution**: make sure that you have GStreamer version 1.16 (or greater) and gst-plugins-bad version 1.16 (or greater)

**Error**: `./servo: error while loading shared libraries: libunwind-x86_64.so.8: cannot open shared object file: No such file or directory`

**Solution**: make sure that you have libunwind installed

  </div>
</div>

<style>

.subpage-content div + div {
  padding-top: .5rem;
}

</style>