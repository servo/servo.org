---
layout: default.html
title: Made With Servo
---

<style type="text/css">

.made-with-container {
  gap: 20px;
  display: flex;
  flex-wrap: wrap;
  justify-content: start;
  margin-bottom: 3rem;
}

.made-with-container::last-child {
  margin-bottom: 0;
}

.made-with-item {
  display: block;
  width: 400px;
  max-width: 100%;
  flex: 0 0 400px;
  border: 2px solid var(--dark-grey);
  cursor: pointer;
  color: inherit;
  text-decoration: inherit;
}

.made-with-item:hover {
  background-color: #EAEAEA;
}

.made-with-text {
  padding: 1.25rem;
}

.made-with-text > p {
  padding: 0;
}

.made-with-image {
  aspect-ratio: 2;
  object-fit: cover;
  object-position: top left;
  background-color: transparent;
}

</style>

<div class="inner-container subpage-content fullwidth">

<h1>{{ title }}</h1>
<p class="subtitle">
  This page showcases projects that are built with Servo or Servo components.
</p>

{% for group in madewith %}

## {{group.name}}

<div class="made-with-container">
  {% assign projects = group.projects | sort_natural: "name" %}
  {% for project in projects %}
  <a class="made-with-item" href="{{project.link}}" target="_blank">
    {% if project.img %}<img src="{{ project.img | url }}" class="made-with-image" alt=" " />{% endif %}
    <div class="made-with-text">
      <h3>{{ project.name }}</h3>
      <p>{{ project.description }}</p>
    </div>
  </a>{% endfor %}
</div>

{% endfor %}


</div>