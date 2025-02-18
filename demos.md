---
layout: default.html
title: Demos
---
<style>

.experiments-container {
  font-size: 20px;
  margin-bottom: 40px;
}
.experiments-group {
  margin: auto;
  margin-top: 10px;
  width: 100%;
  clear: both;
}
.experiment-previews {
  text-align: left;
  clear: both;
}

.experiment-preview {
  display: inline-block;
  padding: 20px;
  margin: 20px;
  transition: opacity 0.5s ease-in-out, background-color 0.25s ease-in-out;
  text-align: center;
  box-shadow: 3px 3px 5px #7c7c7c;
  background-color: #dceff6;
  vertical-align: top;
}

.experiment-preview a {
  text-decoration: none;
  color: initial;
}
.experiment-preview h2 {
  font-weight: bold;
  margin-bottom: 15px;
}

.experiment-preview:hover {
  background-color: #a4e6ff;
}

.experiment-preview .experiment-desc {
  width: 256px;
  text-align: left;
}
</style>
<div class="inner-container wpt-score-page">
  <h1>{{ title }}</h1>
  <p class="subtitle">
    This page contains a number of demonstrations of Servo's rendering capabilities. The source code for these demos live in the <a href="https://github.com/servo/servo-experiments" target="_blank">servo-experiments</a> repo.
  </p>

  <main class="experiments-container">
      <section class="experiments-group" id="other-experiments">
          <h2 class="heading">Servo Experiments</h2>
          <div class="experiment-previews"></div>
      </section>
      <section class="experiments-group" id="technical-tests">
          <h2 class="heading">Servo Technical Tests</h2>
          <div class="experiment-previews"></div>
      </section>
      <section class="experiments-group" id="videos">
          <h2 class="heading">Servo Videos</h2>
          <div class="experiment-previews"></div>
      </section>
  </main>
</div>
<script type="text/javascript" src="{{ '/js/load-demos.js' | url }}"></script>