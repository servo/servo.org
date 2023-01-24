---
layout: download.html
title: Download
---

## macOS Instructions

* Click the macOS download button above to download the latest build
* Open the downloaded `servo-latest.dmg` file
* Drag `Servo.app` to the Applications folder
* Double-click on `Servo.app` to run Servo

**Note**: `Servo.app` is not currently signed, so Mac users may have a popup saying "Servo can’t be opened because it is from an unidentified developer." If the popup lacks a "proceed anyway" option, close it then right-click `Servo.app` and click "Open." This time the popup will have an option to proceed opening the application.

## Linux Instructions

* Click the Linux download button above to download the latest build
* Expand the downloaded `.tar.gz` file (`tar zxf servo-latest.tar.gz`)
* `cd servo`
* Execute `./servo` to run Servo

### Troubleshooting

**Error**: `./servo: error while loading shared libraries: libgstwebrtc-1.0.so.0: cannot open shared object file: No such file or directory`

**Solution**: `sudo apt install libgstreamer-plugins-bad1.0`

**Error**: `./servo: symbol lookup error: ./servo: undefined symbol: gst_webrtc_data_channel_state_get_type`

**Solution**: make sure that you have GStreamer version 1.16 (or greater) and gst-plugins-bad version 1.16 (or greater)

