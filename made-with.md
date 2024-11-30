---
layout: default.html
title: Made With
---

# Made with Servo

This page showcases projects that are built on Servo or Servo components

## Browsers & Webviews


<div class="columns is-multiline" style="padding: 12px; gap: 32px;">

  {% for project in madewith %}

  <div class="column" style="width: 400px; height: 400px; flex: 1 0 400px; border: 2px solid white">

## {{ project.name }}

* Click the macOS download button above to download the latest build
* Open the downloaded `servo-latest.dmg` file

  </div>

  {% endfor %}
</div>

## Made with Servo Components
