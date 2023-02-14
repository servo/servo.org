---
layout: default.html
title: Blog
pagination:
  data: collections.blog
  size: 10
  alias: posts
  reverse: true
---

<div style="float: right;">
  <a href="{{ '/blog/feed.xml' | url }}"><span class="icon"><i class="fas fa-rss"></i></span> Feed</a>
</div>

# {{ title }}


{% for post in posts %}
<div class="has-top-margin">
  <h2 class="title"><a href="{{ post.url | url }}">{{ post.data.title }}</a></h2>
  <p class="subtitle"><span class="tag is-dark">{{ post.data.date | date: "%Y-%m-%d" }}</span> {{ post.data.summary }}</p>
</div>

{% endfor %}

<div class="has-top-margin buttons has-addons">
{% if pagination.href.previous %}<a class="button" href="{{ pagination.href.previous }}">Previous</a>{% else %}{% endif %}
{% if pagination.href.next %}<a class="button" href="{{ pagination.href.next }}">Next</a>{% else %}{% endif %}
</div>
