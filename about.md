---
layout: default.html
title: About
---

<div class="inner-container subpage-content">

<h1>{{ title }}</h1>
  <p class="subtitle">
    Servo aims to provide an <strong>independent, modular, embeddable web rendering engine</strong>, allowing developers to deliver content and applications using web standards.
  </p>
<br>

Created by Mozilla Research in 2012, the Servo project is a research and development effort. Stewardship of Servo moved from Mozilla Research to the [**Linux Foundation**](https://www.linuxfoundation.org/) in 2020, where its mission remains unchanged. In 2023 the project moved to [**Linux Foundation Europe**](https://linuxfoundation.eu/).

Servo is written in [**Rust**](https://www.rust-lang.org/), taking advantage of the memory safety properties and concurrency features of the language.

Since its creation in 2012, Servo has contributed to W3C and WHATWG web standards, reporting specification issues and submitting new cross-browser automated tests, and core team members have co-edited new standards that have been adopted by other browsers. As a result, the Servo project helps drive the entire web platform forward, while building on a platform of reusable, modular technologies that implement web standards.

## Roadmap

Servo's roadmap is defined in the project wiki: <https://github.com/servo/servo/wiki/Roadmap>

## Presentations

<section class="section container" aria-label="Latest talks about Servo">
  <div class="blog">
    <div class="inner-container">
      <h2>Latest talks about Servo</h2>
        <div class="blog-grid">
            {% for talk in talks limit:5 %}<div class="card">
                  <div class="card-content">
                    {% if talk.youtube_id %}<div class="card-image">
                      <iframe src="https://www.youtube.com/embed/{{ talk.youtube_id }}" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
                    </div>{% endif %}<span class="tag">
                      {{ talk.date }}
                      {% if talk.event %}<span class="tag">at <a href="{{ talk.event_url }}">{{ talk.event }}</a></span>{% endif %}
                    </span>
                    <p class="post-title"><a href="{{ talk.url }}">{{ talk.title }}</a></p>
                    <p class="post-summary">by {{ talk.authors }}</p>
                  </div>
                </div>{% endfor %}
        </div>
      </div>
  </div>
</section>

{% for talk in talks offset:5 %}
* [{{ talk.title }}]({{ talk.url }}) by {{ talk.authors }} ({{ talk.date }}{% if talk.event %} at [{{ talk.event }}]({{ talk.event_url }}){% endif %}){% endfor %}

## Logo

Servo logo can be found at <https://github.com/servo/project/tree/master/logo>.

</div>