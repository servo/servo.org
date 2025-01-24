---
layout: default.html
title: Blog
pagination:
  data: collections.blog
  size: 10
  alias: posts
  reverse: true
---
<div class="inner-container">

  <div class="blog-head">

  # {{ title }}

    <a href="{{ '/blog/feed.xml' | url }}"><span class="icon"><i class="fas fa-rss"></i></span> RSS Feed</a>

  </div>



  {% for post in posts %}
  <div class="card">
    <span class="tag is-dark">{{ post.data.date | date: "%Y-%m-%d" }}</span> 
    <h2 class="title"><a href="{{ post.url | url }}">{{ post.data.title }}</a></h2>
    <p class="summary">{{ post.data.summary }}</p>
  </div>

  {% endfor %}

  <div class="buttons">
  {% if pagination.href.previous %}<a class="button" href="{{ pagination.href.previous }}">Previous</a>{% else %}{% endif %}
  {% if pagination.href.next %}<a class="button" href="{{ pagination.href.next }}">Next</a>{% else %}{% endif %}
  </div>

</div>
